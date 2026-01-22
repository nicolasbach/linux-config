#!/usr/bin/env bash
EFI_PATH="/boot/efi"

cp /boot/vmlinuz-linux "$EFI_PATH/"
cp /boot/initramfs-linux* "$EFI_PATH/"
cp /boot/*-ucode.img "$EFI_PATH/"

sbctl sign-all
