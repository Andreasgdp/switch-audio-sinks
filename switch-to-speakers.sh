#!/usr/bin/bash

SINK_NAME=$(pactl list sinks | grep -A20 "pci" | grep -A20 "analog" | grep "node.name" | cut -d' ' -f3 | tr -d '"')

pactl set-default-sink $SINK_NAME
