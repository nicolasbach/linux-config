-- Define stuff that needs to be started
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar") -- status bar
    hl.exec_cmd("swaybg -i ~/.local/share/wallpapers/a_street_with_buildings_and_signs-1.png") -- wallpaper
    hl.exec_cmd("dunst") -- notifications
end)
