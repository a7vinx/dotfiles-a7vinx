#!/bin/bash

# By Arvin.X.

# Install xorg etc.
# Note that xserver-xorg-legacy is used for non-root user to use startx. 
sudo apt-get install xorg feh compton xserver-xorg-legacy chromium font-noto -y


# Install i3-gaps from source
sudo apt-get install libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev -y 

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install


# Copy configuration files
cd ../../

cp -r ../.config ~/
cp ../.compton.conf ~/.compton.conf
cp ../.Xresources ~/.Xresources
cp ../.xinitrc ~/.xinitrc
sudo cp ../xorg.conf /etc/X11/

# Enable chromium extension
echo "export CHROMIUM_FLAGS='$CHROMIUM_FLAGS --enable-remote-extensions'"  \
       > /etc/chromium.d/enable-remote-extensions

# Configure custom services
sudo cp ../services/*.service /etc/systemd/system/
sudo systemctl enable autossh.service sslocal.service
sudo systemctl start autossh.service sslocal.service


