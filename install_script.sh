#!/bin/bash

linux_os=$(cat /etc/os-release | grep -E "^ID=.*$" | cut -d "=" -f2)
linux_os_family=$(cat /etc/os-release | grep -E "^ID_LIKE=.*$" | cut -d "=" -f2)
packages_file="packages/package_list.json"

function get_packages {
    readarray -t essentials < <(jq -r '.essentials[]' "$packages_file")
    readarray -t tools < <(jq -r '.tools[]' "$packages_file")
    readarray -t desktop_programs < <(jq -r '.desktop_programs[]' "$packages_file")
    readarray -t flatpaks < <(jq -r '.flatpaks[]' "$packages_file")

    for essential in "${essentials[@]}"; do
        echo "$essential"
    done
}

if [[ "$linux_os_family" == "arch" ]] || [[ "$linux_os" == "arch" ]]; then
    echo "Arch Linux detected"
    #pacman -Syu
    #pacman -S jq
fi

get_packages
