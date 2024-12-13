arrdata = LoadFileToArray('data.txt')

-- Simple string expansion method (ok for low numbers)
pebbles = arrdata[1]
do blinks = 1 to 25
  newpebbles = .MutableBuffer~new('',pebbles~length * 2)
  do pebble over pebbles~subwords(1)
    if pebble = 0 then newpebbles~append('1 ')
    else if pebble~length // 2 = 0 then newpebbles~append(pebble~left(pebble~length % 2) * 1' 'pebble~substr(pebble~length % 2 + 1) * 1' ')
    else newpebbles~append(pebble * 2024' ')
  end
  pebbles = newpebbles~string    
end
say 'Part 1 result is 'pebbles~words

--- Recursive memoisation approach needed for more iterations
pebbles = arrdata[1]
total = 0
cache = .Directory~new() -- Can be reused across initial pebbles
do pebble over pebbles~subwords(1) 
  next = pebblebreed(cache, pebble, 75)
  --say pebble' -> ' next
  total = total + next
end
say 'Part 2 result is 'total
say 

::routine pebblebreed
 
 use arg cache, pebble, blinksremaining
  if blinksremaining = 0 then return 1
  else if \cache~hasindex(pebble blinksremaining) then do
    total = 0
    if pebble = 0 then total = pebblebreed(cache,1, blinksremaining - 1)
    else if pebble~length // 2 = 0 then total =pebblebreed(cache, pebble~left(pebble~length % 2) * 1,       blinksremaining - 1) + ,
                                               pebblebreed(cache, pebble~substr(pebble~length % 2 + 1) * 1, blinksremaining - 1)
    else  total =  pebblebreed(cache, pebble * 2024, blinksremaining - 1)             
    cache[pebble' 'blinksremaining] = total  
  end
 -- say cache[pebble' 'blinksremaining]
  return cache[pebble' 'blinksremaining]

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31