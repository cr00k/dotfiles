#!/bin/bash
#  _   _                  _                 _  
# | | | |_   _ _ __  _ __| | __ _ _ __   __| | 
# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` | 
# |  _  | |_| | |_) | |  | | (_| | | | | (_| | 
# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| 
#        |___/|_|                              
#  
# ----------------------------------------------------- 
# Install Script for Hyprland
# ------------------------------------------------------

# ------------------------------------------------------
# Confirm Start
# ------------------------------------------------------
source $(dirname "$0")/scripts/library.sh
clear
echo "  _   _                  _                 _  "
echo " | | | |_   _ _ __  _ __| | __ _ _ __   __| | "
echo " | |_| | | | | ,_ \| ,__| |/ _\ | ,_ \ / _, | "
echo " |  _  | |_| | |_) | |  | | (_| | | | | (_| | "
echo " |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| "
echo "        |___/|_|                              "
echo "                             " 
echo "------------------------------------------------------"
echo ""

while true; do
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo "Installation started."
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo ""

sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf &>> $INSTLOG


# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo ""
echo "-> Install main packages"
packagesPacman=(
    "hyprland-nvidia"
#    "hyprland"
    "xdg-desktop-portal-wlr" 
    "waybar" 
    "grim" 
    "slurp"
    "swayidle"
    "swappy"
    "cliphist"
);

packagesYay=(
    "swww" 
    "swaylock-effects" 
    "wlogout"
);



# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------


_installPackagesPacman "${packagesPacman[@]}";
_installPackagesYay "${packagesYay[@]}";


echo ""
echo "DONE!"
echo "NEXT: Update the keyboard layout and screen resolution in ~/dotfiles/hypr/hyprland.conf"
echo "Then proceed with with 3-dotfiles.sh"

