boss = {}

function boss.load()
	boss.bullet = {}
	boss.tmrbullet = 0
	
	boss.core = {}
	boss.core[1] = {}
	boss.core[1].x = 11
	boss.core[1].y = 11
	boss.core[1].hp = 1
	
	boss.core[2] = {}
	boss.core[2].x = 717
	boss.core[2].y = 11
	boss.core[2].hp = 1
	
	boss.core[3] = {}
	boss.core[3].x = 11
	boss.core[3].y = 517
	boss.core[3].hp = 1
	
	boss.core[4] = {}
	boss.core[4].x = 717
	boss.core[4].y = 517
	boss.core[4].hp = 1
	
	boss.cutscene = 0 --0:starting cutscene 1:in-game 2:ending cutscene
	boss.cutseq = 0
	boss.tmrseq = 0
	
	player.makeecho = false
end

function boss.newbullet()
	local index
	index = #boss.bullet + 1
	local a
	for a = 1, #boss.bullet do
		if boss.bullet[a].enabled == false then
			index = a
		end
	end
	
	boss.bullet[index] = {}
	boss.bullet[index].x = 389
	boss.bullet[index].y = 288
	local angle = math.atan2((player.y - 288), (player.x - 389))
	boss.bullet[index].speedx = 200 * math.cos(angle)
	boss.bullet[index].speedy = 200 * math.sin(angle)
	
	boss.bullet[index].enabled = true
end

function boss.update(dt)
	if boss.cutscene == 0 then
		boss.tmrseq = boss.tmrseq + dt
		if boss.tmrseq >= 3 then
			boss.tmrseq = boss.tmrseq - 3
			boss.cutseq = boss.cutseq + 1
			if boss.cutseq == 4 then
				boss.cutseq = 0
				boss.cutscene = 1
				player.makeecho = true
			end
		end
	elseif boss.cutscene == 1 then
		--move bullet
		local a
		for a = 1, #boss.bullet do
			if boss.bullet[a].enabled == true then
				boss.bullet[a].x = boss.bullet[a].x + boss.bullet[a].speedx * dt
				boss.bullet[a].y = boss.bullet[a].y + boss.bullet[a].speedy * dt
				
				--check player and bullet
				if game.check(boss.bullet[a].x, boss.bullet[a].y, 22, 22, player.x + player.width / 2, player.y + player.height / 2) then
					scene.stage.load(4, 5)
				end
				
				if (boss.bullet[a].x < -22) or (boss.bullet[a].x > 800) or (boss.bullet[a].y < -22) or (boss.bullet[a].y > 600) then
					boss.bullet[a].enabled = false
				end
			end
		end
		
		boss.tmrbullet = boss.tmrbullet + dt
		if boss.tmrbullet >= 1 then
			boss.tmrbullet = boss.tmrbullet - 1
			boss.newbullet()
		end

		boss.tmrseq = boss.tmrseq + dt
		if boss.tmrseq >= 1 then
			boss.tmrseq = boss.tmrseq - 1
			
			local a
			for a = 1, 4 do
				if boss.core[a].hp < 4 then
					if game.check(boss.core[a].x, boss.core[a].y, 72, 72, player.x + player.width / 2, player.y + player.height / 2) then
						boss.core[a].hp = boss.core[a].hp + 1
					end
				end
			end
			
			if (boss.core[1].hp >= 4) and (boss.core[2].hp >= 4) and (boss.core[3].hp >= 4) and (boss.core[4].hp >= 4) then
				boss.cutseq = 0
				boss.cutscene = 2
				player.makeecho = false
				object.item = {}
				boss.bullet = {}
			end
		end
	elseif boss.cutscene == 2 then
		boss.tmrseq = boss.tmrseq + dt
		if boss.tmrseq >= 3 then
			boss.tmrseq = boss.tmrseq - 3
			boss.cutseq = boss.cutseq + 1
			if boss.cutseq == 4 then
				boss.cutseq = 0
				scene.ending.load()
			end
		end
	end
end

function boss.keypressed(key)
	if boss.cutscene == 0 then
		boss.cutseq = 0
		boss.cutscene = 1
		player.makeecho = true
	end
end

function boss.draw()
	if boss.cutscene == 1 then
		--draw core
		local a
		for a = 1, #boss.core do
			if boss.core[a].hp < 4 then
				love.graphics.draw(imgcore[boss.core[a].hp], boss.core[a].x, boss.core[a].y)
			end
		end
		love.graphics.draw(imgboss, 364, 264)
	end
	
	--draw bullet
	local a
	for a = 1, #boss.bullet do
		if boss.bullet[a].enabled == true then
			love.graphics.draw(imgbullet, boss.bullet[a].x, boss.bullet[a].y)
		end
	end
	
	--draw cutscene
	if boss.cutscene == 0 then
		if boss.cutseq == 0 then
			love.graphics.print("Mommy? where are you?", player.x - 70, player.y - 30)
		elseif boss.cutseq == 1 then
			love.graphics.print("Sir, we detected something in the Core Room.", player.x - 70, player.y + 300)
		elseif boss.cutseq == 2 then
			love.graphics.print("Core Protecting System, operation.", player.x - 70, player.y + 300)
		end
	elseif boss.cutscene == 2 then
		if boss.cutseq == 0 then
			love.graphics.print("Mommy! I missed you!", player.x - 70, player.y - 30)
		elseif boss.cutseq == 1 then
			love.graphics.print("I caught by humans,\nThey wanted to make something harmful with my microwave.", 284, 234)
		elseif boss.cutseq == 2 then
			love.graphics.print("Everything is done, let's go home.", 284, 234)
		end
		love.graphics.draw(imgbat, quadbat[9], 384, 284)
	end
end