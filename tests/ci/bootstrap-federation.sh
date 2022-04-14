#!/bin/bash
# Bootstrap script that either sets up a fresh XDMoD test instance or upgrades
# an existing one.  This code is only designed to work inside the XDMoD test
# docker instances. However, since it is designed to test a real install, the
# set of commands that are run would work on a real production system.

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REF_SOURCE=`realpath $BASEDIR/../artifacts`
REF_DIR=/var/tmp
XDMOD_DIR=/root/xdmod

if [ -z $XDMOD_REALMS ]; then
    export XDMOD_REALMS=jobs,storage,cloud
fi

federation_instances_jobs=("test1_example_com" "test2_example_com" "test3_example_com")
federation_instances_cloud=("test3_example_com" "test4_example_com")
CURRENTDATE=$(date +'%F')

function copy_template_httpd_conf {
    cp /usr/share/xdmod/templates/apache.conf /etc/httpd/conf.d/xdmod.conf
}

rm -rf /var/tmp/artifacts
cp -r $REF_SOURCE /var/tmp/

set -e
set -o pipefail

if [ "$XDMOD_TEST_MODE" = "fresh_install" ];
then

    rpm -qa | grep ^xdmod | xargs yum -y remove || true
    rm -rf /etc/xdmod

    rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql
    yum -y install ~/rpmbuild/RPMS/*/*.rpm
    copy_template_httpd_conf
    ~/bin/services start
    mysql -e "CREATE USER 'root'@'gateway' IDENTIFIED BY '';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'gateway' WITH GRANT OPTION;
    FLUSH PRIVILEGES;"

    expect $XDMOD_DIR/tests/ci/scripts/xdmod-setup-start.tcl | col -b
    expect $XDMOD_DIR/open_xdmod/modules/federated/tests/ci/scripts/xdmod-federated-setup-start.tcl | col -b
    expect $XDMOD_DIR/tests/ci/scripts/xdmod-setup-finish.tcl | col -b

    for instance in "${federation_instances_jobs[@]}"; do
        modw_db=${instance}-modw
        instance_id=`mysql -s -N -e "SELECT federation_instance_id FROM modw.federation_instances WHERE prefix = '$instance'"`

        if [ ! -f "$REF_DIR/artifacts/federation-instance-data/jobs/dimensions/${instance}.sql" ]; then
            gunzip $REF_DIR/artifacts/federation-instance-data/jobs/dimensions/${instance}.sql.gz
        fi

        if [ ! -f "$REF_DIR/artifacts/federation-instance-data/jobs/facts/${instance}.sql" ]; then
            gunzip $REF_DIR/artifacts/federation-instance-data/jobs/facts/${instance}.sql.gz
        fi

        mysql $modw_db < $REF_DIR/artifacts/federation-instance-data/jobs/dimensions/${instance}.sql
        mysql $modw_db < $REF_DIR/artifacts/federation-instance-data/jobs/facts/${instance}.sql

        /usr/share/xdmod/tools/etl/etl_overseer.php -p fed.ingest-resources -d instance_name="$instance" -d instance_id=$instance_id
        /usr/share/xdmod/tools/etl/etl_overseer.php -p fed.ingest -d instance_name="$instance" -d instance_id=$instance_id --last-modified-start-date "2021-01-01 00:00:00" -v debug

        mysql -e "truncate table \`$modw_db\`.\`job_tasks_staging\`"
        mysql -e "truncate table \`$modw_db\`.\`job_records_staging\`"
    done

    for instance in "${federation_instances_cloud[@]}"; do
        modw_cloud_db=${instance}-modw_cloud
        instance_id=`mysql -s -N -e "SELECT federation_instance_id FROM modw.federation_instances WHERE prefix = '$instance'"`

        if [ ! -f "$REF_DIR/artifacts/federation-instance-data/cloud/dimensions/${instance}.sql" ]; then
            gunzip $REF_DIR/artifacts/federation-instance-data/cloud/dimensions/modw-cloud/${instance}.sql.gz
        fi

        mysql $modw_cloud_db < $REF_DIR/artifacts/federation-instance-data/cloud/dimensions/modw-cloud/${instance}.sql
        mysql $modw_cloud_db < $REF_DIR/artifacts/federation-instance-data/cloud/facts/${instance}.sql

        if [ -f "$REF_DIR/artifacts/federation-instance-data/cloud/dimensions/modw/${instance}.sql" ]; then
            mysql ${instance}-modw < $REF_DIR/artifacts/federation-instance-data/cloud/dimensions/modw/${instance}.sql
        fi

        /usr/share/xdmod/tools/etl/etl_overseer.php -p fed.ingest-resources -d instance_name="$instance" -d instance_id=$instance_id
        /usr/share/xdmod/tools/etl/etl_overseer.php -p xdmod.jobs-cloud-common
        /usr/share/xdmod/tools/etl/etl_overseer.php -p fed.ingest-cloud -d instance_name="$instance" -d instance_id=$instance_id --last-modified-start-date "2021-01-01 00:00:00" -v debug
    done

    /usr/share/xdmod/tools/etl/etl_overseer.php -p ingest-resource-types
    xdmod-ingestor --aggregate=job --last-modified-start-date "$CURRENTDATE 00:00:00"
    xdmod-ingestor --aggregate=cloud --last-modified-start-date "$CURRENTDATE 00:00:00"

    php /root/xdmod/tests/ci/scripts/create_xdmod_users.php
    /usr/bin/acl-config

fi

if [ "$XDMOD_TEST_MODE" = "upgrade" ];
then
    expect $BASEDIR/scripts/xdmod-upgrade.tcl | col -b
fi
