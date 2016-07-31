import urllib
import os

def download_and_rename(urlfile):
  if not os.path.isdir('photos'):
    os.makedirs('photos')
    i = 0
  for line in open(urlfile):
    linearr = line.split(' ')
    filename = str(i)+'_'+linearr[1]+'.jpg'
    i += 1
    url = linearr[2]
    subdir = filename[:2]
    if not os.path.isdir('photos/'+subdir):
      os.makedirs('photos/'+subdir)
    try:
      urllib.urlretrieve(url, 'photos/'+subdir+'/'+filename)
    except IOError, e:
      print e.errno
      print line
    except:
      print 'other error'
      print line
      raise

download_and_rename('streetview.uidpidurl')
