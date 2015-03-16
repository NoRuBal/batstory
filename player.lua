--player.lua
player = {}

function player.load()
	player.x = map.startx
	player.y = map.starty

	player.width = 32
	player.height = 32
	player.makeecho = true
	player.intervalecho = 1
	player.tmrecho = 0
	
	player.animation = 1
	player.direction = 2 --1:to left 2:to right
	player.tmrani = 0
	player.intani = 0.1
	
	player.fin = false
	player.tmrfin = 0
	
	player.cutscene = false
	player.seq = 0
	player.tmrseq = 0
	player.intseq = 3
end

function player.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(imgbat, quadbat[player.animation + 4 * (player.direction - 1)], player.x, player.y)
end

function player.update(dt)
	--player animation
	player.tmrani = player.tmrani + dt
	if player.tmrani >= player.intani then
		player.tmrani = player.tmrani - player.intani
		if player.animation == 4 then
			player.animation = 1
		else
			player.animation = player.animation + 1
		end
	end
	
	--make echo
	if player.makeecho == true then
		player.tmrecho = player.tmrecho + dt
		if player.tmrecho >= player.intervalecho then
			player.tmrecho = player.tmrecho - player.intervalecho
			echo.new(player.x + player.width / 2, player.y + player.height / 2)
		end
	end
	
	--finish stage
	if player.cutscene == false then
		if player.fin == true then
			player.tmrfin = player.tmrfin + dt
			if player.tmrfin >= 1 then
				map.savecleardata(game.stage, game.map)
				
				if (game.stage == 1) and (game.map == 5) then
					--cutscene 1-5
					player.cutscene = true
					player.makeecho = false
				elseif (game.stage == 2) and (game.map == 5) then
					--cutscene 2-5
					player.cutscene = true
					player.makeecho = false
				elseif (game.stage == 3) and (game.map == 5) then
					--cutscene 3-5
					player.cutscene = true
					player.makeecho = false
				else
					scene.stage.load(game.stage, game.map)
				end
			end
		end
	end
	
	--cutscene sequence
	if player.cutscene == true then
		player.tmrseq = player.tmrseq + dt
		if player.tmrseq >= player.intseq then
			player.tmrseq = player.tmrseq - player.intseq
			player.seq = player.seq + 1
			if player.seq == 5 then
				scene.stage.load(game.stage + 1, 1)
			end
		end
	end
	
	--move player
	if player.fin == false then
		if love.keyboard.isDown("left") == true then
			player.x = player.x - dt * 150
			player.direction = 1
		end
		if love.keyboard.isDown("right") == true then
			player.x = player.x + dt * 150
			player.direction = 2
		end
		if love.keyboard.isDown("up") == true then
			player.y = player.y - dt * 150
		end
		if love.keyboard.isDown("down") == true then
			player.y = player.y + dt * 150
		end
	end
	
	--check player's position
	local tmpr, tmpg, tmpb, tmpa
	tmpr, tmpg, tmpb, tmpa = canvas:getPixel(player.x + player.width / 2, player.y + player.height / 2)
	if tmpa == 255 then
		--dead!
		if player.fin == false then
			player.x = map.startx
			player.y = map.starty
			if (game.map == 5) and (game.stage == 4) then
				scene.stage.load(4, 5)
			end
		end
		
		local a
		for a = 1, #object.item do
			if object.item[a].otype == "r" then
				object.item[a].direction = 0
			end
		end
	end
	
	--check player and goal
	if not( (game.map == 5) and (game.stage == 4) )then
		if player.fin == false then
			if game.check(map.goalx, map.goaly, 48, 48, player.x + player.width / 2, player.y + player.height / 2) then
				player.fin = true
			end
		end
	end
end