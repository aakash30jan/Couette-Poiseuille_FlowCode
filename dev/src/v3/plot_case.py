import numpy as np
import pylab as pl

c1_sim=np.loadtxt('Case_01_sim.dat')
c1_exp=np.loadtxt('Case_01_exp.dat')


pl.plot(c1_exp[:,1],c1_exp[:,0],'-ob',label='exp')
pl.plot(c1_sim[:,1],c1_sim[:,0],'-*r',label='sim')

pl.ylabel('y/2h')
pl.xlabel('U/Uq')
pl.grid()
pl.legend()
pl.show()

 

