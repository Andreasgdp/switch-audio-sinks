#!/usr/bin/bash

connect_to_airpods() {
  device_mac=$(bluetoothctl devices | grep "AirPods" | awk '{print $2}')

  # Check if a MAC address was found
  if [ -z "$device_mac" ]; then
    echo "Error: Device 'AirPods' not found."
    return 1
  fi

  # Disconnect from the device
  echo "Disconnecting from 'AirPods' ($device_mac)..."
  bluetoothctl disconnect "$device_mac"

  # Connect to the device
  echo "Connecting to 'AirPods' ($device_mac)..."
  bluetoothctl connect "$device_mac"
  return $?
}

# Attempt to connect a couple of times with a delay in between
for attempt in 1 2; do
  connect_to_airpods
  if [ $? -eq 0 ]; then
    echo "Successfully connected to 'AirPods'."
    exit 0
  fi
  echo "Failed to connect. Retrying in 5 seconds..."
  sleep 1
done

echo "Failed to connect to 'AirPods' after multiple attempts."
exit 1
