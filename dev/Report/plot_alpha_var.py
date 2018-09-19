#import libraries
import numpy as np
import matplotlib.pyplot as plt

#ALPHA=np.arange(1,16)
plt.rcParams.update({'font.size': 11}) #Font 11

simDataDir='../Simulated_Data/DA/'

def plot(ALPHA):
  simDataFile=simDataDir+'Case_01_A'+str(ALPHA)+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[:,0],case_sim[:,1],'-',label='Alpha= 10E-'+str(ALPHA))
  return;  


expDataDir='../Experimental_Data/'
expDataFile=expDataDir+'Case_01_exp.dat'
case_exp=np.loadtxt(expDataFile)


for ALPHA in range (1,16,7):
  plot(ALPHA)

plt.plot(case_exp[:,0],case_exp[:,1],'ks',label='Experimental Data')
plt.xlabel('y/2h')  
plt.ylabel('U/Uq')
plt.title('Variation of Alpha (Grid Stretching)')
plt.legend() 
plt.savefig('VariationOfAlpha.eps')
plt.show()

##########
##########
#import libraries
import numpy as np
import matplotlib.pyplot as plt

plt.rcParams.update({'font.size': 11}) #Font 11


def plot(CASE):
  if (CASE<10):
     caseChar='0'+str(CASE)
  else:
     caseChar=str(CASE)
  
  simDataDir1='../Simulated_Data/G1/'
  simDataDir2='../Simulated_Data/G2/'
  simDataDir3='../Simulated_Data/G3/'
  expDataDir='../Experimental_Data/'
  simDataFile=simDataDir1+'Case_'+caseChar+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[:,0],case_sim[:,1],'r-',label='N= 10001')
  simDataFile=simDataDir2+'Case_'+caseChar+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[:,0],case_sim[:,1],'b-',label='N= 1001')
  simDataFile=simDataDir3+'Case_'+caseChar+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[:,0],case_sim[:,1],'g-',label='N= 101')
  expDataDir='../Experimental_Data/'
  expDataFile=expDataDir+'Case_'+caseChar+'_exp.dat'
  case_exp=np.loadtxt(expDataFile)
  plt.plot(case_exp[:,0],case_exp[:,1],'kx',label='Experimental Data')
  plt.xlabel('y/2h')  
  plt.ylabel('U/Uq')
  plt.title('Variation Grid Points for Case '+caseChar)
  plt.legend() 
  plt.savefig('Compare_N_Case'+caseChar+'.eps')
  plt.show()
  return;  





for CASE in range (1,19,1):
  plot(CASE)


#############
############

import numpy as np
import matplotlib.pyplot as plt

plt.rcParams.update({'font.size': 11}) #Font 11


def plot(CASE):
  if (CASE<10):
     caseChar='0'+str(CASE)
  else:
     caseChar=str(CASE)
  
  simDataDir1='../Simulated_Data/G4/'
  simDataDir2='../Simulated_Data/G5/'
  expDataDir='../Experimental_Data/'
  simDataFile=simDataDir1+'Case_'+caseChar+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[:,0],case_sim[:,1],'r-',label='Alpha= 1E-01')
  simDataFile=simDataDir2+'Case_'+caseChar+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[:,0],case_sim[:,1],'b-',label='Alpha= 1E-15')
  expDataDir='../Experimental_Data/'
  expDataFile=expDataDir+'Case_'+caseChar+'_exp.dat'
  case_exp=np.loadtxt(expDataFile)
  plt.plot(case_exp[:,0],case_exp[:,1],'kx',label='Experimental Data')
  plt.xlabel('y/2h')  
  plt.ylabel('U/Uq')
  plt.title('Variation Alpha for Case '+caseChar)
  plt.legend() 
  plt.savefig('Compare_Alpha_Case'+caseChar+'.eps')
  plt.show()
  return;  





for CASE in range (1,19,1):
  plot(CASE)


###################
#CASE(x) vs iterations(y) vs color(ALPHA and N)

