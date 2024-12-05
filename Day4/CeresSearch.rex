arrdata = LoadFileToArray('data.txt')
height = arrData~items
width = arrData[1]~length

-- Part 1
wordtoFind = 'XMAS'
total = 0
do y = 1 to height
  do x = 1 to width
    do dx = -1 to 1
      do dy = -1 to 1
        if dx \= 0 | dy \= 0 then total += FindWord(arrData,x,y,  dx, dy,width, height, wordtofind)
      end 
    end
   end
 end
 say 'Result for part 1 = 'total

-- Part 2
total = 0
word = 'MAS'
xextent = word~length
distancetomiddle = (xextent - 1) / 2
centerletter = word~subchar(distancetomiddle + 1)
nop

do y = 1 + distancetomiddle to height - distancetomiddle
  do x = 1 + distancetomiddle to width - distancetomiddle
    if arrData[y]~subchar(x) = centerletter then do
      word1 = ''
      word2 = ''
      do i = - distancetomiddle to distancetomiddle
        word1 = word1||arrData[y + i]~subchar(x + i)
        word2 = word2||arrData[y + i]~subchar(x - i)
      end
      if (word1=word | word1 = word~reverse) &  (word2=word | word2 = word~reverse) then total += 1
    end  
   end
 end
 
say 'Result for part 2 = 'total

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