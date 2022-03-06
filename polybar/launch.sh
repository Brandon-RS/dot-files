#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bars

#####################################################

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # Left bar
    MONITOR=$m polybar -q volume_bar -c "$DIR"/custom_bars.ini &
    MONITOR=$m polybar -q net_bar -c "$DIR"/custom_bars.ini &
    MONITOR=$m polybar -q date_bar -c "$DIR"/custom_bars.ini &
    MONITOR=$m polybar -q sysmenu_bar -c "$DIR"/custom_bars.ini &

    # Center bar
    MONITOR=$m polybar -q workspaces_bar -c "$DIR"/custom_bars.ini &

    # Rigth bar
    MONITOR=$m polybar -q log_bar -c "$DIR"/custom_bars.ini &
    MONITOR=$m polybar -q desc_bar -c "$DIR"/custom_bars.ini &
  done

else
  # Left bar
  polybar -q volume_bar -c "$DIR"/custom_bars.ini &
  polybar -q net_bar -c "$DIR"/custom_bars.ini &
  polybar -q date_bar -c "$DIR"/custom_bars.ini &
  polybar -q sysmenu_bar -c "$DIR"/custom_bars.ini &

  # Center bar
  polybar -q workspaces_bar -c "$DIR"/custom_bars.ini &

  # Rigth bar
  polybar -q log_bar -c "$DIR"/custom_bars.ini &
  polybar -q desc_bar -c "$DIR"/custom_bars.ini &
fi
