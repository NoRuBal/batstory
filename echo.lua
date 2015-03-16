-- echo.lua
-- manage echo

echo = {}

function echo.load()
	echo.maxradius = 100
	echo.speed = 90
	echo.item = {}
end

function echo.new(x, y)
	local a
	local index
	
	index = #echo.item + 1
	for a = 1, #echo.item do
		if echo.item[a].enabled == false then
			index = a
			break
		end
	end
	
	echo.item[index] = {}
	echo.item[index].x = x
	echo.item[index].y = y
	echo.item[index].radius = 0
	echo.item[index].enabled = true
end

function echo.update(dt)
	local a
	for a = 1, #echo.item do
		echo.item[a].radius = echo.item[a].radius + dt * echo.speed
		if echo.item[a].radius >= echo.maxradius then
			echo.item[a].radius = 0
			echo.item[a].enabled = false
		end
	end
end

function echo.draw()
	local a
	for a = 1, #echo.item do
		if echo.item[a].enabled == true then
			love.graphics.setColor(255, 255, 255)
			love.graphics.setLineWidth(5)
			love.graphics.circle("line", echo.item[a].x, echo.item[a].y, echo.item[a].radius)
			love.graphics.setLineWidth(1)
		end
	end
end