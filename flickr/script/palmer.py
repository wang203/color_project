import sys
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import sem
def perrow(a):
  a[1:] = a[1:]/a[0]
  return a[1:]

def analyze_col(group):
  data = np.loadtxt(group+'.hadoop_output_palmer', usecols = range(172,205))
#   data = np.loadtxt(group+'.hadoop_output_palmer', usecols = range(140,172))
  print data[0,:]
  data = np.apply_along_axis(perrow, 1, data)
  print data[0,:]
  print data.shape
  np.savetxt(group+'.palmer32', np.sum(data, axis=0)/data.shape[0], fmt='%.6f')
  np.savetxt(group+'.stepalmer32', sem(data, axis=0), fmt = '%.6f')
  np.savetxt(group+'.stdpalmer32',np.std(data, axis=0), fmt='%.6f')

  group = 'streetview/streetview'
  data = np.loadtxt(group+'.hadoop_output_palmer', usecols = range(172,205))
#   data = np.loadtxt(group+'.hadoop_output_palmer', usecols = range(140,172))
  print data[0,:]
  data = np.apply_along_axis(perrow, 1, data)
  print data[0,:]
  print data.shape
  np.savetxt(group+'.palmer32', np.sum(data, axis=0)/data.shape[0], fmt='%.6f')
  np.savetxt(group+'.stepalmer32', sem(data, axis=0), fmt = '%.6f')
  np.savetxt(group+'.stdpalmer32',np.std(data, axis=0), fmt='%.6f')

def plotpalmer(group):

  legendlist = ['Saturated', 'Light', 'Muted', 'Dark']
  rgblist = [[[243.50, 59.62,81.10],[255, 157.20, 47.38],[255,241.39,47.9],[200.09,228.82,60.68],[0,199.54,130.02],[0,209,204.74],[33.63,168.87,238.48],[173.6,70.66,217.1]],[[255,159.63,162.80],[255,200.4,163.16],[255,242.56,153.25],[226.08,238.41,154.02],[150.28,225.10,184,69],[154.67,228.97,228.03],[160.54,207.32,250.63],[216.5,169.06,249.6]],[[199.76, 102.64, 106.78],[210.04,144.43,107.77],[215.21,184.58,101.56],[116.49,181.40,105.50],[100.56,174.11,137],[96.18,171.67,172.18],[104.15,151.08,191.68],[160.77,112.62,188.48]],[[139.84, 43.44, 55.34],[136.65,76.94,42.73],[142.74,115.87,40.07],[108.66,126.09,52.91],[29.19,111.64,79.27],[33.40,115.18,117.14],[41.17,96.65,136.82],[108.46,54.88,131.87]]]
  # rgblist1 = [x/255 for x in rgblist]
  print rgblist[0]
  rgbarray = np.zeros((4,8,3))
  for i in range(4):
    for j in range(8):
      for k in range(3):
        rgbarray[i][j][k] = rgblist[i][j][k]/255
  print rgbarray[0]
  markers = ['o','^','d','s']
  # 32 color list in RGB
  # error bar
  data1 = np.loadtxt(group+'.palmer32').reshape((8,4)).T 
  data2 =  np.loadtxt('streetview/streetview.palmer32').reshape((8,4)).T
  data = data1 - data2
  # print data 
  ste1 = np.loadtxt(group+'.stepalmer32').reshape((8,4)).T
  ste2 = np.loadtxt('streetview/streetview.stepalmer32').reshape((8,4)).T
  std1 = np.loadtxt(group+'.stdpalmer32').reshape((8,4)).T
  std2 = np.loadtxt('streetview/streetview.stdpalmer32').reshape((8,4)).T
  ste = np.sqrt(np.square(std1)/32+np.square(std2)/32)

  fig, ax = plt.subplots(1,3)
  for i in range(data1.shape[0]):
    ax[0].errorbar(range(data1.shape[1]), data1[i], c='k', yerr=ste1[i], zorder=1)
    ax[0].scatter(range(data1.shape[1]),data1[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)


  # x axis index
  labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
  ax[0].set_xticklabels(labels)  

  # legend
  ax[0].legend(frameon=False, loc=2)
  ax[0].set_xlabel('Hue')
  ax[0].set_ylabel('Fraction')
  ax[0].set_title('SDZoo Flickr')


  for i in range(data2.shape[0]):
    ax[1].errorbar(range(data2.shape[1]), data2[i], c='k', yerr=ste2[i], zorder=1)
    ax[1].scatter(range(data2.shape[1]),data2[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)


  # x axis index
  labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
  ax[1].set_xticklabels(labels)  

  # legend
  ax[1].legend(frameon=False, loc=2)
  ax[1].set_xlabel('Hue')
  ax[1].set_ylabel('Fraction')
  ax[1].set_title('SDZoo Streetview')


  for i in range(data.shape[0]):
    ax[2].errorbar(range(data.shape[1]), data[i], c='k', yerr=ste[i], zorder=1)
    ax[2].scatter(range(data.shape[1]),data[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)


  # x axis index
  labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
  ax[2].set_xticklabels(labels)  

  # legend
  ax[2].legend(frameon=False, loc=3)
  ax[2].set_xlabel('Hue')
  ax[2].set_ylabel('Fraction')
  ax[2].set_title('SDZoo Flickr - Streetview')



  fig, ax = plt.subplots(1,3)
  for i in range(data1.shape[0]):
    ax[0].errorbar(range(data1.shape[1]), data1[i], c='k', yerr=std1[i], zorder=1)
    ax[0].scatter(range(data1.shape[1]),data1[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)


  # x axis index
  labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
  ax[0].set_xticklabels(labels)  

  # legend
  ax[0].legend(frameon=False, loc=2)
  ax[0].set_xlabel('Hue')
  ax[0].set_ylabel('Fraction')
  ax[0].set_title('SDZoo Flickr')


  for i in range(data2.shape[0]):
    ax[1].errorbar(range(data2.shape[1]), data2[i], c='k', yerr=std2[i], zorder=1)
    ax[1].scatter(range(data2.shape[1]),data2[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)


  # x axis index
  labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
  ax[1].set_xticklabels(labels)  

  # legend
  ax[1].legend(frameon=False, loc=2)
  ax[1].set_xlabel('Hue')
  ax[1].set_ylabel('Fraction')
  ax[1].set_title('SDZoo Streetview')


  for i in range(data.shape[0]):
    ax[2].errorbar(range(data.shape[1]), data[i], c='k', yerr=ste[i], zorder=1)
    ax[2].scatter(range(data.shape[1]),data[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)


  # x axis index
  labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
  ax[2].set_xticklabels(labels)  

  # legend
  ax[2].legend(frameon=False, loc=3)
  ax[2].set_xlabel('Hue')
  ax[2].set_ylabel('Fraction')
  ax[2].set_title('SDZoo Flickr - Streetview')






#   fig, ax = plt.subplots()
#   for i in range(data1.shape[0]):
#     ax.errorbar(range(data1.shape[1]), data1[i], c='k', yerr=ste1[i], zorder=1)
#     ax.scatter(range(data1.shape[1]),data1[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)
# 
# 
#   # x axis index
#   labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
#   ax.set_xticklabels(labels)  
# 
#   # legend
#   ax.legend(frameon=False, loc=3)
#   plt.xlabel('Hue')
#   plt.ylabel('Fraction')
#   plt.title('Deathvally Flickr')
# 
# 
#   fig, ax = plt.subplots()
#   for i in range(data2.shape[0]):
#     ax.errorbar(range(data2.shape[1]), data2[i], c='k', yerr=ste2[i], zorder=1)
#     ax.scatter(range(data2.shape[1]),data2[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)
# 
# 
#   # x axis index
#   labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
#   ax.set_xticklabels(labels)  
# 
#   # legend
#   ax.legend(frameon=False, loc=3)
#   plt.xlabel('Hue')
#   plt.ylabel('Fraction')
#   plt.title('Deathvally Streetview')
# 
# 
#   fig, ax = plt.subplots()
#   for i in range(data.shape[0]):
#     ax.errorbar(range(data.shape[1]), data[i], c='k', yerr=ste[i], zorder=1)
#     ax.scatter(range(data.shape[1]),data[i], marker=markers[i], s=100, label=legendlist[i], c = rgbarray[i], edgecolors='none', zorder=2)
# 
# 
#   # x axis index
#   labels = ['', 'R', 'O', 'Y', 'H', 'G', 'C', 'B', 'P']
#   ax.set_xticklabels(labels)  
# 
#   # legend
#   ax.legend(frameon=False, loc=3)
#   plt.xlabel('Hue')
#   plt.ylabel('Fraction')
#   plt.title('Deathvally Flickr - Streetview')
  plt.show()
analyze_col(sys.argv[1])
plotpalmer(sys.argv[1])
