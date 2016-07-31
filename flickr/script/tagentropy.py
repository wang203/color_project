import numpy as np
from scipy.stats import entropy
import sys

def tagentropy(filedir, filename):
  fout = open(filedir+'pidfiltered.tagentropy', 'w')
  fmaxidx = open(filedir+'pidfiltered.maxidx','w')
#   fout = open(filedir+'tagentropy', 'w')
#   fmaxidx = open(filedir+'maxidx','w')
  fin = open(filedir+filename, 'r')
  tagstat = fin.read().split('\n')
  for i in xrange(len(tagstat)-1):
    line = np.fromstring(tagstat[i], sep=' ')
    prob = (line/line[0])[1:]
    print i
    # print prob
    # print type(prob)
    # print entropy(prob)
    fout.write(str(entropy(prob))+'\n')
    fmaxidx.write(str(np.argmax(prob))+'\n')

  fin.close()
  fout.close()
  fmaxidx.close()
    



#   tagstat = np.loadtxt(filedir+filename)
#   print tagstat.shape
#   print tagstat[0]
#   probtagstat = np.divide(tagstat.T, tagstat[:,0]).T[:,1:]
#   print probtagstat.shape
#   print probtagstat[0]
#   print 'per row'
#   entropyperrow = np.apply_along_axis(entropy, 0, probtagstat)
#   print entropyperrow

tagentropy(sys.argv[1], sys.argv[2])
