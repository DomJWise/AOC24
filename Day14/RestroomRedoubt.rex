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


::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31