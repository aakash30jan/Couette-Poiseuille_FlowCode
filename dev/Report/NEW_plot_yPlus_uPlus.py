###################
##################
#H*UTAU1/KIN_VIS,VW/UTAU1		#first line for plotting y+ against u+
#(YPAD(I)*UTAU1)/KIN_VIS,U(I)/UTAU2	#all lines for plotting y+ against u+

import numpy as np
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 11}) #Font 11


def bc_selector(CASE):    
        if (CASE==1):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=0.000		#CASE 1
	elif (CASE==2):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-0.808 	        #CASE 2
	elif (CASE==3):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-1.486		#CASE 3
	elif (CASE==4):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-1.510		#CASE 4
	elif (CASE==5):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-1.960		#CASE 5
	elif (CASE==6):
                case_VW=8.59   
                case_H=66E-3    
                case_DPDX=-1.430		#CASE 6
	elif (CASE==7):
                case_VW=17.08   
                case_H=101E-3    
                case_DPDX=-3.548		#CASE 7	
	elif (CASE==8):
                case_VW=12.84   
                case_H=101E-3    
                case_DPDX=-2.323		#CASE 8
	elif (CASE==9):
                case_VW=8.59   
                case_H=101E-3    
                case_DPDX=-1.212		#CASE 9
	elif (CASE==10):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-4.830		#CASE 10
	elif (CASE==11):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-7.500		#CASE 11
	elif (CASE==12):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-14.30		#CASE 12
	elif (CASE==13):
                case_VW=12.84   
                case_H=66E-3    
                case_DPDX=-18.50		#CASE 13
	elif (CASE==14):
                case_VW=8.59   
                case_H=66E-3    
                case_DPDX=-20.80		#CASE 14
	elif (CASE==15):
                case_VW=0.000   
                case_H=66E-3    
                case_DPDX=-13.14		#CASE 15
	elif (CASE==16):
                case_VW=1.8
                case_H=30E-3    
                case_DPDX=-0.48		#CASE 16
	elif (CASE==17):
                case_VW=3.09   
                case_H=30E-3    
                case_DPDX=-0.60		#CASE 17
	elif (CASE==18):
                case_VW=3.75   
                case_H=30E-3    
                case_DPDX=-0.66		#CASE 18
        else:
                print  "Invalid Case Selected. Exiting."
                
        #print "BC for this case: VW=",case_VW," H=",case_H," DPDX=",case_DPDX
        return case_VW,case_H,case_DPDX;
        



def plot(CASE,case_VW,case_H):
  KIN_VIS=1.4725*1E-5
  exp_Utau1=np.array([0.282,0.328,0.362,0.357,0.383,0.313,0.600,0.485,0.350,0.564,0.679,0.880,0.978,0.961,0.659,0.150,0.140,0.150])
  exp_Utau2=np.array([0.282,0.233,0.1809,0.1669,0.1305,0.0615,0.0400,0.0229,0.0084,0.0300,0.1860,0.4142,0.518,0.670,0.659,0.09,0.04,0.05])
  simstyles=['-r','-','-','-g','-','-','-b','-','-','-y','-','-','-m','-','-','-k','-','-']
  expstyles=['*r','*','*','*g','*','*','*b','*','*','*y','*','*','*m','*','*','*k','*','*',]
  if (CASE<10):
     caseChar='0'+str(CASE)
  else:
     caseChar=str(CASE)
  
  simDataDir1='../Simulated_Data/G6/'
  expDataDir='../Experimental_Data/'
  simDataFile=simDataDir1+'Case_'+caseChar+'_sim.dat'
  case_sim=open(simDataFile)
  lines=case_sim.readlines()
  s=lines[3].replace('#','')
  heads=np.array([float(i) for i in s.split()])
  Utau1=heads[6]
  Utau2=heads[7]  
  case_sim=np.loadtxt(simDataFile)
  #case_sim[0]=(case_H*Utau1)/KIN_VIS,case_VW/Utau1   #FIRST LINE PROBLEM
  yPlus_sim=(case_sim[:,0]*Utau1)/KIN_VIS
  uPlus_sim=case_sim[:,1]/Utau2
  plt.loglog(yPlus_sim,uPlus_sim,simstyles[CASE-1],label='Case Sim '+caseChar)
  #expDataFile=expDataDir+'Case_'+caseChar+'_exp.dat'
  #case_exp=np.loadtxt(expDataFile)
  #plt.loglog((case_exp[:,0]*exp_Utau1[CASE-1])/KIN_VIS,case_exp[:,1]/exp_Utau2[CASE-1],expstyles[CASE-1],label='Case Exp '+caseChar)
  return;  


for i in range(16,19):
        CASE=i
        case_VW,case_H,case_DPDX=bc_selector(CASE)
        plot(CASE,case_VW,case_H) 


plt.xlabel('y+')  
plt.ylabel('u+')
plt.title('y+ vs u+')
plt.legend() 
plt.savefig('./yPlus_uPlus/Compare_yPlus_uPlus_p3_16-18.eps')
plt.show()

