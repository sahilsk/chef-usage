#!/bin/bash

############################################################################################
# To take backup of cookbooks, environments, nodes, roles, and data bags from chef-server.
### Run this script from your local workstation Chef folder)
############################################################################################

# download all cookbooks
knife download cookbooks

# download roles
knife download roles

# download nodes info
knife download nodes

# download data_bags
knife download data_bags

# download environments ('knife download environments' does not work)
mkdir environments
for env in `knife environment list`; do
    knife environment show $env --format=json > environments/$env.json
done
