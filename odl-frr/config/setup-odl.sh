#!/bin/bash

ip route add 10.0.0.0/24 via 172.20.20.11

while ! /opt/opendaylight/bin/client "system:start-level" 2> /dev/null | grep 100 > /dev/null; do
    echo "Waiting for Karaf to initialize... (Retrying in 5)"
    sleep 5
done

echo "Installing required features..."
/opt/opendaylight/bin/client "feature:install features-netconf features-bgpcep"
# RESTCONF, BGP, PCEP

sleep 5

echo "Configuring BGP..."
curl -X PUT "http://172.20.20.10:8181/rests/data/openconfig-network-instance:network-instances/network-instance=global-bgp/protocols" -u admin:admin -H "Content-Type: application/json" -d @config/bgp-conf.json

echo "Creating SR-TE Linkstate topology..."
curl -X POST "http://172.20.20.10:8181/rests/data/network-topology:network-topology" -u admin:admin -H "Content-Type: application/json" -d @config/topology-conf.json

echo "Configuring PCEP..."
curl -X PUT "http://172.20.20.10:8181/rests/data/network-topology:network-topology/topology=pcep-topology" -u admin:admin -H "Content-Type: application/json" -d @config/pcep-conf.json

echo "Done"

