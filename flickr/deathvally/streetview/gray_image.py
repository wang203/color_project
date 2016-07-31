import numpy as np
from scipy import misc
import os

def gray():

  out = open('streetview-nongray','w')
  gray_pixel = []
  lengray = 0
  path = 'photos'
  listing = os.listdir(path)
  print sum([len(files) for r, d, files in os.walk(path)])
  for i in xrange(10,100):
    os.rename(path+'/___'+str(i), path+'/'+str(i))
#     path = 'photos/__'+str(i)
#     listing = os.listdir(path)
#     for files in listing:
#       ## rename files
#       uniqid = files.split('_')[1].split('.')[0]
#       pid = files.split('_')[0]
#       os.rename(path+'/'+files, path+'/'+str(i)+uniqid+'_.jpg')
#       out.write(pid+" "+str(i)+uniqid+'\n')

#       try:
#         im = misc.imread(path+'/'+files)
#       except IOError, e:
#         print e.errno
#         print path+'/'+files 
#         break 
# 
#       except:
#         print 'error'
#         print path+'/'+files
#         break 
#       h, w, c = im.shape
#       im = im.reshape(w*h, c)
#       nonzerocount = np.count_nonzero(im - [228, 227, 223])
#       if nonzerocount == 7158:
#         lengray += 1
# #         os.remove(path+'/'+files) 
#       else:
#         out.write(pid+' '+uniqid+'\n')
#         #np.savetxt(out,im,fmt='%d')
  print lengray
  out.close()
gray()
