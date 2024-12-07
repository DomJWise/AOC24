arrdata = LoadFileToArray('data.txt')
total = 0
do line over arrdata
  parse value line with target': 'numberlist
  if TargetPossible(target, numberlist) then total += target
end  
say 'Result for part 1 is 'total

::routine TargetPossible

  use arg target, numberlist, currentval = '', operation = ''

  if operation = '' then do
    parse value numberlist with currentval numberlist
    currentval= strip(currentval)
    numberlist = strip(numberlist)

    if TargetPossible(target, numberlist, currentval, '*') then return .True
    else if TargetPossible(target, numberlist, currentval, '+') then return .True
    else return .False
  end  

  else if numberlist~strip = '' then return .False

  else do -- * OR + 
    parse value numberlist with nextval numberlist
    nextval= strip(nextval)
    numberlist = strip(numberlist)
    if operation = '+' then currentval += nextval
    else currentval =  currentval * nextvaL
    if numberlist = '' then do
      if currentval = target then return .True
      else return .false
      end
    else do 
      if  TargetPossible(target, numberlist, currentval, '*') then return .True 
      else 
      return TargetPossible(target, numberlist, currentval, '+')
    end  

  end



::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31