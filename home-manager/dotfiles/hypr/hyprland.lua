-- Minimal starter so the session is usable (needs Hyprland >= 0.55).
-- Replace everything with your own config.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exit())
