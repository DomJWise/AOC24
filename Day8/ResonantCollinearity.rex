arrdata = LoadFileToArray('data.txt')

width = arrData[1]~length
height = arrData~items

symbols = .Directory~new

-- Get all points into a dorectory of sets
do y = 1 to height
  do x = 1 to width
    symbol = arrData[y]~subchar(x)
    if symbol  \= '.' then do
      point = .point~new(x, y)
      if \symbols~hasindex(symbol) then symbols[symbol] = .Set~new
      symbols[symbol][]=point
    end
  end
end    

-- Set to uniquely store all resonant points
antinodes = .Set~new
do with item symbolpoints over symbols

  -- Process each point pair
  do referencepoint over symbolpoints~allitems
    do otherpoint over symbolpoints~allitems
      if referencepoint \= otherpoint then 
      do
         antinode = .Point~new(otherpoint~x, otherpoint~y)~~add(otherpoint)~~subtract(referencepoint)
         if antinode~x >= 1 & antinode~x <= width & antinode~y >= 1 & antinode~y <= height then antinodes[]=antinode~makestring
        --say referencepoint~makestring' to 'otherpoint~makestring' -> 'antinode~makestring
       end  
    end
  end    
end
say 'Total for part 1 is : 'antinodes~items

::ROUTINE displaysymbols
use arg symbols
do with index symbolname item points over symbols
  say 'Points for "'symbolname'" are:'
  do point over points~allitems
    say '  'point~makestring
  end  
  say
end

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31