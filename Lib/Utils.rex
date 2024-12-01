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
