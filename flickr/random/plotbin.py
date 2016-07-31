import numpy as np
import matplotlib.pyplot as plt

def plotbin(female, male):
  femalenorm = female/np.linalg.norm(female,1)
  malenorm = male/np.linalg.norm(male,1)
  
  print female
  print femalenorm
  
  diffnorm = femalenorm - malenorm
  
  plt.plot(femalenorm, label='female')
  plt.plot(malenorm, label='male')
  plt.plot(diffnorm, label='female-male')
  plt.xlabel('65 bins of Hue distribution')
  plt.ylabel('percentage of users')
  plt.title('Distinctive users of each bin')
  
  
  plt.legend(loc=1)
  plt.show()



# female = np.loadtxt('tag/allpeople.femalecountuidperbin')
# male = np.loadtxt('tag/allpeople.malecountuidperbin')
# plotbin(female, male)
