import numpy as np
from scipy import misc
import os
import sys

def gray(directory):

  out = open(directory+'streetview-nongray','w')
  gray_pixel = []
  lengray = 0
  path = directory+'photos'
  listing = os.listdir(path)
  print sum([len(files) for r, d, files in os.walk(path)])
  for i in xrange(10,100):
#     # rename folder
#     os.rename(path+'/___'+str(i), path+'/'+str(i))
    path = directory+'photos/'+str(i)
    listing = os.listdir(path)
    for files in listing:
      ## rename files
      uniqid = files.split('_')[0]
      pid = files.split('_')[1].split('.')[0]

#       out.write(pid+" "+uniqid+'\n')

      try:
        im = misc.imread(path+'/'+files)
      except IOError, e:
        print e.errno
        print path+'/'+files 
        os.remove(path+'/'+files)
        break 

      except:
        print 'error'
        print path+'/'+files
        os.remove(path+'/'+files)
        break 
      h, w, c = im.shape
      im = im.reshape(w*h, c)
      nonzerocount = np.count_nonzero(im - [228, 227, 223])
      if nonzerocount == 7158:
        lengray += 1
        os.remove(path+'/'+files) 
      else:
        # print 'find nongray'
        os.rename(path+'/'+files, path+'/'+uniqid+'_.jpg')
        out.write(pid+' '+uniqid+'\n')
        #np.savetxt(out,im,fmt='%d')
  print lengray
  out.close()
gray(sys.argv[1])
