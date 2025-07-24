#!/bin/sh

sudo add-apt-repository ppa:cppiber/hyprland

sudo apt update && sudo apt upgrade

sudo apt install -y alacritty blueman brightnessctl build-essential \
  libcairo2-dev libgirepository1.0-dev ffmpeg fzf git grep htop \
  hyprland-unstable hyprland-plugins hyprpaper hyprlock \
  khal neofetch nautilus nano network-manager network-manager-openconnect-gnome \
  network-manager-applet openconnect openvpn pkg-config pipx playerctl pulseaudio \
  python3 python3-pip python3-venv python3-gi \
  python-is-python3 remmina suckless-tools \
  swaybg swayidle sway-notification-center waybar wlogout zsh \
  fonts-font-awesome wl-clipboard grim gnome-core gnome-system-monitor \
  gnome-text-editor gnome-control-center grimshot

sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa
echo << EOL
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1
EOL | sudo tee /etc/apt/preferences.d/mozillateam
sudo apt update
sudo apt install firefox

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo mv /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.unused
sudo sed -i -e "s/managed=false/managed=true/g" /etc/NetworkManager/NetworkManager.conf
sudo systemctl restart NetworkManager
sudo systemctl disable --now systemd-networkd.service systemd-networkd.socket networkd-dispatcher.service && sudo systemctl restart NetworkManager
sudo systemctl restart NetworkManager

sudo usermod -a -G video $USER
sudo usermod -a -G input $USER
