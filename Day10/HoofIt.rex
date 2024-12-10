
arrdata = LoadFileToArray('data.txt')

xrange = arrData[1]~length
yrange = arrData~items

total = 0
symbols = .Directory~new
do y = 1 to yrange
  do x = 1 to xrange
    if arrData[y]~subchar(x) = '0' then total = total + TrailHeadScore(arrData, y, x)
  end
end
say 'Total for part 1 is 'total

::ROUTINE TrailHeadScore
use arg arrData, ypos, xpos, dy = 0, dx = 0, height = 0, trailendpoints = .nil 

if height = 10 then do 
  trailendpoints[]=xpos' 'ypos
  return 0 
end
if height = 0 then trailendpoints = .Set~new
ypos += dy
xpos += dx
if ypos = 0 | ypos > arrData~items | xpos = 0 | xpos > arrData[1]~length then return 0
if arrData[ypos]~subchar(xpos) = height then do 
  if \(dy = 1  & dx =  0) then call TrailHeadScore arrData, ypos, xpos, -1,  0, height + 1, trailendpoints
  if \(dy = -1 & dy =  0) then call TrailHeadScore arrData, ypos, xpos,  1,  0, height + 1, trailendpoints
  if \(dy = 0  & dx = -1) then call TrailHeadScore arrData, ypos, xpos,  0,  1, height + 1, trailendpoints
  if \(dy = 0  & dx =  1) then call TrailHeadScore arrData, ypos, xpos,  0, -1, height + 1, trailendpoints
end

if height = 0 then return trailendpoints~items
return 0




::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31