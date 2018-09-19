#v2 
#training data combination of full sim data and available exp data

#import libraries
import numpy as np
import matplotlib.pyplot as plt
#import optparse


##parsing command-line argument to plotting script
##USAGE: "python plot_case.py --file <case>"
#parser = optparse.OptionParser()
#parser.add_option('-f', '--file',
#    action="store", dest="query",
#    help="USAGE: python plot_case.py --file <case>", default="spam")

#options, args = parser.parse_args()
#case=options.query

case='Case_01_sim.dat'
case=case[0:8]
print 'Case to be plotted: ', case


#locations
expDataDir='../Experimental_Data/'
simDataDir='../Simulated_Data/'
plotSaveDir='../Generated_Plots/'
#extensions
expDataFile=expDataDir+case+'exp.dat'
simDataFile=simDataDir+case+'sim.dat'
plotFile=plotSaveDir+case+'compare.eps'


#data
case_exp=np.loadtxt(expDataFile)
case_sim=np.loadtxt(simDataFile)





#for i in range(0,case_sim.shape[0]-1):
#    if (case_sim[:,0][i]<case_exp[0,0]):
#        print i #simulation out of experiment index --BELOW
#
#for i in range(0,case_sim.shape[0]-1):
#    if (case_sim[:,0][i]>case_exp[case_exp.shape[0]-1,0]):
#        print i  #simulation out of experiment index --ABOVE
     


#simulation within experiment index
#indexes=np.zeros(case_sim.shape[0])
#for i in range(0,case_sim.shape[0]-1):
#   if (case_exp[0,0]<case_sim[:,0][i]<case_exp[case_exp.shape[0]-1,0]):   
#        indexes[i]=i 
        

#indexes=np.trim_zeros(indexes)
#case_sim_fit=np.zeros((indexes.shape[0],2))
#case_sim_fit[:,0]=case_sim[int(np.min(indexes)):int(max(indexes))+1,0]
#case_sim_fit[:,1]=case_sim[int(np.min(indexes)):int(max(indexes))+1,1]



#plt.plot(case_sim_fit[:,0],case_sim_fit[:,1],'*r',label='sim')
#plt.plot(case_exp[:,0],case_exp[:,1],'bo',label='exp')
#plt.legend()
#plt.show()

#do statistcal comparison between exp and sim #REMOVE IF TOO FAR FROM EXPERIMENT
##from scipy.stats import pearsonr
##pearsonr(sim,exp) #https://en.wikipedia.org/wiki/Pearson_correlation_coefficient
##import scipy.stats as stats
##stats.kstest(sim,exp)
##read about https://en.wikipedia.org/wiki/Distance_correlation#Alternative_formulation:_Brownian_covariance
##read about https://en.wikipedia.org/wiki/Kolmogorov%E2%80%93Smirnov_test


#appending simulation and experimental and deleting duplicates
case_training_data=np.zeros(((case_sim.shape[0]+case_exp.shape[0]),2))
case_training_data[:,0]=np.unique(np.append(case_sim[:,0],case_exp[:,0]))
case_training_data[:,1]=np.unique(np.append(case_sim[:,1],case_exp[:,1]))
#plt.plot(case_training_data[:,0],case_training_data[:,1],'r*')

case_training_file='Case_01_training.csv'
#YbyH,VW,H,DPDX,dummy1,dummy2,dummy3,UbyVw  #FILE FORMAT

#temp_definitions
case_VW,case_H,case_DPDX,case_d1,case_d2,case_d3=[12.84,66E-3,0.00,0.00,0.00,0.00]
case_training_file='Case_01_training.csv'

fd = open(case_training_file,'a')
#header
# YbyH,VW,H,DPDX,dummy1,dummy2,dummy3,UbyVw
#main data
for i in range(0,case_training_data.shape[0]-1):
        #s="case_training_data[:,0][i],case_VW,case_H,case_DPDX,case_d1,case_d2,case_d3,case_training_data[:,1][i]"
        writeRow=str(case_training_data[:,0][i])+","+str(case_VW)+","+str(case_H)+","+str(case_DPDX)+","+str(case_d1)+","+str(case_d2)+","+str(case_d3)+","+str(case_training_data[:,1][i])+"\n"
        fd.write(writeRow)
      


fd.close()



#train model
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.neighbors import KNeighborsRegressor

df = pd.read_csv('Case_01_training.csv')
X=df.loc[:,'YbyH':'dummy3']
Y=df.loc[:,'UbyVw']

knn=KNeighborsRegressor()
knn.fit(X,Y)


#test model
case_test_data=case_test_data=np.loadtxt('Case_01_sim_test.dat')

X_test=np.zeros((case_test_data.shape[0],7))
#X_test[0,:]=0.0,case_VW,case_H,case_DPDX,case_d1,case_d2,case_d3  

for i in range(0,case_test_data.shape[0]):
         X_test[i,:]=case_test_data[:,0][i],case_VW,case_H,case_DPDX,case_d1,case_d2,case_d3


Y_predicted=knn.predict(X_test)
#print Y_predicted


plt.plot(case_test_data[:,0],case_test_data[:,1],'-b',label='sim')
plt.plot(case_sim[:,0],case_sim[:,1],'-g',label='training data simulated')
plt.plot(case_exp[:,0],case_exp[:,1],'-sk',label='training data experimental')
plt.plot(case_test_data[:,0],Y_predicted,'-*r',label='MLearned')
plt.legend()
plt.show()
