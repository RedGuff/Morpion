function love.conf() -- ?
  love.window.width = 500
  love.window.height = 300
  love.window.borderless = true
  love.window.resizable = true
end

function love.load()
  love.graphics.setBackgroundColor(0.3,0.2, 0.1) 
  x, y, w, h = 10, 70, 120, 120  
  xm, ym = 0, 0
  love.graphics.setLineWidth( h/10 )
-- logo = love.graphics.newImage("Lua-Logo_128x128.png")
-- logoP = love.graphics.newImage("powered-by-lua.gif") -- GIF not supported!
  colorText()
  title = "Morpion   Tic-Tac-Toe"
  love.window.setTitle(title)
  playerToPlay = love.math.random( 2 ) -- 1 or 2
  displayMenu = true
  boardNew = {{0,0,0}, {0,0,0}, {0,0,0}}
  -- sauver
  -- lire

  board = boardNew
  repeat --  3^9 possibilités = 19683.
    boardRand = {{-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}, {-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}, {-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}} -- 0, 1, or 2 -- Later: more 0 if winAtStart
    board = boardRand
  until (winAtStart(board) == false) -- No win at start.

  NewFS = "New game from nothing."
  Exercise = "New exercise from random."
end


function colorText()
  love.graphics.setColor(0, 1, 1)
end


function win(board) -- return player win (1 or 2), 0
  for i = 1, 3 do
    if (board[i][1] * board[i][2] * board[i][3]  == 1) then
      return 1
    end
  end
  for j = 1, 3 do
    if (board[1][j] * board[2][j] * board[3][j]  == 1) then
      return 1
    end
  end
  for i = 1, 3 do
    if (board[i][1] + board[i][2] + board[i][3]  == 6) then
      return 2
    end
  end
  for j = 1, 3 do
    if (board[1][j] + board[2][j] + board[3][j]  == 6) then
      return 2
    end
  end
  if (board[1][1] + board[2][2] + board[3][3]  == 6) then
    return 2
  end
  if (board[3][1] + board[2][2] + board[1][3]  == 6) then
    return 2
  end
  if (board[1][1] * board[2][2] * board[3][3]  == 1) then
    return 1
  end
  if (board[3][1] * board[2][2] * board[1][3]  == 1) then
    return 1
  end  
  return 0
end


function winAtStart(board)
  if (win(board)== 0) then
    return false
  end
  return true
end


function colorBkBoard()
  love.graphics.setColor(1, 1, 0)
end



function love.mousepressed(xm, ym, button, istouch)
  -- love.graphics.print("xm : ", 500, 10)
  -- love.graphics.print("".. xm, 550, 10) 
  if ((button == 1) and (xm>x) and (xm<x+ (3*h)) and (ym>y) and (ym<y+ (3*w))) then 
    -- love.graphics.print("".. xm, 550, 10) 
    i=math.floor((xm-x)/w) +1
    j=math.floor((ym-y)/h)+1
    
    if (board[i][j]==0) then
    board[i][j] = playerToPlay
    playerToPlay = 3 - playerToPlay
    end
  end
end

function love.update(dt)

  displayMenu = true

end

function colorGraphs(player)
  if (player == 1 ) then
    love.graphics.setColor(1, 0, 0) 
  end
  if (player == 2 ) then
    love.graphics.setColor(0, 0, 1) 
  end
end

function playerToPlayXO(player)
  if (player == 1) then 
    return "O"
  end
  if (player == 2) then 
    return "X"
  end
end

function love.draw()


  if (win(board)==1) then
    colorGraphs(1)
    love.graphics.print("Player 1 O wins!", 10, 10)
    displayMenu = true
  end
  if (win(board)==2) then
    colorGraphs(2)
    love.graphics.print("Player 2 X wins!", 10, 10)
    displayMenu = true
  end 
  if (win(board)==0) then
    displayMenu = false
    colorBkBoard()
    colorText()
    love.graphics.print("Player to play: ", 10, 10)
    colorGraphs(playerToPlay)
    love.graphics.print(playerToPlayXO(playerToPlay), 100, 10)
    colorText()
  end
  colorText()

  if (displayMenu == true) then
    love.graphics.print(NewFS, 10, 30)
    love.graphics.print(Exercise, 10, 50)
  end
  colorBkBoard()
  love.graphics.rectangle("fill", x, y, 3*w, 3*h)
  love.graphics.setColor(0, 0, 0) 
  love.graphics.rectangle("fill", x +w - 1, y - 1, 3 , (3*w))
  love.graphics.rectangle("fill", x + 2*w - 1, y - 1, 3 , 3*w)
  love.graphics.rectangle("fill", x - 1, y+h - 1,   3*w ,3)
  love.graphics.rectangle("fill", x - 1, y+(2*h) - 1,  3*w, 3 )

  for i = 1, 3 do
    for j = 1, 3 do
      if (board[i][j]==1) then
        colorGraphs(1)

        -- love.graphics.circle( "fill", (x/2) + i*(w), ( y/2) + (h/2)+ j*h, h/ 3)
        love.graphics.circle( "fill", x + w*(i-0.5),  y + h*(j-0.5), h/ 3)
        colorBkBoard()
        love.graphics.circle( "fill", x + w*(i-0.5), y + h*(j-0.5), h/ 4)
      end
      if (board[i][j]==2) then
        colorGraphs(2)
        love.graphics.line(x  - w + (w/5) + (i*w), y -h + (h/4)+(j*h), x - w + (w/5) + (i*w) + (3 * h/5), y -h + (h/4)+(j*h)+ (3 * h/5)) 
        love.graphics.line( x - w + (w/5) + (i*w) + (3 * h/5), y -h + (h/4)+(j*h),x + - w + (w/5) + (i*w), y -h + (h/4)+(j*h)+ (3 * h/5)) 
      end
    end
  end
  colorBkBoard()
end
