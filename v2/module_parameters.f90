module module_parameters

REAL(8),PARAMETER :: ALPHA=0.0 !Alpha decides how to stretch the grid i.e. alpha=0 means homogenous grid
INTEGER,PARAMETER :: N= 11 	!NUMBER OF NODE POINTS IN FVM
REAL(8),PARAMETER ::RHO=1.225			!kg/m^3 
REAL(8),PARAMETER ::DYN_VIS=1.802*1E-5 		!kg/m.s Dynamic Viscosity of Air
REAL(8),PARAMETER ::KIN_VIS=1.4725*1E-5		!m^2/s Kinematic Viscosity of Air 
REAL(8),PARAMETER:: CONV_CRIT=1E-10             !convergence criteria ( max permissible error)


!case wise data
REAL(8),PARAMETER ::VW=12.84, H=66E-3,  PGF=0.0d0		!CASE 1

end module module_parameters
