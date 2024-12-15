arrdata = LoadFileToArray('data.txt')

width = 0
height = 0
robots = .bag~new
do dataline over arrData~allitems
   parse value dataline with 'p='xpos','ypos' v='xspeed','yspeed .
   if xpos > width then width = xpos
   if ypos > height then height = ypos
   --say xpos ypos xspeed '"'yspeed'"'
   robots[]=(xpos ypos xspeed yspeed)
 end  
width += 1
height += 1
--say '>' width height
quadrantscores = .Array~of(0,0,0,0)
total = 0
--say robots~items
do robot over robots
  parse value robot with xpos ypos xspeed yspeed
  finalx = .nil
  finaly = .nil
  finalx = (xpos + xspeed * 100) // width
  finaly = (ypos + yspeed * 100) // height
  if finalx < 0 then finalx += width
  if finaly < 0 then finaly += height

  if finalx = (width - 1) / 2 | finaly = (height - 1) / 2 then iterate
  
  if finalx < width / 2 then xhalf = 0
                        else xhalf = 1
  if finalY < height / 2 then yhalf = 0 
                          else yhalf = 1

  quadrantscores[xhalf + (yhalf * 2) + 1] += 1
  --say robot' -> 'finalx finaly '('xhalf','yhalf')'
end
--say quadrantscores~makestring
total = quadrantscores[1] * quadrantscores[2] * quadrantscores[3] * quadrantscores[4]
say 'Total for part 1 is 'total

-- Part 2 - minimize the safety factor i.e assume there is lots of clustering meaning some quadrants have very low scores
-- Hint provided by HyperNeutrino on Youtube
xpos = .array~new(robots~items)
ypos = .array~new(robots~items)
xspeed = .array~new(robots~items)
yspeed = .array~new(robots~items)
do counter i with index robot over robots
  parse value robot with xpos[i] ypos[i] xspeed[i] yspeed[i]
end

minsf = -1
bestiteration = -1
iteration = 0
do iteration  =  1 to width * height 
  if iteration // 1000 = 0 then say 'On iteration 'iteration' of 'width * height 
  quadrantscores = .Array~of(0,0,0,0)
  total = 0
  --say robots~items
  do i = 1 to robots~items
    xpos[i] = (xpos[i] + xspeed[i] +width) // width
    ypos[i] = (ypos[i] + yspeed[i] + height) // height
    if xpos[i] \= (width - 1) / 2 & ypos[i] \= (height - 1) / 2 then do
  
      if xpos[i] < width / 2 then xhalf = 0
                            else xhalf = 1
      if ypos[i] < height / 2 then yhalf = 0 
                              else yhalf = 1

      quadrantscores[xhalf + (yhalf * 2) + 1] += 1
    end  
  end
  sf = quadrantscores[1] * quadrantscores[2] * quadrantscores[3] * quadrantscores[4]
  if minsf = -1 | sf < minsf then do 
    bestiteration = iteration
   minsf = sf
  end
end
say 'Minimum score is for iteration 'bestiteration

grid = .array~new(height)
do i = 1 to height
  grid[i] = .MutableBuffer~new('.'~copies(width))
end
do robot over robots
  parse value robot with xpos ypos xspeed yspeed
  finalx = ((xpos + bestiteration * xspeed  // width)  + width)  // width
  finaly = ((ypos + bestiteration * yspeed  // height) + height) // height
  grid[finaly + 1]~replaceat('*',finalx + 1, 1)
end

do i over grid~allindexes
  say i~right(3)' 'grid[i]~string
end
say
say' If you see a christmas tree above, the result for part 2 is 'bestiteration
::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31