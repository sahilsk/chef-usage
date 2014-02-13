### Restore Server
=========

The following steps can be followed to restore a server from scratch.

Install OS
Install Chef Server
Run chef-server-ctl reconfigure
Run chef-server-ctl stop
Restore PostgreSQL opscode_chef database
Restore Bookshelf data into the /var/opt/chef-server/bookshelf/data directory
Restore configuration files that have been modified from the default install
Run chef-server-ctl start
Run chef-server-ctl reindex


#### Read: [backing up chef-server in wiki](https://github.com/sahilsk/chef-usage/blob/master/Backing%20up%20chef-server-v11.md)
