arrdata = LoadFileToArray('data.txt')
height = arrData~items
width = arrData[1]~length
say height
say width

-- Part 1
wordtoFind = 'XMAS'
total = 0
do y = 1 to height
  do x = 1 to width
     total += FindWord(arrData,x,y,  1, 0,width, height, wordtofind)
     total += FindWord(arrData,x,y,  1, 1,width, height, wordtofind)
     total += FindWord(arrData,x,y,  0, 1,width, height, wordtofind)
     total += FindWord(arrData,x,y, -1, 1,width, height, wordtofind)
     total += FindWord(arrData,x,y, -1, 0,width, height, wordtofind)
     total += FindWord(arrData,x,y, -1,-1,width, height, wordtofind)
     total += FindWord(arrData,x,y,  0,-1,width, height, wordtofind)
     total += FindWord(arrData,x,y,  1,-1,width, height, wordtofind)
   end
 end
 say 'Result for part 1 = 'total

-- Part 2 (something more general would be better but more work)
total = 0
do y = 2 to height - 1
  do x = 2 to width - 1
    if arrData[y]~subchar(x) = 'A' then do
    if arrData[y-1]~subchar(x-1) = 'M' & arrData[y+1]~subchar(x+1) = 'S' | ,
       arrData[y-1]~subchar(x-1) = 'S' & arrData[y+1]~subchar(x+1) = 'M' then 
       if arrData[y-1]~subchar(x+1) = 'M' & arrData[y+1]~subchar(x-1) = 'S' | ,
          arrData[y-1]~subchar(x+1) = 'S' & arrData[y+1]~subchar(x-1) = 'M' then total += 1
    end      
   end
 end
say 'Result for part 1 = 'total


 ::routine FindWord
 use arg arrdata, x, y, dx, dy, width, height, wordtofind
 len = wordtofind~length
 if dx = -1 & x < len then return 0
 if dx =  1 & x > width - len + 1 then return 0
 if dy = -1 & y < len then return 0
 if dy =  1 & y > height - len + 1 then return 0
 do i = 1 to len
   if arrdata[y + dy * (i -1)]~subchar(x + dx * (i -1)) \= wordtofind~subchar(i) then return 0
 end
 return 1


::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::OPTIONS DIGITS 30