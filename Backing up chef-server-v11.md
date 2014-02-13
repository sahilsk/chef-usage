### 1) Backup Data bags, roles, and nodes
===============================

Use this `Knife Exec` script to perform a backup of an existing Chef Server:

``` bash
cd ~/path/to/chef/repository   

curl -O https://raw.github.com/jtimberman/knife-scripts/master/chef_server_backup.rb
```

Run the `knife exec` script

``` bash
knife exec chef_server_backup.rb
```

##### IMPROVEMENT: Instead of directly running from chef admin workstation, let there be another client :backup, and use it to do backup .

####### Create new client on chef-server with given key and role

``` bash
knife client create backup --admin --file "$HOME/.chef/backup.pem"
```
It will create new client named "backup" with admin privileges using backup.pem key.
( Generally we create this user for taking chef-server backup)

##### This will export your data bags, roles, and nodes stored on the chef server as JSON files within the .chef/chef_server_backup directory.

========================
The following three areas should be backed up to ensure the chef server can be restored.

### 2) Chef Server Configuration Files
=======================
If the default configuration files are modified they must be backed up. For instance, the nginx configuration file could be modified to listen on a specific ip address. These files are in the `/var/opt/chef-server` directory.
Also, backup user configuration from /etc/chef-server along with  security keys(pem files)

### 3) Bookshelf Data
Data stored by Bookshelf must be protected. This data resides in the `/var/opt/chef-server/bookshelf/data` directory.

### 4) PostgreSQL Database
Many options are available to backup the PostgreSQL databases. 


#### Find pg_dump  on chef-server

``` bash
find / -name pg_dump -type f 2>/dev/null
```
output:  /opt/chef-server/embedded/bin/pg_dump  etc etc

``` bash
/opt/chef-server/embedded/bin/pg_dump    -h localhost  -p 5432 -U opscode_chef  > /tmp/chefserver.sql
 ```
Default values of chef-server-v11 components are here:
http://docs.opscode.com/config_rb_chef_server_optional_settings.html
https://github.com/opscode/omnibus-chef-server/blob/master/files/chef-server-cookbooks/chef-server/attributes/default.rb

If hostname, port and database are different then change them here. 

Find at which port postgresql is running:

``` bash
sudo netstat -lp | grep postgresql
```
You may use `chef-server-ctl show-config command` to see your defined configuration.


### Resources
1. https://wiki.opscode.com/display/chef/Backing+Up+Chef+Server
2. https://wiki.opscode.com/display/chef/Backup+Chef+Server+V11+Components
3. http://docs.opscode.com/config_rb_chef_server_optional_settings.html
4. http://sixthslap.blogspot.in/2014/01/understand-chef-server-components.html
5. https://github.com/opscode/omnibus-chef-server/blob/master/files/chef-server-cookbooks/chef-server/attributes/default.rb
