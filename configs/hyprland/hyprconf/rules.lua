-- Have the same workspaces always on the same monitors
hl.workspace_rule({ workspace = "1", monitor = "DP-3" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-3" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-3" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })

-- Allow float for conky
hl.window_rule({
    name = "conky-allow-float",
    match = {
        class = "conky"
    },
    float = true,
    no_focus = true,
})
