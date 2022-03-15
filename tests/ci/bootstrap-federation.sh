#!/bin/bash
# Bootstrap script that either sets up a fresh XDMoD test instance or upgrades
# an existing one.  This code is only designed to work inside the XDMoD test
# docker instances. However, since it is designed to test a real install, the
# set of commands that are run would work on a real production system.

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REF_DIR=/var/tmp/instance-data


if [ -z $XDMOD_REALMS ]; then
    export XDMOD_REALMS=jobs,storage,cloud
fi

federation_instances=("test1_example_com" "test2_example_com" "test3_example_com" "test4_example_com")
CURRENTDATE=$(date +'%F')

set -e
set -o pipefail

if [ "$XDMOD_TEST_MODE" = "fresh_install" ];
then
    ~/bin/services start
    expect /tmp/scripts/xdmod-federated-setup-start.tcl | col -b

    for instance in $federation_instances; do
        modw_table=${instance}-modw
        instance_id=`mysql -s -N -e "SELECT federation_instance_id FROM modw.federation_instances WHERE prefix = '$instance'"`

        mysql $modw_table < $REF_DIR/dimensions/${instance}.sql
        mysql $modw_table < $REF_DIR/facts/${instance}.sql

        mysql -e "alter table \`$modw_table\`.\`jobhosts\` add index job_id_idx(job_id);"

        /usr/share/xdmod/tools/etl/etl_overseer.php -p fed.ingest -d instance_name="$instance" -d instance_id=$instance_id --last-modified-start-date "$CURRENTDATE 00:00:00" -v debug

        mysql -e "truncate table \`$modw_table\`.\`job_tasks_staging\`"
        mysql -e "truncate table \`$modw_table\`.\`job_records_staging\`"
    done

    xdmod-ingestor --last-modified-start-date "$CURRENTDATE 00:00:00"

fi

if [ "$XDMOD_TEST_MODE" = "upgrade" ];
then
    expect $BASEDIR/scripts/xdmod-upgrade.tcl | col -b
fi
