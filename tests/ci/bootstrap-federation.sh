#!/bin/bash
# Bootstrap script that either sets up a fresh XDMoD test instance or upgrades
# an existing one.  This code is only designed to work inside the XDMoD test
# docker instances. However, since it is designed to test a real install, the
# set of commands that are run would work on a real production system.

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REF_DIR=/var/tmp/federation-instance-data


if [ -z $XDMOD_REALMS ]; then
    export XDMOD_REALMS=jobs,storage,cloud
fi

federation_instances=("test1_example_com" "test2_example_com" "test3_example_com")
CURRENTDATE=$(date +'%F')

function copy_template_httpd_conf {
    cp /usr/share/xdmod/templates/apache.conf /etc/httpd/conf.d/xdmod.conf
}

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

    expect /root/xdmod/tests/ci/scripts/xdmod-setup-start.tcl | col -b
    expect /tmp/scripts/xdmod-federated-setup-start.tcl | col -b
    expect /root/xdmod/tests/ci/scripts/xdmod-setup-finish.tcl | col -b

    for instance in "${federation_instances[@]}"; do
        modw_table=${instance}-modw
        instance_id=`mysql -s -N -e "SELECT federation_instance_id FROM modw.federation_instances WHERE prefix = '$instance'"`

        mysql $modw_table < $REF_DIR/dimensions/${instance}.sql
        mysql $modw_table < $REF_DIR/facts/${instance}.sql

        /usr/share/xdmod/tools/etl/etl_overseer.php -p fed.ingest -d instance_name="$instance" -d instance_id=$instance_id --last-modified-start-date "$CURRENTDATE 00:00:00" -v debug

        mysql -e "truncate table \`$modw_table\`.\`job_tasks_staging\`"
        mysql -e "truncate table \`$modw_table\`.\`job_records_staging\`"
    done

    /usr/share/xdmod/tools/etl/etl_overseer.php -p ingest-resource-types
    xdmod-ingestor --aggregate=job --last-modified-start-date "$CURRENTDATE 00:00:00"

fi

if [ "$XDMOD_TEST_MODE" = "upgrade" ];
then
    expect $BASEDIR/scripts/xdmod-upgrade.tcl | col -b
fi
