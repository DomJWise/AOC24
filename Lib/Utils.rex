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
