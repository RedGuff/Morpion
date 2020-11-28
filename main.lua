function love.conf()
  love.window.width = 1000
  love.window.height = 400
  love.window.borderless = true
  love.window.resizable = true


end-- Load some default values.

function love.load()
  x, y, w, h = 100, 200, 100, 100
  love.graphics.setLineWidth( h/10 )
-- logo = love.graphics.newImage("Lua-Logo_128x128.png")
-- logoP = love.graphics.newImage("powered-by-lua.gif") -- GIF not supported!
  title = "Morpion   Tic-Tac-Toe"
  love.window.setTitle(title)
  
  playerToPlay = love.math.random( 2 ) -- 1 or 2
  displayMenu = true
  boardNew = {{0,0,0}, {0,0,0}, {0,0,0}}
  boardTest = {{1,0,0}, {1,1,0}, {2,2,2}}
  boardRand = {{-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}, {-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}, {-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}} -- 0, 1, or 2 -- Later: more 0 if winAtStart

  NewFS = "New game from nothing."
  Exercise = "New exercise from random."
end


function love.update(dt)
  displayMenu = true

end



function love.draw()
  love.graphics.print("Player to play: ", 10, 10)
  love.graphics.print(playerToPlay, 100, 10)

  if (displayMenu == true) then
    love.graphics.print(NewFS, 10, 30)
    love.graphics.print(Exercise, 10, 50)
  end
  love.graphics.setColor(1, 0.4, 0.4)
  love.graphics.rectangle("fill", x, y, 3*w, 3*h)
  love.graphics.setColor(0, 0, 0) 
  love.graphics.rectangle("fill", x + w, y, 3 , x + 2*w)
  love.graphics.rectangle("fill", x + 2*w, y, 3 , x + 2*w)
  love.graphics.rectangle("fill", h, y+h,   x + 2*w,3)
  love.graphics.rectangle("fill", h, y+2*h,  x + 2*w, 3 )
for i = 1, 3 do
for j = 1, 3 do
 if (boardRand[i][j]==1) then
  love.graphics.setColor(1, 0, 0) 
   love.graphics.circle( "fill", (x/2) + i*(w), ( y/2) + (h/2)+ j*h, h/ 3)
  love.graphics.setColor(1, 0.4, 0.4)  
   love.graphics.circle( "fill", (x/2) + i*(w), ( y/2) + (h/2)+ j*h, h/ 4)
   
   end
 if (boardRand[i][j]==2) then
     love.graphics.setColor(0, 0, 1) 
love.graphics.line(x + - w + (w/4) + (i*w), y -h + (h/4)+(j*h), x - w + (w/4) + (i*w) + (3 * h/5), y -h + (h/4)+(j*h)+ (3 * h/5)) 
love.graphics.line( x - w + (w/4) + (i*w) + (3 * h/5), y -h + (h/4)+(j*h),x + - w + (w/4) + (i*w), y -h + (h/4)+(j*h)+ (3 * h/5)) 

   end
 
 
  end
  
  end


  love.graphics.setColor(1, 0.4, 0.4)


end
