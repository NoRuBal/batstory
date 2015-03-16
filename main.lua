require "game"
require "echo"
require "player"
require "scene"
require "map"
require "object"
require "boss"

function love.load()
	--set window mode
	love.window.setMode(800, 600,{borderless = true})
	
	--set line mode
	love.graphics.setLineStyle("rough")
	love.graphics.setDefaultFilter("nearest", "nearest")
	
	--load resources
	--font
	fontcs = love.graphics.newFont("graphics/comic.ttf", 16)
	love.graphics.setFont(fontcs)
	
	--image
	imgmap = ""
	
	imgstage = {}
	imgstage[1] = love.graphics.newImage("graphics/stage_cave.png")
	imgstage[2] = love.graphics.newImage("graphics/stage_forest.png")
	imgstage[3] = love.graphics.newImage("graphics/stage_city.png")
	imgstage[4] = love.graphics.newImage("graphics/stage_laboratory.png")
	
	imgsicon = {}
	imgsicon[1] = love.graphics.newImage("graphics/stage.png")
	imgsicon[2] = love.graphics.newImage("graphics/stage_bat.png")
	imgsicon[3] = love.graphics.newImage("graphics/stage_boss.png")
	imgsicon[4] = love.graphics.newImage("graphics/stage_solved.png")
	
	imgtitle = love.graphics.newImage("graphics/title.png")
	imgbat = love.graphics.newImage("graphics/bat_sprite.png")
	imgbatblack = love.graphics.newImage("graphics/bat_sprite_black.png")
	quadbat = {}
	local a
	for a = 1, 9 do
		quadbat[a] = love.graphics.newQuad((a - 1) * 32, 0, 32, 32, 288, 32)
	end

	imgtutorialc = love.graphics.newImage("graphics/control.png")
	imgtutorialn = love.graphics.newImage("graphics/warning.png")
	
	imgboss = love.graphics.newImage("stage/4/launcher.png")
	imgcore = {}
	imgcore[1] = love.graphics.newImage("stage/4/core1.png")
	imgcore[2] = love.graphics.newImage("stage/4/core2.png")
	imgcore[3] = love.graphics.newImage("stage/4/core3.png")
	imgbullet = love.graphics.newImage("graphics/bullet.png")
	
	--debug mode
	game.debug = false

	scene.title.load()
end

function love.update(dt)
	if game.scene == 1 then --title scene
		scene.title.update(dt)
	elseif game.scene == 2 then
		scene.stage.update(dt)
	elseif game.scene == 3 then --in game
		scene.game.update(dt)
	elseif game.scene == 4 then --ending
		scene.ending.update(dt)
	end
end

function love.draw()
	if game.scene == 1 then --title scene
		scene.title.draw()
	elseif game.scene == 2 then
		scene.stage.draw()
	elseif game.scene == 3 then --in game
		scene.game.draw()
	elseif game.scene == 4 then --ending
		scene.ending.draw()
	end
	
	if game.debug == true then
		love.graphics.print(love.timer.getFPS())
		love.graphics.print(love.mouse.getX() .. ":" .. love.mouse.getY(), 0, 15)
	end
end

function love.keypressed(key)
	if game.scene == 1 then
		scene.title.keypressed(key)
	elseif game.scene == 2 then
		scene.stage.keypressed(key)
	elseif game.scene == 3 then
		scene.game.keypressed(key)
	end

	if key == "escape" then
		love.event.quit()
	elseif key == "s" then
		if game.debug == true then
			if game.showmap == true then
				game.showmap = false
			else
				game.showmap = true
			end
		end
	end
end