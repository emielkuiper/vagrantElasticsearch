#!/bin/bash

# Short script to set up a hostonly network for hosting the Elasticsearch servers
#
# Default network is 172.28.28.0/24
# Script will detect the presence of this network but will NOT suggest another.
#
# If the default subnet is in use please take the following actions:
#
# * edit the ELASTIC_NETWORK_IP variable below and use a free IP
# * edit the Vagrant file and edit the static IP adresses
# * update the Ansible inventory file

VBOXMANAGE=`which vboxmanage`
ID=`which id`

ELASTIC_NETWORK_IP="172.28.28.1"
ELASTIC_NETWORK_MASK="255.255.255.0"

CHECK_AGAINST_EXISTING_NETWORKS=`$VBOXMANAGE list hostonlyifs | grep "$ELASTIC_NETWORK_IP"`

# Script should be run with root permissions
USERID=`$ID`

if   [[ "$USERID" =~ "uid=0(root)" ]]; then
    echo "OK: Running script with root permissions"

    # If $CHECK_AGAINST_EXISTING_NETWORKS is empty, then create network, otherwise exit 1
    if   [[ -z "$CHECK_AGAINST_EXISTING_NETWORKS" ]]; then
        echo "OK: Going to create network $ELASTIC_NETWORK_IP / $ELASTIC_NETWORK_MASK"

        # Create new interface
        NEWINTERFACE=`$VBOXMANAGE -q hostonlyif create 2>&1 | grep successfully | awk '{print $2}' | sed s/\'//g`
        echo "Newly created interface is $NEWINTERFACE"

        # Set IP address for new interface
        $VBOXMANAGE -q hostonlyif ipconfig "$NEWINTERFACE" --ip $ELASTIC_NETWORK_IP --netmask $ELASTIC_NETWORK_MASK

        # Details for interface
        echo ""
        echo "Details for interface"
        echo ""
        $VBOXMANAGE -q list hostonlyifs | grep -B11 "HostInterfaceNetworking-$NEWINTERFACE"
        exit 0
    else
        echo "NOTE: Network was already present! No new network was created."
        echo ""
        echo "If this network was not created for the purpose of the Elasticstack VMs please take the following actions:"
        echo "* edit the ELASTIC_NETWORK_IP variable in this script and use a free IP"
        echo "* edit the Vagrant file and edit the static IP adresses"
        echo "* update the Ansible inventory file"
        echo ""
        exit 1
    fi

else
    echo "ERROR: Running script with insufficient permissions. Please run script either as user root or with sudo!"
    exit 1
fi
