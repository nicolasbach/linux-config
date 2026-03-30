#!/bin/bash

loginuser=$(logname)
gui_installed=false
$REPOPATH="~/.local/share/linux-config"

# Declare arrays
declare -a cmd_packages
declare -a desktop_packages
declare -a flatpaks
declare -a nvim_packages
declare -a wayland_packages
declare -a wm_packages
declare -a x11_packages

# read package lists into arrays
readarray -t cmd_packages < packages/01_cmd_basic
readarray -t desktop_packages < packages/05_desktop
readarray -t flatpaks < packages/05_flatpaks
readarray -t nvim_packages < packages/10_nvim
readarray -t wayland_packages < packages/03_wayland
readarray -t wm_packages < packages/02_wm_basic
readarray -t x11_packages < packages/03_x11


function install_packages {
    declare -a packages
    packages=("$@")
    for package in "${packages[@]}"; do
        if ! pacman -Qi $package &> /dev/null; then
            pacman -S --noconfirm $package
        else
            echo "$package already installed"
        fi
    done
}


function install_gui {
    install_packages "${wm_packges[@]}"
    echo "[ 1 ] - Hyprland"
    echo "[ 2 ] - i3"

    read -p "choose wm: " opt

    case $opt in
        1)
            # Install packages
            install_packages "${wayland_packages[@]}"

            # Delete existing config dirs (maybe defaults)
            rm -rf ~/.config/hypr
            rm -rf ~/.config/waybar
            rm -rf ~/.config/sway

            # Link configs to config dir
            ln -s $REPOPATH/configs/hyprland ~/.config/hypr
            ln -s $REPOPATH/configs/waybar ~/.config/waybar
            ln -s $REPOPATH/configs/sway ~/.config/sway
            echo "Linked waybar, hyprland and sway config"
            ;;
        2)
            # Install necessary packages for i3
            install_packages "${x11_packages[@]}"

            # Delete existing config dirs (maybe defaults)
            rm -rf ~/.config/i3
            rm -rf ~/.config/picom

            # Link configs to config dir
            ln -s $REPOPATH/configs/i3 ~/.config/i3
            ln -s $REPOPATH/configs/picom ~/.config/picom
            echo "Linked i3 and picom configs"
            ;;
        *)
            echo "unknown option"
            ;;
    esac

    # sddm config
    sddm_enabled=$(systemctl is-enabled sddm)
    if [[ sddm_enabled != "enabled" ]]; then
        sudo systemctl enable sddm
        echo "sddm enabled"
    else
        echo "sddm already enabled"
    fi

    # Install desktop applications
    install_packages "${desktop_packages[@]}"
    for fp in "${flatpaks[@]}"
    do
        flatpak install $fp -y
    done

    # Nerd Fonts for alacritty/vim config
    if diff <(unzip -l stuff/FiraCode.zip | grep ttf | awk '{print $4}' | sort) <(ls -la ~/.local/share/fonts/ | grep -E "FiraCode.+ttf" | awk '{print $9}' | sort) > /dev/null; then
        echo "Fonts already installed"
    else
        echo "Fira Code fonts not (fully) installed, installing..."
        echo "Unzipping FiraCode"
        unzip -d FiraCode stuff/FiraCode.zip
        mkdir -p ~/.local/share/fonts
        echo "Copying ttf"
        cp FiraCode/*.ttf ~/.local/share/fonts/
        echo "Deleting temp dir"
        rm -r FiraCode
    fi
}

function configure_packages {
    echo "Installing essential packages"
    install_packages "${cmd_packages[@]}"

    read -p "Install gui? (y/n): " opt
    if [[ $opt == "y" ]] || [[ $opt == "Y" ]]; then
        install_gui
        gui_installed=true
    else
        echo "You chose no"
    fi
}

function configure_git {
    cp configs/gitconfig ~/.gitconfig
}

# Note: "configure_vim" was removed because I use nvim, vimrc is still in this repo
function configure_nvim {
    # Delete config dir if existing (maybe defaults)
    rm -rf ~/.config/nvim

    # Link configs to config dir
    ln -s $REPOPATH/configs/neovim ~/.config/nvim
}

function configure_alacritty {
    # Delete config dir if existing (maybe defaults)
    rm -rf ~/.config/alacritty

    # Link configs to config dir
    ln -s $REPOPATH/configs/alacritty ~/.config/alacritty
}

function configure_dunst {
    # Delete config dir if existing (maybe defaults)
    rm -rf ~/.config/dunst

    # Link configs to config dir
    ln -s $REPOPATH/configs/dunst ~/.config/dunst
}

function configure_conky {
    # Delete config dir if existing (maybe defaults)
    rm -rf ~/.config/conky

    # Link configs to config dir
    ln -s $REPOPATH/configs/conky ~/.config/conky
}

function configure_wallpapers {
    cp -r wallpapers ~/.local/share/
}


##############################
#### Starting main Script ####
##############################

if [[ "$linux_os_family" == "arch" ]] || [[ "$linux_os" == "arch" ]]; then
    echo "Arch Linux detected"
    sudo pacman -Syu
    configure_packages
    configure_git
    cp configs/bashrc ~/.bashrc
    if [[ $gui_installed = true ]]; then
        echo "Configuring alacritty..."
        configure_alacritty
        echo "Configured alacritty"
        echo "Configuring neovim..."
        configure_nvim
        echo "Configured neovim"
        configure_conky
        configure_dunst
        configure_wallpapers
    else
        echo "No gui installed so no extra configs necessary"
    fi
else
    echo "This is no arch distro"
fi


