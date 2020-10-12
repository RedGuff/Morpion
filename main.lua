function love.load()
	fond = love.graphics.newImage("graphics/Fond.png")
	X = love.graphics.newImage("graphics/X_256.png")
	O = love.graphics.newImage("graphics/O_256.png")
end

function love.draw()
	love.graphics.draw(fond,0,0)

	love.graphics.draw(O,530,0)	
	love.graphics.draw(X,0,530)

end