import numpy as np
import pylab as pl

c1_sim=np.loadtxt('Case_1.dat')
c1_exp=np.loadtxt('Case_1_exp.dat')


pl.plot(c1_exp[:,1],c1_exp[:,0],'-ob',label='exp')
pl.plot(c1_sim[:,1],c1_sim[:,0],'-*r',label='sim')

pl.ylabel('y/2h')
pl.xlabel('U/Ub')
pl.legend()
pl.show()

 

