#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
#   sketchybar --set $NAME background.drawing=on
# else
#   sketchybar --set $NAME background.drawing=off
# fi

monitors=$(aerospace list-monitors | awk -F '|' '{print $1}' | grep -Eo '[0-9]+')
label=""
for monitor in $monitors; do
  label=$label$(aerospace list-workspaces --monitor "$monitor" --visible)
  if [ "$monitor" != "$(echo "$monitors" | tail -n 1)" ]; then
    label=$label" | "
  fi
done
sketchybar --set "$NAME" label="$label"
