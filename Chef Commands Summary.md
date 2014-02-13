##  Chef-client: workstation and Node perspective
### Chef-Client usage from the perspective of Administrator( chef workstation)

Run lists specify what recipes or roles the
node should run, along with the order they
should be run in
• Run lists are represented by an array
• Recipes are specified by “recipe[name]”
• Roles are specified by “role[name]”

#### Add new node

``` bash
knife node 
```

#### Edit existing node for like editing run list

``` bash
knife node edit target-node
```
It'll open the node in text editor. Edit the run list and save it.


#### Create new client on chef-server with given key and role
``` bash
knife client create backup --admin --file "$HOME/.chef/backup.pem"
```
It will create new client named "backup" with admin privileges using backup.pem key.
( Generally we create this user for taking chef-server backup)
#### Upload to chef-server

``` bash
knife cookbook upload -a
```
``` bash
knife cookbook upload --all       #Upload all cookbooks to chef-server
```

``` bash
knife role from file roles/*.rb     # upload all roles on chef-server 
```
``` bash
knife data bag create users    #Create 'users' databag  
```

       
``` bash
knife data bag from file [bag_name] [item_name.json]knife data bag from file [bag_name] [item1_name.json] [item2_name.json]
knife data bag from file [bag_name] /path/to/[bag_name]/[item_name.json]knife data bag from file [bag_name] /path/to/[bag_name]/[item1_name.json] /path/to/[bag_name]/[item2_name.json]
knife data bag from file [bag_name] /path/to/[bag_name]
knife data bag from file [bag_name] --all           # all data bag items assuming that data bags are in the ./data_bags/
knife data bag from file --all           # all data bags assuming that data bags are in the ./data_bags/
```

#### Add run list to node

``` bash
knife node run_list add target-node “role[base],role[monitoring]”
```

#### Remove run list from node

``` bash
knife node run_list remove target-node “recipe[apache]”
```

#### Search clients with particular role

``` bash
knife ssh "role:base"        
```
Knife SSH performs a search for nodes on the Chef Server with the query "role:base".  Knife opens an SSH connection to the nodes' IP address (-a ipaddress or -a cloud.public_ipv4). 
The SSH session will connect as the user (-x  opscode) with the password (-P opscode)  to SSH and run on the node.


### Run 'chef-client' 

#### Run the chef-client on all nodes

``` bash
$ knife ssh 'name:*' 'sudo chef-client'
```

#### On  ALL nodes under role:base

``` bash
knife ssh role:base "sudo chef-client" -x username -P password
```

#### On particular node (-a ipaddress or -a cloud.public_ipv4).

``` bash
knife ssh role:base "sudo chef-client" -x USERNAME -P PASSWORD -a cloud.public_ipv4
```

### Download, extract and upload cookbook

``` bash
knife cookbook site download COOKBOOK
```
           Download cookbook from community.opscode.com

``` bash		   
 tar -zxvf COOKBOOK*.tar.gz -C cookbooks
```

Extract the download cookbook.tar.gz into cookbooks directory 

#### less cookbooks/COOKBOOK/README.md

``` bash     
	 Read cookbook README.md
```

####  less cookbooks/COOKBOOK/recipes/default.rb

``` bash     
	 Read default.rb recipe
 #If everything is fine, then upload it on chef-server
	knife cookbook upload COOKBOOK
```
 
### Environments

#### Move Nodes
Nodes can be moved between environments, such as from a “dev” to a “production” environment by using the knife exec sub-command. For example:

``` bash    
knife exec -E 'nodes.transform("chef_environment:dev") { |n| n.chef_environment("production") }'
```

#### Search Environments

Using knife command:
``` bash
    knife search node "chef_environment:QA AND platform:centos"
```
Or, to include the same search in a recipe, use a code block similar to:

``` bash
qa_nodes = search(:node,"chef_environment:QA")
qa_nodes.each do |qa_node|
    # Do useful work specific to qa nodes only
end
```

## Chef-Client usage from the perspective of  Node
-----------------------------------------------

#### Sync cookbook

``` bash
sudo chef-client -Fdoc -lfatal
```

It'll pull the latest cookbooks from chef-server and sync the system according to run list defined.

#### Useful opscode cookbooks: 
`` apt, users, ssh_host_knows, build_essentials	``



## References:
------------

Chef Resources:  http://docs.opscode.com/chef/resources.htmlchef-usage
==========
