import numpy as np
import sys
from multiprocessing import Pool

def runpool(i):
  filedir = sys.argv[1]
  filename = sys.argv[2]
  topusergender(filedir, filename, i)

def topusergender(filedir, filename,i):
  print i
  uidgendervalue = np.loadtxt(filedir+filename, usecols=(0,3,i+7))
  factor = 10
  headnum = (uidgendervalue.shape[0])/factor
  uidgendervaluesort = np.sort(uidgendervalue.view('float, float, float'), axis=0, order=['f2'])[::-1][:headnum]

  headuid = [str(int(np.array(row.tolist())[0][0])) for row in uidgendervaluesort]
  print i
  fout = open(filedir+'toppid'+str(i+1), 'w')
  fout.write('\n'.join(headuid))
  #  print '\n'.join(headuid)
  fout.close()







if __name__ == '__main__':
  pool = Pool(processes = 20)
  pool.map(runpool, range(45,65))
  pool.close()
  pool.join()
