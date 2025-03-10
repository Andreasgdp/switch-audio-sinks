#!/usr/bin/bash

# Function to fetch the sink name
fetch_sink_name() {
  pactl list sinks | grep -A20 "AirPods" | grep "node.name" | cut -d' ' -f3 | tr -d '"'
}

# Attempt to fetch the sink name a couple of times with a delay in between
for attempt in 1 2 3 4; do
  SINK_NAME=$(fetch_sink_name)
  echo "Attempt $attempt: Found sink name: $SINK_NAME"
  if [ -n "$SINK_NAME" ]; then
    echo "Found sink name: $SINK_NAME"
    echo "Setting default sink to $SINK_NAME..."
    pactl set-default-sink "$SINK_NAME"
    exit 0
  fi
  echo "Failed to fetch sink name. Retrying in 5 seconds..."
  sleep 5
done

echo "Failed to fetch sink name after multiple attempts."
exit 1
