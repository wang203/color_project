import sys

def join(file_input, file_output):
#  if os.stat(file_input).st_size != 0:
  f = open(file_output, 'w')
  lastfirst = ''
  currenttag = ''
  for line in open(file_input):
    first, rest = line.split(' ',1)
    if first == lastfirst:
      currenttag += ','+rest[:-1]
    else:
      if currenttag:
        # sort and remove duplicate with $currenttag
        f.write((','.join(set(currenttag.split(','))))+'\n')
      currenttag = rest[:-1]
      lastfirst = first
    
  # for last line
  f.write((','.join(set(currenttag.split(','))))+'\n')
  f.close()





join(sys.argv[1], sys.argv[2])
