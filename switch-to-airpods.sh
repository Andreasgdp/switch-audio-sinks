#!/usr/bin/bash

SINK_NAME=$(pactl list sinks | grep -A20 "AirPods" | grep "node.name" | cut -d' ' -f3 | tr -d '"')

pactl set-default-sink $SINK_NAME
