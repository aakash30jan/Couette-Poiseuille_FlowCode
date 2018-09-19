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


        INTEGER		    ::I,K
	REAL(8)	            ::UMAX,UAVG,UTAU1,UTAU2
	REAL(8),ALLOCATABLE ::YHAD(:),YPAD(:),A(:),B(:)
	REAL(8),ALLOCATABLE ::U(:),U1(:),DYN_VIS_TUR(:),MIX_LEN(:),LEN_ZERO(:),TKIN_VISN(:),TKIN_VISS(:),LD(:),MD(:),UD(:),D(:)
	REAL(8)	::A1,A2,ERROR
        CHARACTER(len=100)::excommand



        !CASE SELECTION
        CHARACTER(len=15):: OUTPUTFILE
        REAL(8)          ::VW, H, DPDX
        INTEGER:: NUM_CASE
        NUM_CASE=1
        
        !managing filenames
         if (NUM_CASE < 10) then
                  write (OUTPUTFILE, "(A6,I1,A8)") "Case_0",NUM_CASE,"_sim.dat"
        else
                  write (OUTPUTFILE, "(A5,I2,A8)") "Case_",NUM_CASE,"_sim.dat"
        endif     
        CALL case_select(NUM_CASE,VW, H, DPDX)
        
        print *, "The case selected is CASE NUMBER ",NUM_CASE
        print *, "Here, the values of VW, H, DPDX are ",VW, H, DPDX, "respectively."
        print *, "The data generated will be saved to file ", OUTPUTFILE 


	ALLOCATE(YPAD(N),YHAD(N),U(N),U1(N),DYN_VIS_TUR(N),MIX_LEN(N),LEN_ZERO(N),A(N),B(N))
	ALLOCATE(TKIN_VISN(N),TKIN_VISS(N),LD(N),MD(N),UD(N),D(N))
	U=0.0d0	
	!TKIN_VIS is the turbulent kinematic viscosity
	!YPAD is the y coordinates of the mesh
	!YHAD(n) is the distance between YPAD(n) & YPAD(n-1)
	!UMAX= MAX VEL IN THE FLOW
	!UAVG= AVG VEL IN THE FLOW

	
	CALL sGrid_Generator(H,N,ALPHA,YPAD,YHAD)		!Stretched grid generator
        OPEN(12,file='GRID.dat')
        WRITE(12,*) '# GRID: NUMBER OF POINTS: ',N,' STRETCHING COEFFICIENT ALPHA: ',ALPHA
        WRITE(12,*) "#I        YPAD              YHAD"
	DO I=1,N
	   WRITE(12,11)I,YPAD(I),YHAD(I)
	ENDDO
	11 FORMAT(I3,2x,2(F16.8,2x))
	!DEALLOCATE(YPAD,YHAD)	
	CLOSE(12)
        
        print *, "Copying Generated GRID.dat to the directory Simulated_Data "
        call system('cp GRID.dat ../Simulated_Data/GRID.dat')
        print *, "Copied Successfully "
         
	
	
	CALL SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,DYN_VIS,KIN_VIS,RHO,CONV_CRIT,OUTPUTFILE) 	
	CLOSE(77)


        !Data Management
        print *, "Copying Generated simulation data to the directory Simulated_Data "
        excommand="cp "//OUTPUTFILE//" ../Simulated_Data/"//OUTPUTFILE
        !print *, trim(excommand)
        call system(trim(excommand))
        print *, "Copied Successfully "

        !Plotting
        excommand="python plot_case.py --file "//OUTPUTFILE
        if (PLOT=='Y') then
        print *, "Creating Plots"
        print *, trim(excommand)
        call system(trim(excommand))
        else
        print *, "Auto Plotting Disabled" 
 
        end if

        DEALLOCATE(YPAD,YHAD,U,U1,DYN_VIS_TUR,MIX_LEN,LEN_ZERO,A,B)
	DEALLOCATE(TKIN_VISN,TKIN_VISS,LD,MD,UD,D)



end program
