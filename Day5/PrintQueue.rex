arrdata = LoadFileToArray('data.txt')
listRules = .List~new
listUpdates = .List~new
do data over arrData~allitems
  if data~pos('|') \= 0 then listRules~append(data~makeArray('|'))
  else if data~strip \= '' then listUpdates~append(data~makeArray(','))
end

total1 = 0
total2 = 0
do update over listUpdates~allItems
  matches =  .True
  do rule over listRules~allItems
    if update~hasitem(rule[1]), update~hasitem(rule[2]), update~index(rule[1]) > update~index(rule[2]) then do
      nop
      matches = .False
      leave
    end
  end
  nop
  if matches then do 
    --say 'Total 1 is having 'update[(update~items +1)/2]' added'
    total1 += update[(update~items +1)/2]
    end
  else do
    -- Have to iteratively find an item with no rules showing it on the right, then remove both it and the rules which contain it
    sortedupdate = .array~new
    setrules = .list~new
    do rule over listRules~allItems
      if update~hasitem(rule[1]) & update~hasitem(rule[2]) then setrules~append(rule)
    end
    do while update~items > 0
      do testindex = 1 to update~items
        onright = .False
        do rule over setrules while \onright
          if rule[2] = update[testindex] then onright = .True
        end
        if \onright then leave 
      end  
      newsetrules = .list~new

      do rule over setrules~allitems
       if rule[1] \= update[testindex] then newsetrules~append(rule)
      end
      setrules = newsetrules
      sortedupdate~append(update[testindex])
      update~delete(testindex)
    end
    total2 += sortedupdate[(sortedupdate~items +1)/2]
  end
end  
say 'Part 1 result is 'total1
say 'Part 2 result is 'total2



::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 