#!/bin/bash


lsb_release -a | grep Ubuntu &> /dev/null
if [ $? -ne 0 ]
then
    echo "This script is only for Ubuntu"
    exit 1
fi

gnome-shell --version | grep GNOME &> /dev/null
if [ $? -ne 0 ]
then
    echo "This script is only for Gnome"
    exit 1
fi

echo "Installation of git"
sudo apt install git
sudo apt install gnome-tweaks gnome-shell-extensions gnome-shell-extension-prefs

echo "Enable user-theme extension"
gnome-extensions enable $(gnome-extensions list | grep user-theme)

echo "Installation of Windows icons"
git clone https://github.com/yeyushengfan258/Win11-icon-theme.git
cd Win11-icon-theme
./install.sh
cd
gsettings set org.gnome.desktop.interface icon-theme 'Win11'


echo "Installation of GTK Fluent theme"
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
cd Fluent-gtk-theme
./install.sh
gsettings set org.gnome.desktop.interface gtk-theme 'Fluent-light'
# shell
gsettings set org.gnome.desktop.wm.preferences theme 'Fluent-light'
# appareance/Shell : Fluent Light
cd

echo "Installation of Windows 11 wallpaper"
sudo apt install wget
wget https://wallpapercave.com/wp/wp10224237.jpg
# set the wall paper
gsettings set org.gnome.desktop.background picture-uri file://$PWD/wp10224237.jpg
gsettings set org.gnome.desktop.background picture-options 'zoom'

echo "Installation of Windows 11 font"
git clone https://github.com/mrbvrz/segoe-ui-linux.git
cd segoe-ui-linux
./install.sh -y
if [ $? -ne 0 ]
then
    echo "Installation of font failed"
    echo "Please type y"
    ./install.sh
fi
gsettings set org.gnome.desktop.interface font-name 'Segoe UI Light'

# install the extension Dash to Panel (1160 dash-to-panel)
echo "Installation of Dash to Panel"
