-- game.lua
-- load and manage game's main objects
game = {}

function game.load() --environment settings
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.keyboard.setKeyRepeat(true)
	love.filesystem.setIdentity("bat")
	
	game.scene = 3 --1:title, 2:stage select, 3:in-game
	game.stage = 0
	game.map = 0
	game.showmap = false
	
	map.loadcleardata()
end

function game.check(imgx, imgy, imgwidth, imgheight, mousex, mousey)
    if (imgx + imgwidth) > mousex and imgx < mousex then
        if (imgy + imgheight) > mousey and imgy < mousey then
            return true
        end
    end

	return false
end

function string:split(inSplitPattern, outResults) --adopted from Lua user wiki
	if not outResults then
		outResults = { }
	end
	local theStart = 1
	local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	while theSplitStart do
		table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
		theStart = theSplitEnd + 1
		theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	end
	table.insert( outResults, string.sub( self, theStart ) )
	return outResults
end