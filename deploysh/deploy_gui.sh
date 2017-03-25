#!/bin/bash
# Some Debian configuration for myself.
# By Arvin.X.

sudo apt-get install xorg feh compton -y

# compile i3-gaps
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

cp ../.config/i3/config /root/.config/i3/config
cp ../.config/wallpapers/cur.jpg /root/.config/wallpapers/cur.jpg
cp ../.compton.conf /root/.compton.conf
cp ../.Xresources /root/.Xresources
cp ../.xinitrc /root/.xinitrc

sudo cp ../xorg.conf /etc/X11/
