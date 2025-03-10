#!/usr/bin/bash

# get path of this script
SCRIPT_PATH=$(dirname "$(realpath "$0")")

connect_to_airpods() {
  device_mac=$(bluetoothctl devices | grep "AirPods" | awk '{print $2}')

  # Check if a MAC address was found
  if [ -z "$device_mac" ]; then
    echo "Error: Device 'AirPods' not found."
    return 1
  fi

  # Check if already connected
  connected=$(bluetoothctl info "$device_mac" | grep "Connected: yes")
  if [ -n "$connected" ]; then
    echo "'AirPods' ($device_mac) are already connected."
    return 0
  fi

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

    # wait till the connection is established
    timeout=10
    while [ -z "$(bluetoothctl info | grep "Connected: yes")" ]; do
      sleep 1
      timeout=$((timeout - 1))
      if [ $timeout -eq 0 ]; then
        echo "Failed to establish connection to 'AirPods'."
        break
      fi
    done

    # if timeout is not reached, run switch-to-airpods.sh
    if [ $timeout -gt 0 ]; then
      sleep 1
      echo "Running switch-to-airpods.sh..."
      "$SCRIPT_PATH/switch-to-airpods.sh"
      exit 0
    fi
  fi
  echo "Failed to connect. Retrying in 5 seconds..."
  sleep 5
done

echo "Failed to connect to 'AirPods' after multiple attempts."
exit 1
