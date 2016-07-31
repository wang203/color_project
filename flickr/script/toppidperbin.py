import numpy as np
import sys

def topusergender(filedir, filename):
  for i in xrange(1,65):
    print i
    uidgendervalue = np.loadtxt(filedir+filename, usecols=(0,3,i+7))
    factor = 10
    headnum = (uidgendervalue.shape[0])/factor
    uidgendervaluesort = np.sort(uidgendervalue.view('float, float, float'), axis=0, order=['f2'])[::-1][:headnum]
  
    headuid = [str(int(np.array(row.tolist())[0][0])) for row in uidgendervaluesort]
    print i
    fout = open(filedir+'tag/toppid'+str(i+1), 'w')
    fout.write('\n'.join(headuid))
#     print '\n'.join(headuid)
    fout.close()







topusergender(sys.argv[1], sys.argv[2])

