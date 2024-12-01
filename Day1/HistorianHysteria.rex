arrdata = LoadFileToArray('data.txt')

list1 = .Array~new(arrdata~items)
list2 = .Array~new(arrdata~items)

-- Get the data into sorted arrays
do i = 1 to arrdata~items
  parse value arrdata[i] with list1[i] list2[i]
  list1[i] = list1[i]~strip
  list2[i] = list2[i]~strip
end
list1~sortwith(.NumericComparator~new)
list2~sortwith(.NumericComparator~new)

-- Now add it all up
total = 0
do i = 1 to arrdata~items
   total = total + ABS(list1[i] - list2[i])
end
say 'The answer for part 1 is 'total   

-- Put the second list into a bag for easier counting
total = 0
bag2 = .Bag~new~putall(list2)
do i = 1 to arrData~items
  similarity = list1[i] * bag2~items(list1[i])
  total = total + similarity
end  
say 'The answer for part 2 is 'total   


::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX /* Currently breaks the debugger so comment out if debugging */
