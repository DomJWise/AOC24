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
  do referencepoint over symbolpoints~allitems
    do otherpoint over symbolpoints~allitems
      if referencepoint \= otherpoint then 
      do
        -- Part 1
        antinode = .Point~new(otherpoint~x, otherpoint~y)~~add(otherpoint)~~subtract(referencepoint)
        if antinode~x >= 1 & antinode~x <= width & antinode~y >= 1 & antinode~y <= height then antinodes1[]=antinode~makestring
        --say referencepoint~makestring' to 'otherpoint~makestring' -> 'antinode~makestring

        -- Part 2
        diff = .Point~new(otherpoint~x, otherpoint~y)~~subtract(referencepoint)
        if diff~x = 0 then do 
          do y = 1 to height
            antinodes2[]=.Point~new(referencepoint~x, y)
          end
        end
        else if diff~y = 0 then do
          do x = 1 to width
            antinodes2[]=.Point~new(y, referencepoint~x)
          end
        end  
        else do /* y = [gradeint]x + [intercept] */
          gradient = diff~y /diff~x
          intercept = (referencepoint~y + otherpoint~y - gradient * (referencepoint~x + otherpoint~x)) / 2
          do x = 1 to width
            y = ((gradient * x + intercept) * 1000) ~round / 1000 -- Safely round to 3dp
            if y >=1 & y <= height & y = y~round then do 
               newantinode =.Point~new(x,y~round)~makestring
               antinodes2[]=newantinode~makestring
            end
          end  
        end  
      end  
    end
  end    
end

say 'Total for part 1 is : 'antinodes1~items
say 'Total for part 2 is : 'antinodes2~items

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