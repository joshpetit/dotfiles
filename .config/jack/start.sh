a2jmidid -e & disown
pactl load-module module-jack-source & disown
pactl load-module module-jack-sink channels=2 & disown
