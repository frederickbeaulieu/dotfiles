-- Keybinds mirrored from ghostty

rex.bind("cmd+t", "client.tab.new")
rex.bind("cmd+n", "client.tab.next")
rex.bind("cmd+p", "client.tab.previous")

rex.bind("cmd+h", "pane.focus", { direction = "left" })
rex.bind("cmd+j", "pane.focus", { direction = "down" })
rex.bind("cmd+k", "pane.focus", { direction = "up" })
rex.bind("cmd+l", "pane.focus", { direction = "right" })

rex.bind("shift+cmd+h", "pane.split", { direction = "left" })
rex.bind("shift+cmd+j", "pane.split", { direction = "down" })
rex.bind("shift+cmd+k", "pane.split", { direction = "up" })
rex.bind("shift+cmd+l", "pane.split", { direction = "right" })

rex.bind("shift+cmd+f", "pane.zoom")

rex.bind("shift+cmd+left", "pane.resize", { direction = "left", amount = 10 })
rex.bind("shift+cmd+right", "pane.resize", { direction = "right", amount = 10 })
rex.bind("shift+cmd+down", "pane.resize", { direction = "down", amount = 10 })
rex.bind("shift+cmd+up", "pane.resize", { direction = "up", amount = 10 })

rex.bind("cmd+s", "session.switch")
rex.bind("shift+cmd+r", "session.rename")
rex.bind("shift+cmd+t", "client.tab.rename")

-- Sessions
rex.bind("shift+cmd+n", "session.next")
rex.bind("shift+cmd+p", "session.previous")
rex.bind("shift+cmd+s", "pane.go_to_directory")
rex.bind("ctrl+cmd+w", "session.close")

-- Floating panes: cmd+g shows/hides them, shift+cmd+g creates one
rex.bind("cmd+g", "pane.minimize_all_floating")
rex.bind("shift+cmd+g", "pane.new_floating")

-- Panes
rex.bind("shift+cmd+=", "pane.balance")
rex.bind("ctrl+cmd+h", "pane.move", { direction = "left" })
rex.bind("ctrl+cmd+j", "pane.move", { direction = "down" })
rex.bind("ctrl+cmd+k", "pane.move", { direction = "up" })
rex.bind("ctrl+cmd+l", "pane.move", { direction = "right" })
