import numpy as np


text_file = open("plot.meandiff", "r")
lines = text_file.read().split(',')
arr = np.array(lines)
idxmax10 = arr.argsort()[-10:][::-1]
idxmin10 = arr.argsort()[:10][::-1]
print idxmax10
print idxmin10
print len(lines)
outfile = open("topbottommean","w")
outfile.write(str(idxmax10)+'\n'+str(idxmin10))
outfile.close()
text_file.close()

