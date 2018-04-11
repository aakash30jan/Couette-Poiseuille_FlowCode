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
  plt.plot(case_sim[1:100,0],case_sim[1:100,1],'r-',label='Alpha= 1E-01')
  simDataFile=simDataDir2+'Case_'+caseChar+'_sim.dat'
  case_sim=np.loadtxt(simDataFile)
  plt.plot(case_sim[1:100,0],case_sim[1:100,1],'b-',label='Alpha= 1E-15')
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
#CASE(x) vs iterations(y) vs color(N)


#case_sim=open(simDataFile)
#s=linecache.getline(simDataFile,4) ##if file is huge after doing 'import linecache'
#lines=case_sim.readlines()
#print lines[2]  #Headers
#print lines[3]
#s=lines[3].replace('#','')
#heads=np.array([float(i) for i in s.split()])
##heads information #ALPHA,N,ITERATIONS,VW,UMAX,UAVG,UTAU1,UTAU2    


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
  simDataFile=simDataDir1+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])
  plt.plot(CASE,heads[2],'ro')
  simDataFile=simDataDir2+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])  
  plt.plot(CASE,heads[2],'bs')
  simDataFile=simDataDir3+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])
  plt.plot(CASE,heads[2],'gv')
  return;  





for CASE in range (1,19,1):
  plot(CASE)


ax = plt.subplot(111)
ax.plot(0,0,'ro',label='N= 10001')
ax.plot(0,0,'bs',label='N= 1001')
ax.plot(0,0,'gv',label='N= 101')
ax.plot([0,19],[10000,10000],'-k',label='Convergence\nCriteria')
box = ax.get_position()
ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])
ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
plt.xlabel('Case Number')  
plt.ylabel('Number of Iterations')
plt.title('Comparison of Convergence and Grid Points(N) ')
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.savefig('Compare_Convergence_N.eps')
plt.show()

####################
####################
###################
#CASE(x) vs iterations(y) vs color(ALPHA)


#case_sim=open(simDataFile)
#s=linecache.getline(simDataFile,4) ##if file is huge after doing 'import linecache'
#lines=case_sim.readlines()
#print lines[2]  #Headers
#print lines[3]
#s=lines[3].replace('#','')
#heads=np.array([float(i) for i in s.split()])
##heads information #ALPHA,N,ITERATIONS,VW,UMAX,UAVG,UTAU1,UTAU2    


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
  simDataDir3='../Simulated_Data/G6/'
  simDataFile=simDataDir1+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])
  plt.plot(CASE,heads[2],'ro')
  simDataFile=simDataDir2+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])  
  #plt.plot(CASE,heads[2],'bs')
  simDataFile=simDataDir3+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])  
  plt.plot(CASE,heads[2],'gv')  
  return;  





for CASE in range (1,19,1):
  plot(CASE)


ax = plt.subplot(111)
ax.plot(0,0,'ro',label='a= 1E-01')
ax.plot(0,0,'gv',label='a= 1E-06')
#ax.plot(0,0,'bs',label='a= 1E-15')
ax.plot([0,19],[10000,10000],'-k',label='Convergence\nCriteria')
box = ax.get_position()
ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])
ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
plt.xlabel('Case Number')  
plt.ylabel('Number of Iterations')
plt.title('Comparison of Convergence and Alpha(a)') #for fixed N=101
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.savefig('Compare_Convergence_Alpha.eps')
plt.show()

####################
####################

import numpy as np
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 11}) #Font 11


def plot(CASE):
  if (CASE<10):
     caseChar='0'+str(CASE)
  else:
     caseChar=str(CASE)
  
  simDataDir3='../Simulated_Data/G6/'
  simDataFile=simDataDir3+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])  
  #plt.plot(CASE,heads[4],'gv') #Umax  
  #plt.plot(CASE,heads[5],'gv') #Uavg 
  return heads;  



sim_Umax=np.zeros(18)
sim_Uavg=np.zeros(18)

for CASE in range (1,19,1):
  sim_Umax[CASE-1]=plot(CASE)[4] #Umax
  sim_Uavg[CASE-1]=plot(CASE)[5] #Uavg

##IMP##
#from El Telbany's paper first 15 values and 16-18 from Gilliot's thesis
exp_Umax=np.array([12.84,12.84,12.84,12.84,12.84,8.50,17.08,12.84,8.59,13.25,16.33,21.57,24.01,23.62,16.00,2.90,3.10,3.70])
exp_Uavg=np.array([6.42,7.28,8.06,8.14,8.81,0.71,14.55,11.38,7.70,12.40,15.10,20.11,22.40,21.90,14.55,2.50,2.50,2.55])


CASE=np.arange(1,19,1)
plt.plot(CASE,sim_Umax,'-ro',label='Umax Simulated')
plt.plot(CASE,exp_Umax,'-go',label='Umax Experimental')

plt.plot(CASE,sim_Uavg,'-bs',label='Uavg Simulated')
plt.plot(CASE,exp_Uavg,'-ys',label='Uavg Experimental')

plt.xlabel('Case Number')  
plt.ylabel('Velocity (m/s)')
plt.title('Comparison of Umax and Uavg') #for fixed N=101 and Alpha=1E-06 #G6
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.legend()
plt.savefig('Compare_Umax_Uavg.eps')
plt.show()



plt.plot(CASE,sim_Umax,'-ro',label='Simulated')
plt.plot(CASE,exp_Umax,'-go',label='Experimental')

plt.xlabel('Case Number')  
plt.ylabel('Velocity (m/s)')
plt.title('Comparison of Umax') #for fixed N=101 and Alpha=1E-06 #G6
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.legend()
plt.savefig('Compare_Umax.eps')
plt.show()



plt.plot(CASE,sim_Uavg,'-bs',label='Simulated')
plt.plot(CASE,exp_Uavg,'-ys',label='Experimental')


plt.xlabel('Case Number')  
plt.ylabel('Velocity (m/s)')
plt.title('Comparison of Uavg') #for fixed N=101 and Alpha=1E-06 #G6
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.legend()
plt.savefig('Compare_Uavg.eps')
plt.show()


####################
####################

import numpy as np
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 11}) #Font 11


def plot(CASE):
  if (CASE<10):
     caseChar='0'+str(CASE)
  else:
     caseChar=str(CASE)
  
  simDataDir3='../Simulated_Data/G6/'
  simDataFile=simDataDir3+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])  
  return heads;  



sim_Utau1=np.zeros(18)
sim_Utau2=np.zeros(18)

for CASE in range (1,19,1):
  sim_Utau1[CASE-1]=plot(CASE)[6] #Utau1
  sim_Utau2[CASE-1]=plot(CASE)[7] #Utau2

##IMP##
#from El Telbany's paper first 15 values and 16-18 from Gilliot's thesis
exp_Utau1=np.array([0.282,0.328,0.362,0.357,0.383,0.313,0.600,0.485,0.350,0.564,0.679,0.880,0.978,0.961,0.659,0.150,0.140,0.150])
exp_Utau2=np.array([0.282,0.233,0.1809,0.1669,0.1305,0.0615,0.0400,0.0229,0.0084,0.0300,0.1860,0.4142,0.518,0.670,0.659,0.09,0.04,0.05])

CASE=np.arange(1,19,1)
plt.plot(CASE,sim_Utau1,'-ro',label='Utau1 Simulated')
plt.plot(CASE,exp_Utau1,'-go',label='Utau1 Experimental')

plt.plot(CASE,sim_Utau2,'-bs',label='Utau2 Simulated')
plt.plot(CASE,exp_Utau2,'-ys',label='Utau2 Experimental')



plt.xlabel('Case Number')  
plt.ylabel('Parameter for Wall Stress (m/s)')
plt.title('Comparison of Utau1 and Utau2') #for fixed N=101 and Alpha=1E-06 #G6
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.legend()
plt.savefig('Compare_Utau1_Utau2.eps')
plt.show()


plt.plot(CASE,sim_Utau1,'-ro',label='Simulated')
plt.plot(CASE,exp_Utau1,'-go',label='Experimental')
plt.xlabel('Case Number')  
plt.ylabel('Parameter for High-Stress Wall (m/s)')
plt.title('Comparison of Utau1') #for fixed N=101 and Alpha=1E-06 #G6
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.legend()
plt.savefig('Compare_Utau1.eps')
plt.show()




plt.plot(CASE,sim_Utau2,'-bs',label='Simulated')
plt.plot(CASE,exp_Utau2,'-ys',label='Experimental')
plt.xlabel('Case Number')  
plt.ylabel('Parameter for Low-Stress Wall (m/s)')
plt.title('Comparison of Utau2') #for fixed N=101 and Alpha=1E-06 #G6
#plt.ylim(0,10050)
plt.xlim(0,19)
x_label=np.arange(0,20,1)
plt.xticks(x_label)
#plt.grid(axis='x')
plt.legend()
plt.savefig('Compare_Utau2.eps')
plt.show()






