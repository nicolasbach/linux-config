-- Custom monitor configuration for my tower
hl.monitor({
    output = "DP-3",
    mode = "preferred",
    position = "0x0"
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "1920x0"
})

hl.monitor({
    output = "DP-1",
    mode = "preferred",
    position = "3840x0"
})

-- Fallback, for example for my laptop
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1
})
