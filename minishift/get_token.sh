#!/usr/bin/env bash

oc login -u system:admin
TOKEN=`oc sa get-token -n management-infra management-admin`
IP=`minishift ip`

echo "paste this into rails console"
echo
echo
cat <<EOT
token = '$TOKEN'
host  = '$IP'
os = ManageIQ::Providers::Openshift::ContainerManager
os.create(:name => "Minishift", :hostname => host, :port => 8443, :ipaddress => host, :zone => Zone.first, :storage_profiles => [], :security_protocol => "ssl-without-validation")
os.last.update_authentication(:bearer => {:auth_key => token, :save => true})
EOT
