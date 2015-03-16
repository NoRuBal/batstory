function love.conf(t)
	t.window.width = 800
	t.window.height = 600
	
	t.modules.joystick = false
    t.modules.physics = false
	t.version = "0.9.0"
	
	t.window.title = "Bat Story"
	t.window.icon = nil
	t.window.borderless = true
	--t.console = true
end