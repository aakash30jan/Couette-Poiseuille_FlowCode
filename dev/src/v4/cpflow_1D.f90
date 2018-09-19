!##############################################
!##########Compile Instructions###############
!"chmod +x config.sh"
!"./config.sh"
!
!###########Execution######################
!"./cpflow_1D.exe"
!
!##############################################




program cpflow1D

use module_parameters
use module_grid
use module_solver



IMPLICIT NONE  

!next 4 lines for individual module_grid
!REAL(8)	            ::ALPHA
!REAL(8)             ::H
!REAL(8),ALLOCATABLE ::YHAD(:),YPAD(:)
!INTEGER		    ::N,I

INTEGER		    	::I,K
	REAL(8)	            ::UMAX,UAVG,UTAU1,UTAU2
	REAL(8),ALLOCATABLE ::YHAD(:),YPAD(:),A(:),B(:)
	REAL(8),ALLOCATABLE ::U(:),U1(:),DYN_VIS_TUR(:),MIX_LEN(:),LEN_ZERO(:),TKIN_VISN(:),TKIN_VISS(:),LD(:),MD(:),UD(:),D(:)
	REAL(8)	::A1,A2,ERROR
CHARACTER(len=100)::excommand



	ALLOCATE(YPAD(N),YHAD(N),U(N),U1(N),DYN_VIS_TUR(N),MIX_LEN(N),LEN_ZERO(N),A(N),B(N))

	ALLOCATE(TKIN_VISN(N),TKIN_VISS(N),LD(N),MD(N),UD(N),D(N))
	U=0.0d0	
	!TKIN_VIS is the turbulent kinematic viscosity
	!YPAD is the y coordinates of the mesh
	!YHAD(n) is the distance between YPAD(n) & YPAD(n-1)
	!UMAX= MAX VEL IN THE FLOW
	!UAVG= AVG VEL IN THE FLOW

	
	CALL sGrid_Generator(H,N,ALPHA,YPAD,YHAD)		!Stretched grid generator

	!DO I=1,N
	 !  WRITE(*,11)I,YPAD(I),YHAD(I)
	!ENDDO
	!DEALLOCATE(YPAD,YHAD)	

	!11 FORMAT(I3,2x,2(F16.8,2x))	
	
	CALL SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,DYN_VIS,KIN_VIS,RHO,CONV_CRIT,OUTPUTFILE) 	
	
	DEALLOCATE(YPAD,YHAD,U,U1,DYN_VIS_TUR,MIX_LEN,LEN_ZERO,A,B)

	DEALLOCATE(TKIN_VISN,TKIN_VISS,LD,MD,UD,D)

	CLOSE(77)



print *, "copying generated simulation data to the directory Simulated_Data "
excommand="cp "//OUTPUTFILE//" ../Simulated_Data/"//OUTPUTFILE
print *, trim(excommand)
call system(trim(excommand))
print *, "copied successfully "


excommand="python plot_case.py --file "//OUTPUTFILE
if (PLOT=='Y') then
        print *, "Creating Plots"
        print *, trim(excommand)
        call system(trim(excommand))
else
        print *, "Auto Plotting Disabled" 
 
end if



!next 10 lines for individual module_grid
!ALLOCATE(YPAD(N),YHAD(N))
!CALL sGrid_Generator(H,N,ALPHA,YPAD,YHAD)
!
!DO I=1,N
!   WRITE(*,11)I,YPAD(I),YHAD(I)
!ENDDO
!
!DEALLOCATE(YPAD,YHAD)	
!
!11 FORMAT(I3,2x,2(F10.4,2x))	

end program
