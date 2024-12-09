
arrdata = LoadFileToArray('data.txt')

descriptor = arrData[1]

-- Part 1
blocks = 0
do i = 1 to descriptor~length
  blocks += descriptor~subchar(i)
end
blockmap = .array~new(blocks)
blockindex = 1
spacestofill = 0
do i = 1 to descriptor~length
  do j = 1 to descriptor~subchar(i)
    if i // 2 = 1 then blockmap[blockindex] = i % 2 
    else do 
      blockmap[blockindex] = -1
      spacestofill += 1
    end  
    blockindex += 1
  end  
end
nextspace = 1
nextitemtomove = blockmap~items

do i = 1 to spacestofill
  do while blockmap[nextspace] \= -1
    nextspace += 1
  end
  blockmap[nextspace] = blockmap[nextitemtomove]
  blockmap[nextitemtomove] = -1
  nextitemtomove -= 1
end
---say blockmap~items' 'blockmap~makestring('L', ',')

total = 0
pos = 1
do pos  = 1 By 1 while blockmap[pos] \= -1
  total = total + blockmap[pos] * (pos -1)

end
--say spacestofill
say 'Total for part 1 is' total

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31
