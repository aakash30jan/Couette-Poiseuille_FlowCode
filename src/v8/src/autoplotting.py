#Autoplotting script for the data generated while executing the cpFlow code
#import libraries
import numpy as np
import matplotlib.pyplot as plt
import optparse


#parsing case file as a command-line argument
parser = optparse.OptionParser()
parser.add_option('-f', '--file',
    action="store", dest="query",
    help="USAGE: python plot_case.py --file <case>", default="spam")

options, args = parser.parse_args()
case=options.query
case=case[0:8]
print ' Case to be plotted: ', case


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


print ' Plotting Case'

plt.rcParams.update({'font.size': 11}) #Font size 11 as instructed by Dr. Laval

caseint=int(case[5:7])
if (caseint>15):
        plt.plot(case_sim[1:,0],case_sim[1:,1],'-k',label='Simulated')        
else:
        plt.plot(case_sim[:,0],case_sim[:,1],'-k',label='Simulated')

plt.plot(case_exp[:,0],case_exp[:,1],'ro',label='Experimental')

plt.xlabel('y/2h')  
plt.ylabel('U/Uq')  
plt.title('Comparison for '+case[0:4]+' '+case[5:7])
#plt.grid()
plt.legend()
print ' Saving Plots'
plt.savefig(plotFile)
plt.show()

#end of file version 7
