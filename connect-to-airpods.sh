#!/usr/bin/bash

device_mac=$(bluetoothctl devices | grep "AirPods" | awk '{print $2}')

# Check if a MAC address was found
if [ -z "$device_mac" ]; then
	echo "Error: Device 'AirPods' not found."
	exit 1
fi

# Connect to the device
echo "Connecting to 'AirPods' ($device_mac)..."
bluetoothctl connect "$device_mac"
