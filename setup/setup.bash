#!/bin/bash
echo "Setting up PC"

# Updating Settings
echo "Updating General Settings"
echo "- Disable swapoff"
sudo swapoff -a
echo "- Setting Wallpaper"
WALLPAPER_PATH="$HOME/.config/wallpaper"
wget https://riisagertm.dk/wallpaper.png -O "$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"
echo "- Show Hidden Files"
gsettings set org.gtk.gtk4.Settings.FileChooser show-hidden true
echo "- Disable Tile Groups"
gsettings set org.gnome.shell.extensions.tiling-assistant disable-tile-groups true
echo "- Disable File History"
gsettings set org.gnome.desktop.privacy remember-recent-files false
echo "- Disable Idle Dimming"
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
echo "- Disable Sleep if inactive"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
echo "- Disable Idle Display"
gsettings set org.gnome.desktop.session idle-delay 0
echo "- Display Battery Percentage"
gsettings set org.gnome.desktop.interface show-battery-percentage true
echo "- Adjusting Desktop Icons"
gsettings set org.gnome.shell.extensions.ding start-corner 'top-left'
gsettings set org.gnome.shell.extensions.ding show-home false
echo "- Adjustning Dock"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
echo "- Disabling Reporting of Technical Problems"
gsettings set org.gnome.desktop.privacy report-technical-problems false
echo "- Enabling Line Numbers in Text Editor"
gsettings set org.gnome.TextEditor show-line-numbers true

# Install Software
echo "Installing Software"
sudo snap install spotify
sudo snap install ticktick
sudo snap install vlc
sudo snap install discord
sudo snap install freecad
sudo snap install gimp
sudo snap install inkscape
sudo snap install signal-desktop
sudo apt update
sudo apt install -y neofetch
sudo apt install -y net-tools
sudo apt install -y libreoffice
sudo apt install -y hunspell-da
sudo apt install -y python-is-python3
sudo apt install -y python3-pip
sudo apt install -y solaar
sudo apt install -y ffmpeg
sudo apt install -y filezilla
sudo apt install -y wine

# Install filen.io
echo "Installing filen.io"
wget https://cdn.filen.io/@filen/desktop/release/latest/Filen_linux_amd64.deb -O /tmp/filen.deb
sudo apt install /tmp/filen.deb
rm /tmp/filen.deb

# Install brave
echo "Installing Brave"
curl -fsS https://dl.brave.com/install.sh | sh

# Install GeoGebra
echo "Installing GeoGebra"
mkdir ~/geogebra
wget https://download.geogebra.org/package/linux-port -O ~/geogebra/geogebra.tar.bz2
wget https://riisagertm.dk/setup/geogebra_icon.png -O ~/geogebra/icon.png
tar -xjf ~/geogebra/geogebra.tar.bz2 -C ~/geogebra
rm ~/geogebra/geogebra.tar.bz2
GEOGEBRA_FOLDER=$(find "$HOME/geogebra" -mindepth 1 -maxdepth 1 -type d | sort | head -n 1)
cat > ~/geogebra/geogebra.desktop <<EOF
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=$GEOGEBRA_FOLDER/geogebra-portable
Name=GeoGebra
Icon=$HOME/geogebra/icon.png
EOF
sudo mv ~/geogebra/geogebra.desktop /usr/share/applications/

# Install Steam
echo "Installing Steam"
wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb -O /tmp/steam.deb
sudo apt install -y /tmp/steam.deb
rm /tmp/steam.deb

# Install PDFsam Basic
echo "Installing PDFsam Basic"
PDFSAM_URL=$(
curl -s "https://pdfsam.org/download-pdfsam-basic/" |
grep -oP 'href=".*?pdfsam-basic_.*?_amd64\.deb"' |
head -n1 |
sed 's/href="//;s/"//'
)
wget $PDFSAM_URL -O /tmp/pdfsam.deb
sudo apt install -y /tmp/pdfsam.deb
rm /tmp/pdfsam.deb

# Installing Proton Suite
echo "Installing Proton Suite"
echo "- Installing Proton Pass"
wget https://proton.me/download/PassDesktop/linux/x64/ProtonPass.deb -O /tmp/ProtonPass.deb
sudo apt install -y /tmp/ProtonPass.deb
rm /tmp/ProtonPass.deb
echo "- Installing Proton Mail"
wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb -O /tmp/ProtonMail.deb
sudo apt install -y /tmp/ProtonMail.deb
rm /tmp/ProtonMail.deb
echo "- Installing Proton VPN"
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb -O /tmp/ProtonVPN.deb
sudo dpkg -i /tmp/ProtonVPN.deb && sudo apt update
sudo apt install -y proton-vpn-gnome-desktop
rm /tmp/ProtonVPN.deb

# Update VLC Settings
echo "Updating VLC Settings"
vlc
echo "- Disabling Recently Played"
sed -i 's/^#\?qt-recentplay=.*/qt-recentplay=0/' ~/snap/vlc/common/vlcrc
echo "- Disable Autoresize"
sed -i 's/^#\?qt-video-autoresize=.*/qt-video-autoresize=0/' ~/snap/vlc/common/vlcrc

# Update Brave Settings
echo "Updating Brave Settings"

# Install Jellyfin Media Player
echo "Install Jellyfin Media Player"
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.github.iwalton3.jellyfin-media-player
