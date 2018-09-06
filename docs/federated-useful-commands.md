---
title: Useful Commands
---

## Specific Service status

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} status"
```

## Status of filters

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl status -name stages"
```

## [Recovering from errors][trterrors]

### Skip sequence number

```bash
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} status"
# find
# pendingError           : NONE
# pendingErrorCode       : NONE
# pendingErrorEventId    : NONE
# pendingErrorSeqno      : -1
sudo su - tungsten -c "/opt/continuent/tungsten/tungsten-replicator/bin/trepctl -service {instance.fqdn . and - replaced with underscore} online -skip-seqno <NUM>"
```
### Completely reset instance

On the hub:
```bash
tungsten-replicator/bin/trepctl -service ServiceName offline
tungsten-replicator/bin/trepctl -service ServiceName reset
```

On the instance:
Dump the modw database
```bash
mysqldump --defaults-file ~/.my.cnf modw > instance.fqdn.modw.sql
```

```bash
tungsten-replicator/bin/trepctl -service ServiceName offline
tungsten-replicator/bin/trepctl -service ServiceName reset
tungsten-replicator/bin/trepctl -service ServiceName online
```

On the hub:
import the database dump from the instance (having copied it from the instance)

```bash
mysql {instnace.fqdn with . replaced with -}-modw < instance.fqdn.modw.sql
```

```bash
tungsten-replicator/bin/trepctl -service ServiceName online
```

## Change Configuration of a instance

If you want to replicate more or less data

```bash
/opt/continuent/tungsten/tools/tpm update --repl-svc-extractor-filters=replicate --property=replicator.filter.replicate.ignore='moddb,mod_logger,mod_shredder,mod_hpcdb,modw_aggregates,modw_filters,modw.tmp*'
```

## Logs

```bash
tail -f /opt/continuent/tungsten/tungsten-replicator/log/* | egrep -v "BufferedFileDataInput| Protocol Received protocol heartbeat|DEBUG LogConnection|DEBUG LogFile Reading log file position"
```

[trterrors]: http://docs.continuent.com/tungsten-replicator-5.0/operations-transactions-ident.html
