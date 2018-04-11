In [25]: plt.plot(CASE,sim_Umax,'-ro',label='Umax Simulated')
Out[25]: [<matplotlib.lines.Line2D at 0x7f1b145eaa10>]

In [26]: plt.plot(CASE,sim_Uavg,'-bo',label='Umax Experimental')
Out[26]: [<matplotlib.lines.Line2D at 0x7f1b1460e910>]

In [27]: plt.plot(CASE,exp_Umax,'-gs',label='Uavg Experimental')
Out[27]: [<matplotlib.lines.Line2D at 0x7f1b145a3bd0>]

In [28]: plt.plot(CASE,exp_Uavg,'-ys',label='Uavg Simulated')
Out[28]: [<matplotlib.lines.Line2D at 0x7f1b145abf90>]

In [29]: 

In [29]:     ...: plt.xlabel('Case Number')  
    ...:     ...: plt.ylabel('Velocity (m/s)')
    ...:     ...: plt.title('Comparison of Umax and Uavg') #for fixed N=101 and Alpha=1E-06 #G6
    ...:     ...: #plt.ylim(0,10050)
    ...:     ...: plt.xlim(0,19)
    ...:     ...: x_label=np.arange(0,20,1)
    ...:     ...: plt.xticks(x_label)
    ...:     ...: #plt.grid(axis='x')
    ...:     ...: plt.legend()
    ...: 
Out[29]: <matplotlib.legend.Legend at 0x7f1b14c9ca50>

In [30]: plt.savefig("Compare_Umax-Uavg.eps")

In [31]: plt.show()





####################################################################



