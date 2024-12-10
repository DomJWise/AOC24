
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
total = 0
pos = 1
do pos  = 1 By 1 while blockmap[pos] \= -1
  total = total + blockmap[pos] * (pos -1)

end
say 'Total for part 1 is' total

-- Part 2
say 'Part 2 will take xome time....'
usedblocks = .List~new
freeblocks = .List~new
position = 1
do i = 1 to descriptor~length
  thislen = descriptor~subchar(i)
  if i // 2 = 1 then usedblocks~insert(.Block~new(position, thislen, i % 2), .Nil)
  else freeblocks~append(.Block~new(position, thislen, -1))
  position += thislen
end

--call PrintBlockList freeblocks, 'Free'
--call PrintBlockList usedblocks, 'Used'
itemstoprocess = usedblocks~items
itemsprocessed = 0
do movecandidate over usedblocks~allitems
  itemsprocessed + =1
  if itemsprocessed // 100 = 0 then say 'Processed 'itemsprocessed', 'itemstoprocess - itemsprocessed' remaining'
  --say '>>'movecandidate~makestring
  moved = .False
  passed = .False
  lengthtomove = movecandidate~length
  nextfreeindex = freeblocks~first
  lastfreeindex = freeblocks~last
  freeblockcount = freeblocks~items
  do while \moved & \passed & nextfreeindex <= lastfreeindex
    movecandidatestart = movecandidate~start
    freeblock = freeblocks[nextfreeindex]
    if freeblock~start > movecandidatestart then passed = .True
    else if freeblock~length  >=  lengthtomove then do 
      moved = .True 
      movecandidate~start = freeblock~start
      if freeblock~length = lengthtomove then freeblock~length = 0
      else do
        freeblock~length -= lengthtomove
        freeblock~start += lengthtomove
      end  
    end   
    nextfreeindex += 1
  end  
end

total = 0
do block over usedblocks~allitems
  do i = 0 to block~length - 1
     total += ((block~start + i - 1) * block~fileid)
  end   
end
say 'Total for part 2 is : 'total
--call PrintBlockList freeblocks, 'Free'
--call PrintBlockList usedblocks, 'Used'

::routine PrintBlockList
use arg list, name
str = name': '
do item over list~allitems
  str = str||item~makestring||' '
end
say str
::REQUIRES "Block.cls"

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31
