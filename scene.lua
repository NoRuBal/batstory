--scene.lua
scene = {}
scene.game = {}
scene.title = {}
scene.stage = {}
scene.ending = {}

function scene.ending.load()
	scene.ending.seqani = 0
	scene.ending.tmrani = 0
	scene.ending.seq = 0
	scene.ending.tmrseq = 0
	
	game.scene = 4
end

function scene.ending.update(dt)
	scene.ending.tmrani  = scene.ending.tmrani + dt
	if scene.ending.tmrani >= 0.2 then
		scene.ending.tmrani = scene.ending.tmrani - 0.2
		if scene.ending.seqani == 1 then
			scene.ending.seqani = 0
		else
			scene.ending.seqani = scene.ending.seqani + 1
		end
	end
	
	scene.ending.tmrseq = scene.ending.tmrseq + dt
	if scene.ending.tmrseq >= 4 then
		scene.ending.tmrseq = scene.ending.tmrseq - 4
		scene.ending.seq = scene.ending.seq + 1
	end
	
end

function scene.ending.draw()
	love.graphics.setColor(255, 255, 255)
	if scene.ending.seqani == 0 then
		love.graphics.draw(imgbat, quadbat[7], 400 - 16, 70)
		love.graphics.draw(imgbat, quadbat[7], 370 - 16, 100)
		love.graphics.draw(imgbat, quadbat[5], 430 - 16, 100)
		love.graphics.draw(imgbat, quadbat[5], 400 - 16, 130)
	else
		love.graphics.draw(imgbat, quadbat[5], 400 - 16, 70 + 1)
		love.graphics.draw(imgbat, quadbat[5], 370 - 16, 100 - 1)
		love.graphics.draw(imgbat, quadbat[7], 430 - 16, 100 + 1)
		love.graphics.draw(imgbat, quadbat[7], 400 - 16, 130 - 1)
	end
	
	if scene.ending.seq == 1 then
		love.graphics.printf("Credits", 0, 192, 800, "center")
	elseif scene.ending.seq == 2 then
		love.graphics.printf("Credits\n\nConcept by: Norubal", 0, 192, 800, "center")
	elseif scene.ending.seq == 3 then
		love.graphics.printf("Credits\n\nProgramming by: Norubal", 0, 192, 800, "center")
	elseif scene.ending.seq == 4 then
		love.graphics.printf("Credits\n\nGraphic Design by: Norubal", 0, 192, 800, "center")
	elseif scene.ending.seq == 5 then
		love.graphics.printf("Credits\n\nBGM: 4′33″ by John Cage", 0, 192, 800, "center")
	elseif scene.ending.seq == 7 then
		love.graphics.printf("Thanks for playing\nPress Esc to quit.", 0, 192, 800, "center")
	elseif scene.ending.seq == 10 then
		love.graphics.printf("I'm looking for people who can work together with me.", 0, 192, 800, "center")
	elseif scene.ending.seq == 11 then
		love.graphics.printf("I'm currently looking for pixel artists and musicians.", 0, 192, 800, "center")
	elseif scene.ending.seq == 12 then
		love.graphics.printf("If you want to join me,", 0, 192, 800, "center")
	elseif scene.ending.seq == 13 then
		love.graphics.printf("..or if you want to be my friend.", 0, 192, 800, "center")
	elseif scene.ending.seq == 14 then
		love.graphics.printf("Please contact me.", 0, 192, 800, "center")
	elseif scene.ending.seq == 15 then
		love.graphics.printf("E-mail: viktor.norubal@yandex.ru\nSkype: viktor.norubal\nBlog:http://norubal.blogspot.com/", 0, 192, 800, "center")
	elseif scene.ending.seq > 15 then
		love.graphics.printf("E-mail: viktor.norubal@yandex.ru\nSkype: viktor.norubal\nBlog:http://norubal.blogspot.com/\n\nThanks for reading!", 0, 192, 800, "center")
	end
	
end

-----------------------------------------------------------------

function scene.game.load()
	game.scene = 3
	
	canvas = love.graphics.newCanvas(800, 600)
	player.load()
	game.load()
	echo.load()
	if (game.stage == 4) and (game.map == 5) then
		boss.load()
	end
end

function scene.game.draw()
	echo.draw()
	if game.showmap == true then
		love.graphics.setColor(0, 0, 255)
		love.graphics.rectangle("fill", 0, 0, 800, 600)
		love.graphics.setColor(255, 255, 255)
	end
	love.graphics.draw(canvas)
	
	--draw goal
	if player.cutscene == false then
		if (game.map == 5) and (game.stage == 4) then
			--boss stage
		else
			love.graphics.draw(imgsicon[1], map.goalx, map.goaly)
		end
	else
		--cutscene
		love.graphics.draw(imgbat, quadbat[9], map.goalx, map.goaly)
		if player.seq == 1 then
			if game.stage == 1 then
				love.graphics.print("Brother!", 94, 333)
			elseif game.stage == 2 then
				love.graphics.print("Sister!", 455, 230)
			elseif game.stage == 3 then
				love.graphics.print("Father!", 695, 450)
			end
		elseif (player.seq == 2) or (player.seq == 3) then
			if game.stage == 1 then
				love.graphics.print("Your sister is in the forest,\nYou should find her!", 42, 310)
			elseif game.stage == 2 then
				love.graphics.print("Your father is in the forest,\nYou should find him!", 400, 210)
			elseif game.stage == 3 then
				love.graphics.print("Your mother is in the Lab,\nYou should find her!", 600, 450)
			end
		end
	end
	
	--draw tutorial
	if (game.stage == 1) and (game.map == 1) then
		love.graphics.draw(imgtutorialc, 42, 44)
		love.graphics.draw(imgtutorialn, 256, 488)
	end
	
	--boss battle
	if (game.stage == 4) and (game.map == 5) then
		boss.draw()
	end
	
	player.draw()
end

function scene.game.update(dt)
	echo.update(dt)
	player.update(dt)
	object.update(dt)
	
	--update map
	love.graphics.setCanvas(canvas)
        canvas:clear()
		love.graphics.draw(imgmap)
		object.draw()
		
    love.graphics.setCanvas()
	--imgmapd = canvas:getImageData()
	
	if (game.stage == 4) and (game.map == 5) then
		boss.update(dt)
	end
end

function scene.game.keypressed(key)
	if (game.stage == 4) and (game.map == 5) then
		boss.keypressed(key)
	end
end

-------------------------------------------------------------------

function scene.title.load()
	game.scene = 1
	scene.title.bat = {}
	scene.title.bat.x = 175
	scene.title.bat.y = 350
	scene.title.bat.animation = 1 --animation
	scene.title.bat.direction = 2 --1:to left 2:to right
	scene.title.bat.tmrani = 0
	scene.title.bat.intani = 0.1
	scene.title.seq = 0 --title sequence. 0~5
	scene.title.tmrseq = 0
	scene.title.intseq = 3
end

function scene.title.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(imgtitle)
	love.graphics.draw(imgbat, quadbat[scene.title.bat.animation + 4 * (scene.title.bat.direction - 1)], scene.title.bat.x, scene.title.bat.y)

	--draw bat's lines
	if scene.title.seq == 1 then
		love.graphics.print("Mommy?\nDaddy?", 166, 300)
	elseif scene.title.seq == 2 then
		love.graphics.print("Brother?\nSister?", 166, 300)
	elseif scene.title.seq == 3 then
		love.graphics.print("Where are you?", 145, 300)
	elseif scene.title.seq == 4 then
		love.graphics.print("I'll find them...", 145, 300)
	end
end

function scene.title.update(dt)
	scene.title.bat.tmrani = scene.title.bat.tmrani + dt
	if scene.title.bat.tmrani >= scene.title.bat.intani then
		scene.title.bat.tmrani = scene.title.bat.tmrani - scene.title.bat.intani
		if scene.title.bat.animation == 4 then
			scene.title.bat.animation = 1
		else
			scene.title.bat.animation = scene.title.bat.animation + 1
		end
	end
	
	scene.title.tmrseq = scene.title.tmrseq + dt
	if scene.title.tmrseq >= scene.title.intseq then
		scene.title.tmrseq = scene.title.tmrseq - scene.title.intseq
		if scene.title.seq < 5 then
			scene.title.seq = scene.title.seq + 1
		end
	end
	
	if not(scene.title.bat.x > 800) then
		if scene.title.seq == 5 then
			scene.title.bat.x = scene.title.bat.x + dt * 150
		end
	end
end

function scene.title.keypressed(key)
	scene.stage.load()
end

-------------------------------------------------------------------

function scene.stage.load(crsstage, crsmap)
	game.scene = 2
	
	--Load saved data
	map.loadcleardata()
	
	--cursor position information
	if crsstage == nil then
		scene.stage.crsstage = 1
		scene.stage.crsmap = 1
	else
		scene.stage.crsstage = crsstage
		scene.stage.crsmap = crsmap
	end
	
	
	scene.stage.crsani = 1 --animation
	scene.stage.tmrani = 0
	scene.stage.intani = 0.1
end

function scene.stage.draw()
	local a
	local tmpsicon
	
	--draw stage icons
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(imgstage[1], 131, 88)
	love.graphics.print("Cave", 158, 184)
	for a = 1, 5 do
		if (game.cleardata[1][a - 1] == true) or (a == 1) then
			tmpsicon = 1
			if a == 5 then
				tmpsicon = 2
			end
			if game.cleardata[1][a] == true then
					tmpsicon = 4
			end
			love.graphics.draw(imgsicon[tmpsicon], 151, 220 + (a - 1) * 60)
		end
	end
	
	if game.cleardata[1][5] == true then
		love.graphics.draw(imgstage[2], 274, 88)
		love.graphics.print("Forest", 299, 184)
		for a = 1, 5 do
			if (game.cleardata[2][a - 1] == true) or (a == 1) then
				tmpsicon = 1
				if a == 5 then
					tmpsicon = 2
				end
				if game.cleardata[2][a] == true then
					tmpsicon = 4
				end
				love.graphics.draw(imgsicon[tmpsicon], 299, 220 + (a - 1) * 60)
			end
		end
	end
	
	if game.cleardata[2][5] == true then
		love.graphics.draw(imgstage[3], 417, 88)
		love.graphics.print("City", 447, 184)
		for a = 1, 5 do
			if (game.cleardata[3][a - 1] == true) or (a == 1) then
				tmpsicon = 1
				if a == 5 then
					tmpsicon = 2
				end
				if game.cleardata[3][a] == true then
					tmpsicon = 4
				end
				love.graphics.draw(imgsicon[tmpsicon], 440, 220 + (a - 1) * 60)
			end
		end
	end
	
	if game.cleardata[3][5] == true then
		love.graphics.draw(imgstage[4], 560, 88)
		love.graphics.print("The Laboratory", 552, 184)
		for a = 1, 5 do
			if (game.cleardata[4][a - 1] == true) or (a == 1) then
				tmpsicon = 1
				if a == 5 then
					tmpsicon = 3
				end
				if game.cleardata[4][a] == true then
					tmpsicon = 4
				end
				love.graphics.draw(imgsicon[tmpsicon], 586, 220 + (a - 1) * 60)
			end
		end
	end
	
	--draw cursor
	local tmpcrsx
	if scene.stage.crsstage == 1 then
		tmpcrsx = 114
	elseif scene.stage.crsstage == 2 then
		tmpcrsx = 264
	elseif scene.stage.crsstage == 3 then
		tmpcrsx = 405
	elseif scene.stage.crsstage == 4 then
		tmpcrsx = 554
	end
	love.graphics.draw(imgbat, quadbat[scene.stage.crsani + 4], tmpcrsx, 224 + (scene.stage.crsmap - 1) * 60)
	
end

function scene.stage.update(dt)
	scene.stage.tmrani = scene.stage.tmrani + dt
	if scene.stage.tmrani >= scene.stage.intani then
		scene.stage.tmrani = scene.stage.tmrani - scene.stage.intani
		if scene.stage.crsani == 4 then
			scene.stage.crsani = 1
		else
			scene.stage.crsani = scene.stage.crsani + 1
		end
	end
end

function scene.stage.keypressed(key)
	if key == "left" then
		if not(scene.stage.crsstage == 1) then
			scene.stage.crsstage = scene.stage.crsstage - 1
			scene.stage.crsmap = 1
		end
	elseif key == "right" then
		if game.cleardata[scene.stage.crsstage][5] == true then
			if not(scene.stage.crsstage == 4) then
				scene.stage.crsstage = scene.stage.crsstage + 1
				scene.stage.crsmap = 1
			end
		end
	elseif key == "up" then
		if not(scene.stage.crsmap == 1) then
			scene.stage.crsmap = scene.stage.crsmap - 1
		end
	elseif key == "down" then
		if game.cleardata[scene.stage.crsstage][scene.stage.crsmap] == true then
			if not(scene.stage.crsmap == 5) then
				scene.stage.crsmap = scene.stage.crsmap + 1
			end
		end
	elseif key == "z" then
		map.read(scene.stage.crsstage, scene.stage.crsmap)
	end
end