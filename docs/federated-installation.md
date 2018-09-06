# Installation

## [Prerequisites][trprereqs]

**TODO: Turn this into a script**

Follow directions for the tungsten prerequisites [prerequisites][trprereqs] The following settings are required for each database in the federation:

-   binlog-format = row
-   log-bin-trust-function-creators = 1
-   server-id = #
    -   each server must be different suggest using:
    -   printf %d\\n 0x`hostname -f | md5sum | awk '{ print $1 }' | cut -b 1-7`
-   Number of files
    -   [CentOS 7][mariadblimits]

```bash
mkdir -p /etc/systemd/system/mariadb.service.d/
cat > /etc/systemd/system/mariadb.service.d/limits.conf << EOF
[Service]
LimitNOFILE=65535
EOF
systemctl daemon-reload
systemctl restart mariadb
cat >> /etc/sysctl.conf << EOF
vm.swappiness=10
EOF
```


### Initialize Hub Database

The Hub database needs to have all of the same tables and structure of the instances.

Use the `xdmod-setup` script initialize the Hub Database (setup your database and organization)

### Prepare for replication using tungsten

#### Hub Server

##### Prerequisites
[Additional Information][trprereqs2]


##### Create tungsten user(s) and generate RSA key and password
**a random 32 character password will be generated for mysql and stored in ~tungsten/.my.cnf**

```bash
xdmod-fed-tungsten-add-user
```


#### Create ETL for Instance Initialization

Create instance databases on Hub

**(replacing instance\d.fqdn with the fqdn of the instance(s))**

```bash
xdmod-fed-instance-etl -i instance1.fqdn[,instance2.fqdn,...]
```

##### Download and extract tungsten

```bash
xdmod-fed-tungsten-download
```

#### Instances

##### Tungsten Prerequisites (for the instances)

##### Create tungsten user(s) and generate RSA key
**a random 32 character password will be generated for mysql and stored in ~tungsten/.my.cnf**

```bash
xdmod-fed-tungsten-add-user
```

**TODO: Automate this?**

Copy the public (~tungsten/.ssh/id_rsa.pub), private key (~tungsten/.ssh/id_rsa), and authorized keys (~tungsten/.ssh/authorized_keys) from the Hub server to the ~/tungsten/.ssh directory.

## Configuring tungsten for [Fan-In][trfanin] Replication

### Hub Server

### Set Tungsten defaults


```bash
xdmod-fed-tungsten-defaults
```

### Configuring the xdmodfederation service

**(replacing instance\d.fqdn with the fqdn of the instance(s))**

```bash
xdmod-fed-tungsten-configure -h hub.fqdn -i instance1.fqdn[,instance2.fqdn,...]
```

### Configuring database rename

**(replacing instance\d.fqdn with the fqdn of the instance(s))**

```bash
xdmod-fed-tungsten-config-instance -i instance1.fqdn[,instance2.fqdn,...]
```

**DIFFERENT MYSQL PASSWORDS**

Since the mysql passwords should be different for the different instances

**currently this must be done outside of xdmod-fed-* commands**

```bash
tpm configure --host instace.fqdn
 --datasource-user theUser --datasource-password thePassword
```

#### Validate and install Tungsten on federation

```bash
xdmod-fed-tungsten-install
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

## Expanding the Federation
**currently this must be done outside of xdmod-fed-* commands**
read more at: [deployment expanding slaves][tcexpand]

```bash
su - tungsten -c '/opt/continuent/software/tungsten-replicator-5.0.1/tools/tpm configure --dataservice-name xdmodfederation --members+=instance.fqdn'

xdmod-fed-tungsten-config-instance -i instance.fqdn

su - tungsten -c '/opt/continuent/software/tungsten-replicator-5.0.1/tools/tpm configure xdmodfederation --host instance.fqdn --datasource-user theUser --datasource-password thePassword'
```

Get all the current instances, they will be needed for the next step

```bash
/opt/continuent/software/tungsten-replicator-5.0.1/tools/tpm dump | grep '\-\-masters' | cut -d'=' -f 2 | cut -d' ' -f
```

**NOTE: This requires you to put in all other instances**
```bash
su - tungsten -c '/opt/continuent/software/tungsten-replicator-5.0.1/tools/tpm configure xdmodfederation --master=instance.fqdn'
```

```bash
su - tungsten -c '/opt/continuent/software/tungsten-replicator-5.0.1/tools/tpm update'
```

[tcexpand]: http://docs.continuent.com/tungsten-clustering-5.0/deployment-expanding-slaves.html
[trfanin]: http://docs.continuent.com/tungsten-replicator-5.0/deployment-fanin.html
[trprereqs]: http://docs.continuent.com/tungsten-replicator-5.0/prerequisite.html
[trprereqs2]: http://docs.continuent.com/tungsten-replicator-5.2-oss/prerequisite-host.html
[mariadblimits]: https://ma.ttias.be/increase-open-files-limit-in-mariadb-on-centos-7-with-systemd/
