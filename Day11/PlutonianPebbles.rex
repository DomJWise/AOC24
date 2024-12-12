arrdata = LoadFileToArray('data.txt')

pebbles = arrdata[1]

do blinks = 1 to 25
  newpebbles = .MutableBuffer~new('',pebbles~length * 2)
  do pebble over pebbles~subwords(1)
    --say '>'pebble
    if pebble = 0 then newpebbles~append('1 ')
    else if pebble~length // 2 = 0 then newpebbles~append(pebble~left(pebble~length % 2) * 1' 'pebble~substr(pebble~length % 2 + 1) * 1' ')
    else newpebbles~append(pebble * 2024' ')
--    say '..'newpebbles~string
  end
  pebbles = newpebbles~string    
  --say blinks pebbles
end
say 'Part 1 result is 'pebbles~words

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31