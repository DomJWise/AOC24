arrdata = LoadFileToArray('data.txt')

total1 = 0
total2 = 0

totalpuzzles = (arrData~items + 1) /4
do i = 1 to arrData~items-2 by 4
   if ((i -1) /4 ) //25 = 0 & i \= 1 then say 'Processed '||(i-1)/4' of 'totalpuzzles
   parse value arrdata[i  ] with "Button A: X+"ButtonAX', Y+'ButtonAY
   parse value arrdata[i+1] with "Button B: X+"ButtonBX', Y+'ButtonBY
   parse value arrdata[i+2] with "Prize: X="PrizeX", Y="PrizeY
   total1 +=  GetSpendIterative(ButtonAX,ButtonAY, ButtonBX, ButtonBY, PrizeX, PrizeY)
   total2 +=  GetSpendSimultaneous(ButtonAX,ButtonAY, ButtonBX, ButtonBY, 10000000000000+PrizeX, 10000000000000+PrizeY)
end   
say 'Result for part 1 is 'total1
say 'Result for part 2 is 'total2

::routine GetSpendIterative
use arg   ButtonAX,ButtonAY, ButtonBX, ButtonBY, PrizeX, PrizeY
--say 'Checking 'ButtonAX ButtonAY  ButtonBX  ButtonBY  PrizeX  PrizeY
minspend = 0
do apresses = 0 to 100
  do bpresses = 0 to 100
    TotalX = apresses * ButtonAX + bpresses * ButtonBX
    TotalY = apresses * ButtonAY + bpresses * ButtonBY
    if TotalX = PrizeX & TotalY = PrizeY then do
      spend = apresses * 3 + bpresses
      --say ButtonAX ButtonAY  ButtonBX  ButtonBY  PrizeX  PrizeY 'can be done with 'Apresses' A presses and 'Bpresses' B presses with a spend of 'spend
      if minspend = 0 then minspend = spend
      else if spend < minspend then minspend
    end  
  end
end
--say 'Result was 'minspend
return minspend

::routine GetSpendSimultaneous
use arg   ButtonAX,ButtonAY, ButtonBX, ButtonBY, PrizeX, PrizeY
apresses = ((PrizeX * ButtonBY) - (ButtonBX * PrizeY)) / ((ButtonBY * ButtonAX) - (ButtonAY * ButtonBX))
bpresses = ((PrizeX * ButtonAY) - (ButtonAX * PrizeY)) / ((ButtonAY * ButtonBX) - (ButtonAX * ButtonBY))
--say 'Checking 'ButtonAX ButtonAY  ButtonBX  ButtonBY  PrizeX  PrizeY' gives' apresses bpresses

if apresses  = apresses~round & bpresses= bpresses~round & apresses > 0  & bpresses > 0  then return apresses *3 + bpresses
return 0 

::REQUIRES "..\Lib\Utils.rex"
::OPTIONS NOVALUE SYNTAX 
::options digits 31