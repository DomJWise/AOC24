arrdata = LoadFileToArray('data.txt')

-- Just want one single string
compdata = arrdata~makestring('C')

-- Part 1 
total = 0
charpos = 0
do while compdata~pos('mul(', charpos + 1) \= 0
  charpos = compdata~pos('mul(', charpos + 1)
  endpos = compdata~pos(')',charpos)
  if endpos = 0 then iterate
  vals = compdata~substr(charpos+4, endpos - charpos - 4)~makearray(',')
  if vals~items = 2, vals[1]~datatype('W') , vals[2]~datatype('W'),  vals[1]~length <= 3, vals[2]~length <= 3 then total += vals[1]*vals[2]
end 
say 'Result for part 1 is 'total

-- Part 2
total = 0
on = .True
charpos = 0
do while compdata~pos('mul(', charpos + 1) \= 0
  lastcharpos = charpos + 1
  charpos = compdata~pos('mul(', charpos + 1)
  endpos = compdata~pos(')',charpos)

  -- Need to check all text between the previous and current 'mul(' for most recent of any dos and don'ts
  if charpos > lastcharpos then actioncheckstring = compdata~substr(lastcharpos, charpos - lastcharpos)
  lastdopos = actioncheckstring~lastpos('do()')
  lastdontpos = actioncheckstring~lastpos('don''t()')
  if lastdontpos > lastdopos & on then on = .False
  if lastdopos > lastdontpos & \on then on = .True

  if endpos = 0 then iterate
  vals = compdata~substr(charpos+4, endpos - charpos - 4)~makearray(',')
  if vals~items = 2, vals[1]~datatype('W') , vals[2]~datatype('W'),  vals[1]~length <= 3, vals[2]~length <= 3, on  then total += vals[1]*vals[2]
end 
say 'Result for part 2 is 'total

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::OPTIONS DIGITS 30