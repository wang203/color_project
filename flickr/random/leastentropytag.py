import numpy as np

def toptag(tagdir):
  idxlist = np.loadtxt(tagdir+'/tagidx', delimiter=' ', dtype='i8')
  taglist = np.loadtxt(tagdir+'/tagtext', delimiter=' ', dtype='|S20')
  entropylist = np.loadtxt(tagdir+'/tagentropy', delimiter=' ', dtype='f8')
  huecenter = np.array([21.996,56.412,89.46,114.192,159.48,196.884,259.164,316.296])
  huelist = np.zeros(9)
  for i in range(7):
    huelist[i+1] = .5*(huecenter[i]+huecenter[i+1])/5.54
  huelist[0] = 0
  huelist[8] = 65
  palmerhue = []
  toptags = []
  for i in range(8):
#     print i
#     print np.where((idxlist>huelist[i])&(idxlist<huelist[i+1]))
#     print idxlist[np.where((idxlist>huelist[i])&(idxlist<huelist[i+1]))]
#     print huelist

    palmerhue.append(np.where((idxlist>huelist[i])&(idxlist<huelist[i+1])))

#     print palmerhue[i]
    toptags.append(taglist[palmerhue[i]][np.argmin(entropylist[palmerhue[i]])])
#     print entropylist[palmerhue[i]]
#     print np.argmin(entropylist[palmerhue[i]])
#     print taglist[palmerhue[i]]
    print toptags[i]
  print '\n'
toptag('tag')
toptag('tagfemale')
toptag('tagmale')
