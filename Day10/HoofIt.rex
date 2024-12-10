
arrdata = LoadFileToArray('data.txt')

xrange = arrData[1]~length
yrange = arrData~items

total1 = 0
total2 = 0
symbols = .Directory~new
do y = 1 to yrange
  do x = 1 to xrange
    if arrData[y]~subchar(x) = '0' then do
      total1 = total1 + TrailHeadScore(arrData, y, x)
      total2 = total2 + TrailHeadRating(arrData, y, x)
    end  
  end
end
say 'Total for part 1 is 'total1
say 'Total for part 2 is 'total2

::ROUTINE TrailHeadScore
use arg arrData, ypos, xpos, dy = 0, dx = 0, height = 0, trailendpoints = .nil 


if height = 0 then trailendpoints = .Set~new
ypos += dy
xpos += dx
if ypos = 0 | ypos > arrData~items | xpos = 0 | xpos > arrData[1]~length then return 0
if arrData[ypos]~subchar(xpos) = height then do 
  if height = 9 then do 
    trailendpoints[]=xpos' 'ypos
    return 0 
  end
  if \(dy = 1  & dx =  0) then call TrailHeadScore arrData, ypos, xpos, -1,  0, height + 1, trailendpoints
  if \(dy = -1 & dy =  0) then call TrailHeadScore arrData, ypos, xpos,  1,  0, height + 1, trailendpoints
  if \(dy = 0  & dx = -1) then call TrailHeadScore arrData, ypos, xpos,  0,  1, height + 1, trailendpoints
  if \(dy = 0  & dx =  1) then call TrailHeadScore arrData, ypos, xpos,  0, -1, height + 1, trailendpoints
end
if height = 0 then return trailendpoints~items
return 0

::ROUTINE TrailHeadRating
use arg arrData, ypos, xpos, dy = 0, dx = 0, height = 0, trailpaths = .nil, trailpath = ''

if height = 0 then trailpath = ypos' 'xpos
if height = 0 then do
  trailpaths = .Set~new
  startx=xpos
  starty=ypos
end  
ypos += dy
xpos += dx
trailpath = trailpath||' , 'ypos' 'xpos
if ypos = 0 | ypos > arrData~items | xpos = 0 | xpos > arrData[1]~length then return 0
if arrData[ypos]~subchar(xpos) = height then do 
  if height = 9 then do 
    trailpaths[]=trailpath
    return 0 
  end

  if \(dy = 1  & dx =  0) then call TrailHeadRating arrData, ypos, xpos, -1,  0, height + 1, trailpaths, trailpath
  if \(dy = -1 & dy =  0) then call TrailHeadRating arrData, ypos, xpos,  1,  0, height + 1, trailpaths, trailpath
  if \(dy = 0  & dx = -1) then call TrailHeadRating arrData, ypos, xpos,  0,  1, height + 1, trailpaths, trailpath
  if \(dy = 0  & dx =  1) then call TrailHeadRating arrData, ypos, xpos,  0, -1, height + 1, trailpaths, trailpath
end

if height = 0 then do 
  return trailpaths~items
end  
return 0



::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31