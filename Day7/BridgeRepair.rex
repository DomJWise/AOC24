arrdata = LoadFileToArray('data.txt')
total = 0
operatoroptions = '+*'

do line over arrdata
  parse value line with target': 'numberlist
  operators = numberlist~words - 1
  found = .False   

  selector = 0
  found = .False

  --- Check multiply all numbers is >= target
  maxpossiblecalcstring = 'maxpossible='numberlist~translate('*',' ')
  interpret maxpossiblecalcstring
  if maxpossible < target then iterate

  -- Check add all numbers (with all 1 removed, because of multiply ) <= target
  minnumberlist = numberlist
  do while minnumberlist~wordpos('1') \= 0
    minnumberlist = minnumberlist~delword(minnumberlist~wordpos('1'), 1)
  end    
  minpossiblecalcstring = 'minpossible='minnumberlist~strip~translate('+',' ')
  interpret minpossiblecalcstring
 
  if minpossible < 1 then do
    say 'impossible 'minpossiblecalcstring  ' = 'minpossible '( vs' target ')'
    say line
    iterate
  end    

  -- Got through +* operations
  do selector = 0 to 2 **  operators  - 1 while \found
    operatorstring = selector~d2x(4)~x2b~right(operators)~translate('+*','01')
    --say operatorstring
    testval=numberlist~word(1)
    do k = 1 to operators
      if operatorstring~subchar(k) = '+' then testval = testval + numberlist~word(k+1)
      else testval = testval * numberlist~word(k+1)
      if testval > target then leave
    end  
    --say '['target']' testval' : ' calcstring
    if testval = target then do
      total += testval
      found = .True
    end  
  end
end   
say 'Result for part 1 is 'total

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31