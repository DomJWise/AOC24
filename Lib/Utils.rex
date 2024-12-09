::routine LoadFileToArray public 
use strict arg infile

strm = .Stream~new(infile)
status = strm~open('READ SHAREREAD')
if status \= 'READY:' then do 
  say 'Error opening input file 'infile' : ' status
  return .nil
  end
arrLines = strm~arrayIn('L')

strm~close

return arrLines

::ROUTINE GetGcd public
use arg num1,num2
finished = .False
gcd = 1
do while \finished
  do i = 2 to MIN(num1, num2)
    num1 = num1~abs
    num2 = num2~abs
    if num1 // i = 0 & num2 // i = 0 then do 
      gcd = gcd * i
      num1 = num1 / i
      num2 = num2 / i
      leave
    end  
  end
  if i >  MIN(num1, num2) then finished = .True
end
return gcd

::class Point public
  ::attribute x
  ::attribute y

  ::method init
    expose x y
    use arg x,y

    ::method add
    expose x y
    use arg other
    x += other~x
    y += other~y
    
    ::method subtract
    expose x y
    use arg other
    x -= other~x
    y -= other~y

  ::method RotateRight
    expose x y
    tmp = y
    y = -x
    x = tmp

  ::method makestring
    expose x y
    return x y
