
import pandas as pd
from matplotlib import pyplot as plt
from sklearn.neighbors import KNeighborsRegressor

df = pd.read_csv('Case_ALL_EXP_training.csv')
X=df.loc[:,'YbyH':'dummy3']
Y=df.loc[:,'UbyVw']


#train model
knn=KNeighborsRegressor()
knn.fit(X,Y)








import numpy as np
#test model
case_test_data=case_test_data=np.loadtxt('Case_01_sim_test.dat')
case_test_VW=12.84 
case_test_H=66E-3
case_test_DPDX=0.00


case_test_d1=KIN_VIS=1.4725*1E-5     
case_test_d2=100
case_test_d3=0.0   


X_test=np.zeros((case_test_data.shape[0],7))
#X_test[0,:]=0.0,case_VW,case_H,case_DPDX,case_d1,case_d2,case_d3  

for i in range(0,case_test_data.shape[0]):
         X_test[i,:]=case_test_data[:,0][i],case_test_VW,case_test_H,case_test_DPDX,case_test_d1,case_test_d2,case_test_d3


Y_predicted=knn.predict(X_test)
#print Y_predicted


#plot and check

#plt.plot(case_sim[:,0],case_sim[:,1],'-g',label='training data simulated')
plt.plot(df.YbyH,df.UbyVw,'ks',label='training data experimental')
plt.plot(case_test_data[:,0],case_test_data[:,1],'-b',label='sim')
plt.plot(case_test_data[:,0],Y_predicted,'-*r',label='MLearned')
plt.legend()
plt.show()
