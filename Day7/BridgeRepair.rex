arrdata = LoadFileToArray('data.txt')
total1 = 0
total2 = 0

processed = 1
lines = arrData~items

do line over arrdata
  parse value line with target': 'numberlist
  if TargetPossible(target, numberlist) then total1 += target
  if TargetPossible(target, numberlist, .True) then total2 += target
  processed += 1
  if processed // 25 = 0 then say 'Processed 'processed' out of 'lines
end  
say 'Result for part 1 is 'total1
say 'Result for part 2 is 'total2

::routine TargetPossible

  use arg target, numberlist, includeconcat = .False, currentval = '', operation = ''

  parse value numberlist with nextval numberlist
  nextval= strip(nextval)
  numberlist = strip(numberlist)
  if operation = '+' then currentval += nextval
  else if operation = '*' then currentval = currentval*nextval
  else if operation = '||' then currentval=currentval||nextval
  else if operation = '' then currentval = nextval
  else NOP

  if currentval > target then return .False
  if numberlist = '' then do
    if currentval = target  then return .True
    else return .false
    end
  else do 
    if includeconcat, TargetPossible(target, numberlist, includeconcat, currentval, '||') then return .True
    if TargetPossible(target, numberlist, includeconcat, currentval, '*') then return .True
    return TargetPossible(target, numberlist, includeconcat, currentval, '+') 
  end

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31