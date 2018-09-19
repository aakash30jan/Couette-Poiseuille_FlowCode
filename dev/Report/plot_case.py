#import libraries
import numpy as np
import matplotlib.pyplot as plt
import optparse


#parsing command-line argument to plotting script
#USAGE: "python plot_case.py --file <case>"
parser = optparse.OptionParser()
parser.add_option('-f', '--file',
    action="store", dest="query",
    help="USAGE: python plot_case.py --file <case>", default="spam")

options, args = parser.parse_args()
case=options.query
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


###########old###################
#pl.plot(c1_exp[:,1],c1_exp[:,0],'-ob',label='exp')
#pl.plot(c1_sim[:,1],c1_sim[:,0],'-*r',label='sim')
#pl.ylabel('y/2h')
#pl.xlabel('U/Uq')
#pl.grid()
#pl.legend()
#pl.show()
################################

print 'Plotting case . . .'

plt.rcParams.update({'font.size': 11}) #Font 11

 

plt.plot(case_sim[:,0],case_sim[:,1],'-*k',label='Simulated')
plt.plot(case_exp[:,0],case_exp[:,1],'-or',label='Experimental')

plt.xlabel('y/2h')  
plt.ylabel('U/Uq')  
plt.title('Comparison for '+case[0:4]+' '+case[5:7])
plt.grid()
plt.legend()

print 'Saving Plots . . .'
plt.savefig(plotFile)
plt.show()



#do statistcal comparison between exp and sim 

