#!/bin/bash
echo "Setting up PC"

# Updating Settings
echo "Updating General Settings"
echo "- Disable swapoff"
sudo swapoff -a
WALLPAPER_PATH="$HOME/.config/wallpaper"
if [ ! -f "$WALLPAPER_PATH" ]; then
echo "- Setting Wallpaper"
wget https://riisagertm.dk/wallpaper.png -O "$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"
fi
echo "- Enabling Dark Mode"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
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
echo "- Disabling Restore Session in Text Editor"
gsettings set org.gnome.TextEditor restore-session false
echo "- Disabling Bluetooth Autolaunch"
# Path to the main.conf file
CONF_FILE="/etc/bluetooth/main.conf"

# Check if the file exists
if [[ ! -f "$CONF_FILE" ]]; then
echo "Error: $CONF_FILE not found!"
else
# Use sed to replace 'AutoEnable=true' with 'AutoEnable=false', or add it if it doesn't exist
sudo sed -i 's/^AutoEnable=true/AutoEnable=false/' "$CONF_FILE"

# If the line does not exist, append it to the file
if ! grep -q "^AutoEnable=" "$CONF_FILE"; then
echo "AutoEnable=false" | sudo tee -a "$CONF_FILE" > /dev/null
fi
fi

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
if ! dpkg -l | grep -qw "filen"; then
echo "Installing filen.io"
wget https://cdn.filen.io/@filen/desktop/release/latest/Filen_linux_amd64.deb -O /tmp/filen.deb
sudo apt install /tmp/filen.deb
rm /tmp/filen.deb
else
echo "filen.io already installed"
fi


# Install brave
if ! dpkg -l | grep -qw "brave-browser"; then
echo "Installing Brave"
curl -fsS https://dl.brave.com/install.sh | sh
else
echo "Brave already installed"
fi

# Install GeoGebra
if [ ! -f "$HOME/geogebra/icon.png" ]; then
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
else
echo "GeoGebra already installed"
fi


# Install Steam
if ! dpkg -l | grep -qw "steam-launcher"; then
echo "Installing Steam"
wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb -O /tmp/steam.deb
sudo apt install -y /tmp/steam.deb
rm /tmp/steam.deb
else
echo "Steam already installed"
fi

# Install PDFsam Basic
if ! dpkg -l | grep -qw "pdfsam-basic"; then
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
else
echo "PDFsam already installed"
fi

# Installing Proton Suite
echo "Installing Proton Suite"
if ! dpkg -l | grep -qw "proton-pass"; then
echo "- Installing Proton Pass"
wget https://proton.me/download/PassDesktop/linux/x64/ProtonPass.deb -O /tmp/ProtonPass.deb
sudo apt install -y /tmp/ProtonPass.deb
rm /tmp/ProtonPass.deb
else
echo "- Proton Pass already installed"
fi

if ! dpkg -l | grep -qw "proton-mail"; then
echo "- Installing Proton Mail"
wget https://proton.me/download/mail/linux/ProtonMail-desktop-beta.deb -O /tmp/ProtonMail.deb
sudo apt install -y /tmp/ProtonMail.deb
rm /tmp/ProtonMail.deb
else
echo "- Proton Mail already installed"
fi

if ! dpkg -l | grep -qw "proton-vpn"; then
echo "- Installing Proton VPN"
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb -O /tmp/ProtonVPN.deb
sudo dpkg -i /tmp/ProtonVPN.deb && sudo apt update
sudo apt install -y proton-vpn-gnome-desktop
rm /tmp/ProtonVPN.deb
else
echo "- Proton VPN already installed"
fi

# Update VLC Settings
echo "Updating VLC Settings"
if [ ! -f "$HOME/snap/vlc/common/vlcrc" ]; then
vlc
fi
echo "- Disabling Recently Played"
sed -i 's/^#\?qt-recentplay=.*/qt-recentplay=0/' ~/snap/vlc/common/vlcrc
echo "- Disable Autoresize"
sed -i 's/^#\?qt-video-autoresize=.*/qt-video-autoresize=0/' ~/snap/vlc/common/vlcrc

# Set Dash Shortcuts
echo "Setting Dash Shortcuts"
gsettings set org.gnome.shell favorite-apps "['brave-browser.desktop', 'org.gnome.Nautilus.desktop', 'snap-store_snap-store.desktop', 'proton-mail.desktop', 'spotify_spotify.desktop']"

# Adding programs to autostart
mkdir -p "$HOME/.config/autostart/" 
echo "Adding Proton VPN to autostart"
cat > $HOME/.config/autostart/protonvpn-app.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=/usr/bin/protonvpn-app
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Proton VPN
Name=Proton VPN
Comment[en_US]=
Comment=
EOF
echo "Adding filen.io to autostart"
cat > $HOME/.config/autostart/@filendesktop.desktop <<EOF
[Desktop Entry]
Type=Application
Exec="/opt/Filen/@filendesktop" %U
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Filen
Name=Filen
Comment[en_US]=Cloud service
Comment=Cloud service
EOF
echo "Adding ticktick to autostart"
cat > $HOME/.config/autostart/ticktick.desktop <<EOF
[Desktop Entry]
Type=Application
Exec=/snap/bin/ticktick
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=false
Name[en_US]=TickTick
Name=TickTick
Comment[en_US]=
Comment=
EOF

# Remove Firefox
if snap list firefox &>/dev/null; then
sudo snap remove --purge firefox
fi

# Install Jellyfin Media Player
if ! dpkg -l | grep -qw "flatpak"; then
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
fi

if dpkg -l | grep -qw "flatpak"; then
if ! flatpak list | grep -qw "com.github.iwalton3.jellyfin-media-player"; then
echo "Install Jellyfin Media Player"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.github.iwalton3.jellyfin-media-player
else
echo "Jellyfin Media Player already installed"
fi
fi
