arrdata = LoadFileToArray('data.txt')
width = arrData[1]~length
height = arrData~items
arrGrid = .Array~new(height, width)


.local["DIR.UP"]   = '^'
.local["DIR.DOWN"] = 'V'
.local["DIR.LEFT"] = '<'
.local["DIR.RIGHT"] = '>'
MovesFor =.Directory~new
MovesFor~right =.Directory~new~~put( 1, "DX")~~put( 0, "DY")
MovesFor~left  =.Directory~new~~put(-1, "DX")~~put( 0, "DY")
MovesFor~up    =.Directory~new~~put( 0, "DX")~~put(-1, "DY")
MovesFor~down  =.Directory~new~~put( 0, "DX")~~put( 1, "DY")
.local["MOVES.FOR"] = MovesFor

do y = 1 to height
  do x = 1 to width
    arrGrid[y,x] = arrdata[y]~subchar(x) 
    if arrGrid[y,x] = '^' then do 
      guard = .Directory~new
      guard~startx = x
      guard~starty = y
      guard~startdirection = .Dir.Up

    end
  end
end
visited = WalkGrid(arrGrid, guard)

--call PrintGrid(arrGrid)

say 'Total for part 1 is 'visited

possibleblocks = .Directory~new
possibleblocks~x = .Array~new(visited - 1)
possibleblocks~y = .Array~new(visited - 1)
index = 1
do y = 1 to height
  do x = 1 to width
    if '+-|'~pos(arrGrid[y,x]) \= 0 then do
      possibleblocks~x[index] = x
      possibleblocks~y[index] = y
      index += 1
    end
  end
end    

totalloops = 0
do index = 1 to  possibleblocks~x~items
  call ResetGrid arrGrid, arrData
  arrGrid[possibleblocks~y[index], possibleblocks~x[index]] = 'O'
  visited = WalkGrid(arrGrid, guard)
  --call PrintGrid arrGrid
  if visited = -1 then totalloops += 1
  if index // 10 = 0 then say 'Traversed 'index 'paths'
end
say 'Total for part 2 is 'totalloops


/*
do i over possibleblocks~allitems
arrData
call PrintGrid arrGrid
*/

/**/ NOP

::ROUTINE WalkGrid
use arg arrGrid, guard
width = arrGrid~dimension(2)
height = arrGrid~dimension(1)

dirvisits = .Directory~new

guard~y = guard~starty
guard~x = guard~startx
guard~direction = guard~startdirection
dirvisits~put(guard~direction, guard~y' 'guard~x)

visited = 1
finished = .False
do while \Finished & visited \= -1
  /**/ NOP
  select case guard~Direction
    when .Dir.Up   then  movedelta = .Moves.For~up
    when .Dir.Left then  movedelta = .Moves.For~Left
    when .Dir.Down then  movedelta = .Moves.For~Down
    when .Dir.Right then movedelta = .Moves.For~Right
  end  
  nextx = guard~x + movedelta~dx
  nexty = guard~y + movedelta~dy
  
  if nexty = 0 | nextx = 0 | nexty = height + 1 | nextx = width + 1 then Finished = .True
  else if arrGrid[nexty, nextx] = '#' | arrGrid[nexty, nextx] = 'O' then do 
    arrGrid[guard~y, guard~x] = '+'
    select case guard~Direction
      WHEN .Dir.Left  then guard~Direction = .Dir.Up
      WHEN .Dir.Up    then guard~Direction = .Dir.Right
      WHEN .Dir.Right then guard~Direction = .Dir.Down
      WHEN .Dir.Down  then guard~Direction = .Dir.Left
    end
  end
  else do
    select case guard~Direction
      WHEN .Dir.Left  then newmarker = '-'
      WHEN .Dir.Right then newmarker = '-'
      WHEN .Dir.Up    then newmarker = '|'
      WHEN .Dir.Down  then newmarker = '|'
    end
     
    Guard~x = nextx
    Guard~y = nexty

    if arrGrid[guard~y, guard~x] = "." then 
    do
      --say '>'guard~y' 'guard~x
    
      visited +=1 
      arrGrid[guard~y, guard~x] = newmarker
      dirvisits~put(guard~direction, guard~y' 'guard~x)
    end  
    else 
    do
      currentmarker = arrGrid[guard~y, guard~x]
      --say guard~y' 'guard~x
      currentvisits = dirvisits~at(guard~y' 'guard~x)
      if currentvisits~pos(guard~direction) \= 0 then visited = -1
      else dirvisits~put(currentvisits||guard~direction, guard~y' 'guard~x)
      if (currentmarker = '-' | currentmarker = '|') & currentmarker \= newmarker then arrGrid[guard~y, guard~x] = '+'
    end        
  end
  if visited = -1 then do 
    --say guard~y guard~x guard~direction arrGrid[guard~y, guard~x] newmarker
    arrGrid[guard~y, guard~x] = 'X'
    end
end  
/**/nop
return visited

::ROUTINE ResetGrid
use arg arrGrid, arrData
width = arrGrid~dimension(2)
height = arrGrid~dimension(1)
do y = 1 to height
  do x = 1 to width
    arrGrid[y,x] = arrdata[y]~subchar(x) 
  end
end

::ROUTINE PrintGrid
use arg arrGrid

do y = 1 to arrGrid~dimension(1)
  out = ''
  do x= 1 to arrGrid~dimension(2)
    out=out||arrGrid[y,x]
  end
  say out
end
say
return

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 