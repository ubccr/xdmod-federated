# Installation

## [Prerequisites][trprereqs]

**TODO: Turn this into a script**

Follow directions for the tungsten prerequisites [prerequisites][trprereqs] The following settings are required for each database in the federation:

```text
-   binlog-format = row
-   log-bin-trust-function-creators = 1

    -   SET GLOBAL log_bin_trust_function_creators = 1;

-   server-id = 1

    -   each server must be different
```

### Initialize Hub Database

The Hub database needs to have all of the same tables and structure of the instances.

Use the xdmod-setup script initialize the Hub Database

#### Create SQL for Instance Initialization

Create instance databases on Hub

**(replacing instance\d.fqdn with the fqdn of the instance(s))**

```bash
assets/scripts/xdmod-fed-create-instance-sql.sh -b instance1.fqdn[,instance2.fqdn,...]
```

### Prepare for replication using tungsten

#### Hub Server

##### Create tungsten user(s) and generate RSA key

**You really should change the password in the file before running** **TODO: options for password retrieval (SESSION or argument)**

```bash
assets/scripts/tungsten-add-user.sh
```

##### Tungsten Prerequisites (for the Hub)

**TODO: when building as RPM put java and ruby into deps**

```bash
assets/scripts/tungsten-prereqs.sh
```

##### Download and extract tungsten

```bash
assets/scripts/tungsten-download.sh -v 5.0.1 -r 138
```

#### Instances

##### Tungsten Prerequisites (for the instances)

```bash
assets/scripts/tungsten-prereqs.sh
```

##### Setup Tungsten user (skipping key generation)

**You really should change the password in the file before running** **TODO: options for password retrieval (SESSION or argument)**

```bash
assets/scripts/tungsten-add-user.sh -k
```

**TODO: Automate this?**

Copy the public (~tungsten/.ssh/id_rsa.pub), private key (~tungsten/.ssh/id_rsa), and authorized keys (~tungsten/.ssh/authorized_keys) from the Hub server to the ~/tungsten/.ssh directory.

## Configuring tungsten for [Fan-In][trfanin] Replication

### Hub Server

### Set Tungsten defaults

**The replication-password should be changed to what it was changed to in previous steps (You did change it didn't you?)** **TODO: options for password retrieval (SESSION or argument)**

```bash
assets/scripts/tungsten-set-defaults.sh
```

### Configuring the xdmodfederation service

**(replacing instance\d.fqdn with the fqdn of the instance(s))**

```bash
assets/scripts/tungsten-config-federation.sh -c hub.fqdn -b instance1.fqdn[,instance2.fqdn,...]
```

### Configuring database rename

**(replacing instance\d.fqdn with the fqdn of the instance(s))**

```bash
assets/scripts/tungsten-config-instances.sh -b instance1.fqdn[,instance2.fqdn,...]
```

#### Validate and install Tungsten on federation

```bash
assets/scripts/tungsten-install.sh
```

#### Create ETL for Instance Initialization

```bash
assets/scripts/xdmod-fed-etl.sh -b instance1.fqdn[,instance2.fqdn,...] -e ./configuration/etl/ -d ./configuration/etl/
```

## Setup the Hub
The following must be agreed upon before Federation setup
-   We must decide on the following before going forward *This will be changed to be able to be a mapping in the future*

    -   field of science hierarchies
    -   Use the default for these (for now)
    -   resource types
    -   Job Times
    -   Error Descriptions
    -   process-buckets

[trfanin]: http://docs.continuent.com/tungsten-replicator-5.0/deployment-fanin.html
[trprereqs]: http://docs.continuent.com/tungsten-replicator-5.0/prerequisite.html
