
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
antinodes1 = .Set~new
antinodes2 = .Set~new
do with item symbolpoints over symbols

  -- Process each point pair
  points = symbolpoints~allitems -- gets an array
  do reference = 1 to points~items
    do other = reference + 1 to points~items
      referencepoint = points[reference]
      otherpoint = points[other]

      -- Part 1
      antinode1 = .Point~new(otherpoint~x, otherpoint~y)~~add(otherpoint)~~subtract(referencepoint)
      antinode2 = .Point~new(referencepoint~x, referencepoint~y)~~add(referencepoint)~~subtract(otherpoint)
      if CheckRange(antinode1, width, height) then antinodes1[]=antinode1~makestring
      if CheckRange(antinode2, width, height) then antinodes1[]=antinode2~makestring

      -- Part 2
      diff = .Point~new(otherpoint~x, otherpoint~y)~~subtract(referencepoint)
      gcd = GetGcd(diff~x, diff~y)
      if gcd \= 1 then diff = .Point~new(diff~x / gcd, diff~y / gcd)
      
      start = referencepoint~copy
      do while CheckRange(start, width, height)
        antinodes2[]=start~makestring  
        start~add(diff)
      end

      start = referencepoint~copy
      do while CheckRange(start, width, height)
        antinodes2[]=start~makestring  
        start~subtract(diff)
      end
        
    end  
  end
end    

say 'Total for part 1 is : 'antinodes1~items
say 'Total for part 2 is : 'antinodes2~items

::routine CheckRange
use arg point, width, height
return point~x >=1 & point~x <= width & point~y >=1 & point~y <= height


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