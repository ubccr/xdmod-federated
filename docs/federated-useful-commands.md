# Useful commands

### Specific Service status

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} status"
```

i.e.

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} status"
```

### Status of filters

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl status -name stages"
```

### [Recovering from errors][trterrors]

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} status"
# find
# pendingError           : NONE
# pendingErrorCode       : NONE
# pendingErrorEventId    : NONE
# pendingErrorSeqno      : -1
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} online -skip-seqno <NUM>"
```

i.e.

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} status"
# find
# pendingError           : NONE
# pendingErrorCode       : NONE
# pendingErrorEventId    : NONE
# pendingErrorSeqno      : -1
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} online -skip-seqno <NUM>"
```

### Change Configuration of a instance

If you want to replicate more or less data

```bash
/opt/continuent/tungsten/tools/tpm update --repl-svc-extractor-filters=replicate --property=replicator.filter.replicate.ignore='mod_logger,mod_shredder,mod_hpcdb,modw_aggregates,modw_filters,modw.tmp*'
```

### Logs

```bash
tail -f /opt/continuent/tungsten/tungsten-replicator/log/* | egrep -v "BufferedFileDataInput| Protocol Received protocol heartbeat|DEBUG LogConnection|DEBUG LogFile Reading log file position"
```

[trterrors]: http://docs.continuent.com/tungsten-replicator-5.0/operations-transactions-ident.html
