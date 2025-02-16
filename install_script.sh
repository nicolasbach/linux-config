#!/bin/bash

loginuser=$(logname)
gui_installed=false


function install_gui {
    readarray -t desktop_programs < packages/desktop_programs
    readarray -t vim_packages < packages/vim_packages
    readarray -t window_manager < packages/window_manager
    readarray -t flatpaks < packages/flatpaks

    echo "Installing window manager packages"
    for wmpackage in "${window_manager[@]}"; do
        if ! pacman -Qi $wmpackage &> /dev/null; then
            pacman -S --noconfirm $wmpackage
        else
            echo "$wmpackage already installed"
        fi
    done

    # sddm config
    sddm_enabled=$(systemctl is-enabled sddm)
    if [[ sddm_enabled != "enabled" ]]; then
        sudo systemctl enable sddm
        echo "sddm enabled"
    else
        echo "sddm already enabled"
    fi

    # i3 Config
    if diff -q configs/i3_config ~/.config/i3/config > /dev/null; then
        "Config already in place"
    else
        cp configs/i3_config ~/.config/i3/config
        echo "Copied i3 config"
    fi

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

function get_packages {
    readarray -t essentials < packages/essentials
    readarray -t tools < packages/tools
    readarray -t development < packages/development

    echo "Installing essential packages"
    for essential in "${essentials[@]}"; do
        if ! pacman -Qi $essential &> /dev/null; then
            pacman -S --noconfirm $essential
        else
            echo "$essential already installed"
        fi
    done

    echo "Installing tools"
    for tool in "${tools[@]}"; do
        if ! pacman -Qi $tool&> /dev/null; then
            pacman -S --noconfirm tool$
        else
            echo "$tool already installed"
        fi
    done

    read -p "Install window manager? (y/n): " opt
    if [[ $opt == "y" ]] || [[ $opt == "Y" ]]; then
        install_gui
        gui_installed=true
    else
        echo "You chose no"
    fi
}


function configure_git {
    if diff -q dotfiles/.gitconfig ~/.gitconfig > /dev/null; then
        echo "Git config already exists"
    else
        cp dotfiles/.gitconfig ~/.gitconfig
        echo "Copied gitconfig"
    fi
}

function configure_vim {
    # vim config
    PLUG_PATH="~/.vim/autoload/plug.vim"
    if [ ! -f $PLUG_PATH ]; then
        echo "Installing vim-plug..."
        curl -fLo "$PLUG_PATH" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    echo "Installing vim plugins"
    vim -es -u "~/.vimrc" +PlugInstall +qall
    cd ~/.vim/plugged/YouCompleteMe/
    python3 install.py --clangd-completer --java-completer
    cd ~
}

function configure_alacritty {
    if diff -q configs/alacritty.toml ~/.config/alacritty.toml > /dev/null; then
        echo "Alacritty config already in place"
    else
        cp configs/alacritty.toml ~/.config/alacritty.toml
        echo "Alacritty config copied"
    fi
}


##############################
#### Starting main Script ####
##############################

if [[ "$linux_os_family" == "arch" ]] || [[ "$linux_os" == "arch" ]]; then
    echo "Arch Linux detected"
    sudo pacman -Syu
    get_packages
    configure_git
    if [[ $gui_installed = true ]]; then
        echo "Configuring vim"
        configure_vim
        echo "Configured vim"
        echo "Configuring alacritty"
        configure_alacritty
        echo "Configured alacritty"
    else
        echo "No gui installed so no extra configs necessary"
    fi
else
    echo "This is no arch distro"
fi


