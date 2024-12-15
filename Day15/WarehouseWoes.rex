arrdata = LoadFileToArray('data.txt')
listgridstrings = .List~new
listmovestrings = .List~new
doinggrid = .true
do data over arrData~allitems
  if data = '' then do 
    doinggrid = .False
    iterate
  end  
  if doinggrid = .True then listgridstrings~append(data)
                       else listmovestrings~append(data)
end

height = listgridstrings~items
width = listgridstrings[0]~length
say height width
grid = .Array~new(height, width)
do counter i with item line over listgridstrings
  do j = 1 to line~length
    grid[i,j] = line~subchar(j)
    if grid[i,j] = '@' then robotpos = .point~new(j,i)
  end
end
SAY 'Start:'
call PrintGrid grid
do with item moves over listmovestrings
  do i = 1 to moves~length
   call ProcessMove grid, robotpos, moves[i]
  end
end
say
say 'End:'
call PrintGrid grid
--say robotpos~makestring
total = 0
do i = 1 to height
  do j = 1 to width
     if grid[i,j] = 'O' then total += (((i -1) * 100) + (j -1))
  end
end
say 'The score for part 1 is : 'total

::ROUTINE ProcessMove
  use arg grid, robotpos, move

  if move = '<' then vect = .Point~new(-1, 0)
  else if move = '>' then vect = .Point~new(1, 0)
  else if move = '^' then vect = .Point~new(0, -1)
  else if move = 'v' then vect = .Point~new(0, 1)

  testpos = .Point~new~~copyfrom(robotpos)
  blocked  = .False
  freeend = .False
  do while \blocked & \freeend
    testpos~add(vect)
  --  say testpos~makestring  grid[testpos~y, testpos~x]
    if grid[testpos~y, testpos~x] = '#' | testpos~x = 0 | testpos~y = 0 | testpos~x > grid~dimension(2) | testpos~y > grid~dimension(1) then blocked = .true
    else if grid[testpos~y, testpos~x] = '.' then freeend = .true
  end  
  if \blocked then do 
    do while \testpos~equals(robotpos)
      y = testpos~y
      x = testpos~x
      testpos~subtract(vect)
      grid[y,x] = grid[testpos~y, testpos~x]
    end  
    grid[robotpos~y, robotpos~x] = '.'
    robotpos~add(vect)
  end
  
--say 'After move 'move ': (blocked = 'blocked')' 
--robotpos~makestring
--call PrintGrid grid
--say

::ROUTINE PrintGrid
use arg grid

do i = 1 to grid~dimension(1)
  do j = 1 to grid~dimension(2)
    call charout ,grid[i,j]
  end
  say 
end
    

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31