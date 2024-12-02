arrdata = LoadFileToArray('data.txt')

totalsafe = 0
do report over arrData
  levels = report~makearray(' ') 
  if CheckSafe(levels) then totalsafe += 1
end
say 'Part 1 result is : 'totalsafe

totalsafe = 0
do report over arrData
  levels = report~makearray(' ') 
  safe = .False
  if CheckSafe(levels) then safe = .True
  else do 
    safe = .False
    do i= 1 to levels~items
      reducedlevels = report~makearray(' ')~~delete(i)
      if CheckSafe(reducedlevels) then do
        safe = .True
        leave
      end
    end    
  end
  if safe then totalsafe += 1
end
say 'Part 2 result is : 'totalsafe

::ROUTINE CheckSafe
use arg levels
safe = .True
if levels[2] > levels[1] then do j = 2 to levels~items
  diff = levels[j] - levels[j -1] 
  if  diff < 1 | diff >3 then do 
    safe = .False
    leave
  end  
end  
else  do j = 2 to levels~items
  diff = levels[j-1] - levels[j] 
  if diff diff <1 | diff >3 then do 
    safe = .False
    leave
  end  
end
return safe

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
