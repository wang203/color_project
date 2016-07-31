import numpy as np
import sys
from plotbin import plotbin

def topusergender(groupfile):
  print groupfile 
  topfemale = np.zeros(65, dtype='int_')
  topmale = np.zeros_like(topfemale)
  for i in xrange(65):
    uidgendervalue = np.loadtxt(groupfile, usecols=(0,3,i+7))
    factor = 10
    headnum = (uidgendervalue.shape[0])/factor
    uidgendervaluesort = np.sort(uidgendervalue.view('float, float, float'), axis=0, order=['f2'])[::-1][:headnum]
  
    headgender = [np.array(row.tolist())[0,1] for row in uidgendervaluesort]
    topfemale[i] = headgender.count(1.0)
    topmale[i] = headgender.count(2.0)
    #print topfemale[i]
    #print topmale[i] 
  # print topfemale
  # print topmale
  plotbin(topfemale, topmale)

# topusergender(sys.argv[1])


topfemale = np.array([2642,2600,2456,2402,2340,2272,2247,2244,2231,2230,2182,2192,2187,2198,2212,2263,2260,2470,2471,2561,2394,2387,2524,2592,2633,2680,2616,2521,2527,2484,2466,2473,2447,2436,2417,2422,2449,2416,2407,2362,2298,2260,2177,2146,2054,2020,1948,1878,1819,1782,1773,1858,2076,2222,2291,2461,2603,2674,2824,2813,2842,2842,2847,2782,2725], dtype='float')
topmale = np.array([3474,3516,3660,3714,3776,3844,3869,3872,3885,3886,3934,3924,3929,3918,3904,3853,3856,3646,3645,3555,3722,3729,3592,3524,3483,3436,3500,3595,3589,3632,3650,3643,3669,3680,3699,3694,3667,3700,3709,3754,3818,3856,3939,3970,4062,4096,4168,4238,4297,4334,4343,4258,4040,3894,3825,3655,3513,3442,3292,3303,3274,3274,3269,3334,3391], dtype='float')



plotbin(topfemale, topmale)


