#!/usr/bin/bash

# Set the default source to something other than the Elgato Wave:3
SOURCE_NAME=$(pactl list sources | grep -A20 "Built-in Audio" | grep "node.name" | grep -v "input" | cut -d' ' -f3 | tr -d '"')

pactl set-default-source "$SOURCE_NAME"

sleep 0.3

# Set the default source to the Elgato Wave:3
SOURCE_NAME=$(pactl list sources | grep -A20 "Elgato Wave:3" | grep "node.name" | grep "input" | cut -d' ' -f3 | tr -d '"')

pactl set-default-source "$SOURCE_NAME"

# Identify the card name
CARD_NAME=$(pactl list cards short | grep "Elgato_Wave_3" | cut -f1)

# Set the profile to Analog Stereo Output + Mono Input
pactl set-card-profile "$CARD_NAME" "output:analog-stereo+input:mono-fallback"

sleep 0.3

# Set the profile to Digital Stereo (IEC958) Output + Mono Input
pactl set-card-profile "$CARD_NAME" "output:iec958-stereo+input:mono-fallback"
