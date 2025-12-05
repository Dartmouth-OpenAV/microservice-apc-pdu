#!/bin/bash

# APC PDU microservice test script
# Replace these variables with your actual values
MICROSERVICE_URL="your-microservice-url"
DEVICE_FQDN="192.168.254.112"
PROTOCOL = "telnet"
DEVICE_USERNAME="apc"
DEVICE_PASSWORD="your-password"

echo "Testing APC PDU microservice..."
echo "Microservice URL: $MICROSERVICE_URL"
echo "Device FQDN: $DEVICE_FQDN"
echo "Device Protocol: $PROTOCOL
echo "----------------------------------------"

# GET state of a single outlet
echo "Testing GET outlet state (outlet 1)..."
curl -X GET "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/state/1"
sleep 1

# GET all outlets status
echo "Testing GET all outlets status..."
curl -X GET "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/allOutlets"
sleep 1

# SET outlet on
echo "Testing SET outlet 1 on..."
curl -X PUT "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/state/1" \
     -H "Content-Type: application/json" \
     -d '"on"'
sleep 3

# SET outlet off
echo "Testing SET outlet 1 off..."
curl -X PUT "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/state/2" \
     -H "Content-Type: application/json" \
     -d '"off"'
sleep 3

# SET outlet range on
echo "Testing SET outlets 1-3 on..."
curl -X PUT "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/state/1-3" \
     -H "Content-Type: application/json" \
     -d '"on"'
sleep 3

# SET all outlets off
echo "Testing SET all outlets off..."
curl -X PUT "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/state/all" \
     -H "Content-Type: application/json" \
     -d '"off"'
sleep 3

# Power cycle outlet (off for 5 seconds, then on)
echo "Testing power cycle outlet 1 (5 second delay)..."
curl -X POST "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/powerCycle/1" \
     -H "Content-Type: application/json" \
     -d '"3"'
sleep 5

# Power cycle outlet range (off for 10 seconds, then on)
echo "Testing power cycle outlets 2-4 (10 second delay)..."
curl -X POST "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/powerCycle/2-4" \
     -H "Content-Type: application/json" \
     -d '"5"'
sleep 7

# SET all outlets on
echo "Testing SET all outlets on..."
curl -X PUT "http://${MICROSERVICE_URL}/${PROTOCOL}|${DEVICE_USERNAME}:${DEVICE_PASSWORD}@${DEVICE_FQDN}/state/all" \
     -H "Content-Type: application/json" \
     -d '"on"'

echo "----------------------------------------"
echo "All tests completed."
