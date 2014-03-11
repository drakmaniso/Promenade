function love.conf(t)
    t.identity = "Promenade"
    t.version = "0.9.0"
    t.console = false

    t.window.title = "Promenade"
    t.window.icon = nil
    t.window.width = 1280
    t.window.height = 720
    t.window.resizable = true
    t.window.minwidth = 16
    t.window.minheight = 9
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = true
    t.window.fsaa = 4

    t.modules.joystick = false
    t.modules.physics = false
end
