module module_parameters
 !CHARACTER(len=5),PARAMETER  :: CHARA="1E-01"  !DELETE 
           REAL(8),PARAMETER :: ALPHA=1E-04 !Alpha decides how to stretch the grid i.e. alpha=0 means homogenous grid  !It can be set to minimum 1E-15
        INTEGER,PARAMETER :: N= 101 	!NUMBER OF NODE POINTS IN FVM
        REAL(8),PARAMETER :: KIN_VIS=1.4725*1E-5		!m^2/s Kinematic Viscosity of Air 
        REAL(8),PARAMETER :: CONV_CRIT=1E-10           !convergence criteria ( max permissible error)
        INTEGER,PARAMETER :: MAX_ITER=10000       !Maximum iterations if convergence is not reached
        CHARACTER(len=1)  :: PLOT="Y"               !automatic plotting set Yes(Y) or No(N) 

contains
subroutine case_select(NUM_CASE,VW, H, DPDX)
implicit none
  REAL(8),INTENT(OUT)         ::VW, H, DPDX
  INTEGER,INTENT(IN)          :: NUM_CASE
  
  if (NUM_CASE==1) then
  VW=12.84;        H=66E-3;         DPDX=0.0d0		!CASE 1
	elseif (NUM_CASE==2) then
	VW=12.84;	 H=66E-3;	  DPDX=-0.808 	        !CASE 2
	elseif (NUM_CASE==3) then
	VW=12.84;	 H=66E-3;	  DPDX=-1.486		!CASE 3
	elseif (NUM_CASE==4) then
	VW=12.84;	 H=66E-3;	  DPDX=-1.510		!CASE 4
	elseif (NUM_CASE==5) then
	VW=12.84;	 H=66E-3;	  DPDX=-1.960		!CASE 5
	elseif (NUM_CASE==6) then
	VW=8.59;	 H=66E-3;	  DPDX=-1.430		!CASE 6
	elseif (NUM_CASE==7) then
	VW=17.08;	 H=101E-3;	  DPDX=-3.548		!CASE 7	
	elseif (NUM_CASE==8) then
	VW=12.84;	 H=101E-3;	  DPDX=-2.323		!CASE 8
	elseif (NUM_CASE==9) then
	VW=8.59;	 H=101E-3;	  DPDX=-1.212		!CASE 9
	elseif (NUM_CASE==10) then
	VW=12.84;	 H=66E-3;	  DPDX=-4.830		!CASE 10
	elseif (NUM_CASE==11) then
	VW=12.84;	 H=66E-3;	  DPDX=-7.500		!CASE 11
	elseif (NUM_CASE==12) then
	VW=12.84;	 H=66E-3;	  DPDX=-14.30		!CASE 12
	elseif (NUM_CASE==13) then
	VW=12.84;	 H=66E-3;	  DPDX=-18.50		!CASE 13
	elseif (NUM_CASE==14) then
	VW=8.59;	 H=66E-3;	  DPDX=-20.80		!CASE 14
	elseif (NUM_CASE==15) then
	VW=0.0D0;	 H=66E-3;	  DPDX=-13.14		!CASE 15
	elseif (NUM_CASE==16) then
	VW=1.8; 	 H=30E-3;	  DPDX=-0.48		!CASE 16
	elseif (NUM_CASE==17) then
	VW=3.09;	 H=30E-3;	  DPDX=-0.60		!CASE 17
	elseif (NUM_CASE==18) then
	VW=3.75;	 H=30E-3;	  DPDX=-0.66		!CASE 18
        else
        PRINT *, "Invalid Case Selected. Exiting."
        end if

end subroutine case_select
end module module_parameters
