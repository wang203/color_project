import numpy as np
import sys

def mynorm(a):
  return a/(np.sum(a[1:]))

def topN(a,N):
  return np.argsort(a)[::-1][:N]

def normcount(topnum,filedir):
  topnum = int(topnum)
  filename = filedir+'pidfiltered.tagcount0number'
  tagfile = filedir+'tagentropybin'
  tags = [line.rstrip('\n') for line in open(tagfile)]
  # print len(tags)
  countnum = np.loadtxt(filename)
  out = filedir+'tag4binsum'
  outnorm = np.apply_along_axis(mynorm, 1, countnum)
  print outnorm[104]
  np.savetxt(out+'norm', outnorm, fmt='%1.3f')
  maxidx = np.zeros(65*topnum)
  maxtag = []
  for i in xrange(65):
    maxidx[i*topnum:i*topnum+topnum] = topN(outnorm[:,i+1],topnum)
    for n in xrange(topnum):
      taginfo = tags[int(maxidx[i*topnum+n])+1].split(' ')
      maxtag.append(str(i)+" "+taginfo[0]+" "+taginfo[2][:5]+" "+str(outnorm[int(maxidx[i*topnum+n])][i+1])[:5]+" "+taginfo[1])
  np.savetxt(out, maxtag, fmt='%s')
normcount(sys.argv[1], sys.argv[2])
