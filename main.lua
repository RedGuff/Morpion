-- TODO!
-- IAs
-- Save, read.
-- configs ++ (FS, sauve IAs).
-- Interface que souris (menus)
-- Interface que clavier (X et O)
function love.conf() -- ?
  love.window.width = 450
  love.window.height = 300
  love.window.borderless = true
  love.window.resizable = true
end

function almostFinished(board)
  totalVide = 0
  for i = 1, 3 do
    for j = 1, 3 do
      if (board[i][j] == 0) then
        totalVide = totalVide + 1
      end
    end
  end
  if (totalVide < 2) then
    return true
  else 
    return false
  end
end


function boardNew()
  availiable="123456789"
  repeat --  3^9 possibilités = 19683, before tests.
    boardRand = {{-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}, {-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}, {-1 +love.math.random( 3 ),-1 +love.math.random( 3 ),-1 +love.math.random( 3 )}} -- 0, 1, or 2 -- Later: more 0 if winAtStart
    board = boardRand
  until ((winAtStart(board) == false) and (almostFinished(board)== false)) -- No win at start, at least 2 choice at start.
  return boardRand
end

function love.load()
  availiable="123456789"
  love.graphics.setBackgroundColor(0.3,0.2, 0.1) 
  x, y, w, h = 10, 100, 120, 120  
  xm, ym = 0, 0
  love.graphics.setLineWidth( h/10 )
-- logo = love.graphics.newImage("Lua-Logo_128x128.png")
-- logoP = love.graphics.newImage("powered-by-lua.gif") -- GIF not supported!
  colorText()
  title = "Morpion   Tic-Tac-Toe"
  love.window.setTitle(title)
  playerToPlay = love.math.random( 2 ) -- 1 or 2
  displayMenu = true
  board = {{0,0,0}, {0,0,0}, {0,0,0}}
  -- sauver
  -- lire
  IAX = 0 -- TODO!
  -- /home/redguff/.local/share/love/Tic-Tac-Toe
  -- %appdata%\LOVE\
  IAX=love.filesystem.read("IAX.txt")
  
  IAXmax = 5 -- TODO!
  IAO = 0 -- TODO!
    IAO=love.filesystem.read("IAO.txt")
  IAOmax = 5 -- TODO!
  -- boardRand=boardNew()

  Exercise = "New exercise from random: F2."
  NewFS = "New game from nothing: F4."
  esQ = "Escape to quit."
  IAXt = "Level of IA for X (X is next): "
  IAOt = "Level of IA for O (O is next): " 
  IALevel0 = "0 = human."
  IALevel1 = "1 = Random. TODO"
  IALevel2 = "2 = Win if obvious. TODO"
  IALevel3 = "3 = Block if obvious. TODO"
  IALevel4 = "4 = Knows that center is important. TODO"
  IALevel5 = "5 = Perfect. TODO"
end

function colorText()
  love.graphics.setColor(0, 1, 1)
end


function love.keyreleased(key)
 -- if(displayMenu == true) then
    if key == "escape" then
      love.event.quit()
    end
    if key == "f4" then
      board = {{0,0,0}, {0,0,0}, {0,0,0}}
      availiable="123456789"
    end

    if key == "f2" then
      board =  boardNew()
    end

    if key == "o" then
      IAO = IAO + 1
      if (IAO > IAOmax) then
        IAO = 0
      end
      --rec:
      love.filesystem.write("IAO.txt", IAO)
    end
    if key == "x" then
      IAX = IAX + 1
      if (IAX > IAXmax) then
        IAX = 0
      end
    --rec:
    love.filesystem.write("IAX.txt", IAX)
    end


--  end
--  displayMenu = false
end


function win(board) -- return player win (1 or 2), 0
  for i = 1, 3 do
    if (board[i][1] * board[i][2] * board[i][3]  == 1) then
      return 1
    end
    if (board[1][i] * board[2][i] * board[3][i]  == 1) then
      return 1
    end
  end
  for i = 1, 3 do
    if (board[i][1] + board[i][2] + board[i][3]  == 6) then
      return 2
    end
    if (board[1][i] + board[2][i] + board[3][i]  == 6) then
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
  if ((button == 1) and (xm>x) and (xm<x+ (3*h)) and (ym>y) and (ym<y+ (3*w)) and (((IAO == 0) and (playerToPlay == 1)) or ((IAX == 0) and (playerToPlay == 2) ))) then -- Inside and human to play.
    i=math.floor((xm-x)/w) +1
    j=math.floor((ym-y)/h)+1
  --  if ((board[i][j]==0) and (displayMenu == false)) then
    if ((board[i][j]==0) and (win(board)== 0)) then
      board[i][j] = playerToPlay
      playerToPlay = 3 - playerToPlay
    end
  end
end

function love.update(dt) -- ici ?
  --[[
  
if ((IAX == 1) and (playerToPlay == 2) and ( win(board) == 0)) then
  repeat
    i= love.math.random( 3 )
    j=love.math.random( 3 )
  until (board[i][j] == 0)
  
  
  board[i][j] = 2
  playerToPlay = 1
  end
if ((IAO == 1) and (playerToPlay == 1) and ( win(board) == 0)) then
  repeat
    i= love.math.random( 3 )
    j=love.math.random( 3 )
  until (board[i][j] == 0)
  
  
  board[i][j] = 1
  playerToPlay = 2
  end
if  (win(board) == 0) then
  dt = dt + 1
  end

--]]
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
    love.graphics.print("Player O wins!", 10, 10)
    displayMenu = true
  end
  if (win(board)==2) then
    colorGraphs(2)
    love.graphics.print("Player X wins!", 10, 10)
    displayMenu = true
  end 
  if (win(board)==0) then

    full = true
    for i = 1, 3 do
      for j = 1, 3 do
        if (board[i][j] == 0) then
          full = false
        end
      end

    end

    if (full == true)    then
      love.graphics.print("Draw!", 10, 10)
      displayMenu = true

    else




  --    displayMenu = false
      colorBkBoard()
      colorText()
      love.graphics.print("Player to play: ", 10, 10)
      colorGraphs(playerToPlay)
      love.graphics.print(playerToPlayXO(playerToPlay), 100, 10)
      colorText()
    end
  end
  colorText()

  --if (displayMenu == true) then
  if (true == true) then

    love.graphics.print(Exercise, 10, 30)
    love.graphics.print(NewFS, 10, 50)
    love.graphics.print(esQ, 10, 70)
    love.graphics.print(IAXt, 380, 30)
    --   love.graphics.print(IAX, 400 + IAXt:len(), 30)
    love.graphics.print(IAX, 553, 30)
    love.graphics.print(IAOt, 380, 50)
-- love.graphics.print(IAO, 400 + IAOt:len(), 50)
    love.graphics.print(IAO, 553 , 50)
    love.graphics.print(IALevel0, 380 , 70)
    love.graphics.print(IALevel1, 380 , 90)
    love.graphics.print(IALevel2, 380 , 110)
    love.graphics.print(IALevel3, 380 , 130)
    love.graphics.print(IALevel4, 380 , 150)
    love.graphics.print(IALevel5, 380 , 170)
  end
  colorBkBoard()
  love.graphics.rectangle("fill", x, y, 3*w, 3*h)
  love.graphics.setColor(0, 0, 0) 
  love.graphics.rectangle("fill", x +w - 1, y, 3, (3*w))
  love.graphics.rectangle("fill", x + 2*w - 1, y , 3, 3*w)
  love.graphics.rectangle("fill", x , y+h , 3*w ,3)
  love.graphics.rectangle("fill", x , y+(2*h), 3*w, 3)

  for i = 1, 3 do
    for j = 1, 3 do
      if (board[i][j]==1) then
        colorGraphs(1)
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
