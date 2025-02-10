#!/bin/bash

linux_os=$(cat /etc/os-release | grep -E "^ID=.*$" | cut -d "=" -f2)
linux_os_family=$(cat /etc/os-release | grep -E "^ID_LIKE=.*$" | cut -d "=" -f2)
packages_file="packages/package_list.json"
git_user="Nicolas Bach"
git_mail="nicolas@mia3.de"
git_branch="main"
loginuser=$(logname)

function get_packages {
    readarray -t essentials < <(jq -r '.essentials[]' "$packages_file")
    readarray -t tools < <(jq -r '.tools[]' "$packages_file")
    readarray -t desktop_programs < <(jq -r '.desktop_programs[]' "$packages_file")
    readarray -t flatpaks < <(jq -r '.flatpaks[]' "$packages_file")


    for essential in "${essentials[@]}"; do
        if ! pacman -Qi $essential &> /dev/null; then
            pacman -S --noconfirm $essential
        else
            echo "$essential already installed"
        fi
    done
}


function configure_git {
    configured_user=$(sudo -u $loginuser git config --list | grep "user\.name" | cut -d '=' -f2)
    configured_mail=$(sudo -u $loginuser git config --list | grep "user\.email" | cut -d '=' -f2)
    default_branch=$(sudo -u $loginuser git config --list | grep "init\.defaultbranch" | cut -d '=' -f2)
    if [[ $configured_user != $git_user  ]]; then
        git config --global user.name "$git_user"
        echo "Set username to $git_user"
    else
        echo "Git User already set"
    fi
    if [[ $configured_mail != $git_mail ]]; then
        git config --global user.mail "$git_mail"
        echo "Set mail to $git_mail"
    else
        echo "Git Mail already set"
    fi
    if [[ $default_branch != $git_branch ]]; then
        git config --global init.defaultBranch $git_branch
        echo "Set git default branch to $git_branch"
    else
        echo "Git Branch already at main"
    fi
}

function install_gui {
    echo "Installing Gnome"
    pacman -S gnome
    systemctl enable gdm.service
}


##############################
#### Starting main Script ####
##############################

if [[ $(id -u) -ne 0 ]]; then
    echo "Please run this script with sudo"
    exit
fi

if [[ "$linux_os_family" == "arch" ]] || [[ "$linux_os" == "arch" ]]; then
    echo "Arch Linux detected"
    pacman -Syu
    if ! pacman -Qi jq &> /dev/null; then
        echo "jq isn't installed, installing it..."
        pacman -S --noconfirm jq
    else
        echo "jq is already installed"
    fi
fi

get_packages
configure_git
# install_gui

# cp dotfiles/.vimrc ~/.vimrc
# vim +PlugInstall +qall
# cd ~/.vim/plugged/YouCompleteMe/
# python3 install.py --clangd-completer
