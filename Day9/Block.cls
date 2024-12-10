::class Block public
  ::attribute start 
  ::attribute length
  ::attribute fileid

  ::method init
    expose start length fileid
    use arg start,length,fileid

  ::method makestring
    expose start length fileid
    if fileid = -1 then return '['start' += 'length' : free]'
    else return '['start' += 'length' : 'fileid']'

