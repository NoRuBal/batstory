object = {}

function object.load(stage, amap)
	object.item = {}
	object.image = {}
	
	
end

function object.new(otype, xo, yo, xd, yd, direction, speed, image, movingdirection)
	local a
	local index
	
	index = #object.item + 1
	
	object.item[index] = {}
	object.item[index].otype = otype --m:moving r:rotating d:disappearing
	object.item[index].xo = xo --origin x
	object.item[index].yo = yo --origin y
	object.item[index].xd = xd --destination x
	object.item[index].yd = yd --destination y
	object.item[index].x = xo
	object.item[index].y = yo
	if otype == "r" then
		direction = tonumber(direction)
	end
	object.item[index].direction = direction --moving direction. up/down. for rotating type, will store angle blink:show/hide
	object.item[index].speed = speed --object will move dt * speed amount.
	object.item[index].image = love.graphics.newImage(image)
end

function object.draw()
	local a
	for a = 1, #object.item do
		if object.item[a].otype == "m" then
			love.graphics.setCanvas(canvas)
				love.graphics.draw(object.item[a].image, object.item[a].x, object.item[a].y)
			love.graphics.setCanvas()
		elseif object.item[a].otype == "r" then
			love.graphics.setCanvas(canvas)
				love.graphics.draw(object.item[a].image, object.item[a].x, object.item[a].y, object.item[a].direction, 1, 1, (object.item[a].image:getWidth() / 2), (object.item[a].image:getHeight() / 2))
			love.graphics.setCanvas()
		elseif object.item[a].otype == "b" then
			if object.item[a].direction == "show" then
				love.graphics.setCanvas(canvas)
					love.graphics.draw(object.item[a].image, object.item[a].x, object.item[a].y)
				love.graphics.setCanvas()
			end
		else
		end
	end
end

function object.update(dt)
	local a
	for a = 1, #object.item do
		if object.item[a].otype == "m" then
			if object.item[a].direction == "up" then
				object.item[a].y = object.item[a].y - dt * object.item[a].speed
				if object.item[a].y < object.item[a].yd then
					if object.item[a].direction == "down" then
						object.item[a].direction = "up"
					else
						object.item[a].direction = "down"
					end
				end
			elseif object.item[a].direction == "down" then
				object.item[a].y = object.item[a].y + dt * object.item[a].speed
				if object.item[a].y > object.item[a].yo then
					if object.item[a].direction == "down" then
						object.item[a].direction = "up"
					else
						object.item[a].direction = "down"
					end
				end
			end
		elseif object.item[a].otype == "r" then
			object.item[a].direction = object.item[a].direction + object.item[a].speed * dt
			if object.item[a].direction >= 3.14 * 2 then
				object.item[a].direction = object.item[a].direction - 3.14 * 2
			end
		elseif object.item[a].otype == "b" then
			object.item[a].xd = object.item[a].xd + dt
			if object.item[a].xd >= object.item[a].speed then
				object.item[a].xd = object.item[a].xd - object.item[a].speed
				if object.item[a].direction == "show" then
					object.item[a].direction = "hide"
				else
					object.item[a].direction = "show"
				end
			end
		end
	end
end