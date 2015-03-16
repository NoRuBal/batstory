--map.lua
map = {}

function map.read(stage, amap) --load map file, return as table
	local file
	local tmp
	local tblfile
	local a
	imgmap = love.graphics.newImage("stage/".. stage  .. "/" .. amap ..".png")
	file = love.filesystem.newFile("stage/".. stage  .. "/" .. amap ..".txt")
	file:open("r")
	tmp = file:read(all)
	tblfile = {}
	for a in file:lines() do
		table.insert (tblfile, a);
	end
	map.startx = tonumber(tblfile[1])
	map.starty = tonumber(tblfile[2])
	map.goalx = tonumber(tblfile[3])
	map.goaly = tonumber(tblfile[4])
	object.load()
	for a = 5, #tblfile do
		local tmpobj
		tmpobj = tblfile[a]:split(":")
		if (tmpobj[1] == "m") or (tmpobj[1] == "r") or (tmpobj[1] == "b") then
			object.new(tmpobj[1], tonumber(tmpobj[2]), tonumber(tmpobj[3]), tonumber(tmpobj[4]), tonumber(tmpobj[5]), tmpobj[6], tonumber(tmpobj[7]), tmpobj[8], tmpobj[9])
		end
	end
	scene.game.load()
	game.stage = stage
	game.map = amap
	file:close()
end

function map.loadcleardata() --load clear data
	game.cleardata = {}
	local a
	for a = 1, 4 do
		game.cleardata[a] = {}
		for b = 1, 5 do
			game.cleardata[a][b] = false
		end
	end
	
	if love.filesystem.exists("map.txt") == true then
		local file
		local tmp
		local tblfile
		local a
		local b
		local tmpline
		file = love.filesystem.newFile("map.txt")
		file:open("r")
		tmp = file:read(all)
		tblfile = {}
		for a in file:lines() do
			table.insert (tblfile, a);
		end
		
		for a = 1, #tblfile do
			tmpline = tblfile[a]:split(":")
			for b = 1, #tmpline do
				if tmpline[b] == "true" then
					game.cleardata[a][b] = true
				elseif tmpline[b] == "false" then
					game.cleardata[a][b] = false
				end
			end
		end
		file:close()
	else
		local tmp = ""
		for a = 1, #game.cleardata do
			tmp = tmp .. tostring(game.cleardata[a][1]) .. ":" .. tostring(game.cleardata[a][2]) .. ":" .. tostring(game.cleardata[a][3]) .. ":" .. tostring(game.cleardata[a][4]) .. ":" .. tostring(game.cleardata[a][5]) .. "\n"
		end
		
		local file
		file = love.filesystem.newFile("map.txt")
		file:open("w")
		file:write(tmp)
		file:close()
	end
end

function map.savecleardata(stage, amap)
	game.cleardata[stage][amap] = true
	
	local a
	local tmp = ""
	for a = 1, #game.cleardata do
		tmp = tmp .. tostring(game.cleardata[a][1]) .. ":" .. tostring(game.cleardata[a][2]) .. ":" .. tostring(game.cleardata[a][3]) .. ":" .. tostring(game.cleardata[a][4]) .. ":" .. tostring(game.cleardata[a][5]) .. "\n"
	end
	
	local file
	file = love.filesystem.newFile("map.txt")
	file:open("w")
	file:write(tmp)
	file:close()
end