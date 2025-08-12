#!/bin/sh

if [ "$DESKTOP_SESSION" = "gnome" ]; then 
   sleep 5s
   killall conky
   cd "$HOME/.conky/rice"
   conky -c "$HOME/.conky/rice/info" &
   cd "$HOME/.conky/rice"
   conky -c "$HOME/.conky/rice/spotify" &>/dev/null &
   exit 0
fi
