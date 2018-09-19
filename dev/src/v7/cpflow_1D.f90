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
use module_triSolve



IMPLICIT NONE  


        INTEGER		    ::I,K
	REAL(8)	            ::UMAX,UAVG,UTAU1,UTAU2
	REAL(8),ALLOCATABLE ::YHAD(:),YPAD(:),A(:),B(:)
	REAL(8),ALLOCATABLE ::U(:),U1(:),MIX_LEN(:),LEN_ZERO(:),TKIN_VIS(:),TKIN_VISN(:),TKIN_VISS(:),LD(:),MD(:),UD(:),D(:)
	REAL(8)	::A1,A2,ERROR
        CHARACTER(len=100)::excommand



        !CASE SELECTION
        CHARACTER(len=15):: OUTPUTFILE
        !CHARACTER(len=20):: OUTPUTFILE  !DELETE LATER
        
        REAL(8)          ::VW, H, DPDX
        INTEGER:: NUM_CASE
        
     
  
        !DO NUM_CASE=1,2
        NUM_CASE=15
              
        PRINT*, "####### 1D Couette_Poiseuille-FlowCode ###"       
        
        !managing filenames
        if (NUM_CASE < 10) then
                  write (OUTPUTFILE, "(A6,I1,A8)") "Case_0",NUM_CASE,"_sim.dat"
                  !write (CHARA,*) ALPHA
                  !write (OUTPUTFILE, "(A6,I1,A1)") "Case_0",NUM_CASE,"_"
                  !write (OUTPUTFILE,*) OUTPUTFILE//CHARA//"_sim.dat"
        else
                  write (OUTPUTFILE, "(A5,I2,A8)") "Case_",NUM_CASE,"_sim.dat"
        endif     
        CALL case_select(NUM_CASE,VW, H, DPDX)
        
        print *, "The case selected is CASE NUMBER ",NUM_CASE
        print *, "Here, the values of VW, H, DPDX are ",VW, H, DPDX, "respectively."
        print *, "The data generated will be saved to file ", OUTPUTFILE 


	ALLOCATE(YPAD(N),YHAD(N),U(N),U1(N),MIX_LEN(N),LEN_ZERO(N),A(N),B(N))
	ALLOCATE(TKIN_VIS(N),TKIN_VISN(N),TKIN_VISS(N),LD(N),MD(N),UD(N),D(N))
	U=0.0d0	
	!TKIN_VIS is the turbulent kinematic viscosity
	!YPAD is the y coordinates of the mesh
	!YHAD(n) is the distance between YPAD(n) & YPAD(n-1)
	!UMAX= MAX VEL IN THE FLOW
	!UAVG= AVG VEL IN THE FLOW

	
	CALL sGrid_Generator(H,N,ALPHA,YPAD,YHAD)		!Stretched grid generator
        
	
	
	CALL SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,MAX_ITER,OUTPUTFILE,NUM_CASE) 	
!CALL SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,OUTPUTFILE,NUM_CASE) 	



        !Data Management
        print *, "Copying Generated GRID.dat to the directory Simulated_Data  . . . . "
        call system('cp GRID.dat ../Simulated_Data/GRID.dat')
        print *, "Copied Successfully "
 
        print *, "Copying Generated simulation data to the directory Simulated_Data . . . ."
        excommand="cp "//OUTPUTFILE//" ../Simulated_Data/"//OUTPUTFILE
        !print *, trim(excommand)
        call system(trim(excommand))
        print *, "Copied Successfully "

        !Plotting
        excommand="python plot_case.py --file "//OUTPUTFILE
        if (PLOT=='Y') then
        print *, "Creating Plots . . . ."
        !print *, trim(excommand)
        call system(trim(excommand))
        else
        print *, "Auto Plotting Disabled" 
        end if

        DEALLOCATE(YPAD,YHAD,U,U1,MIX_LEN,LEN_ZERO,A,B)
	DEALLOCATE(TKIN_VIS,TKIN_VISN,TKIN_VISS,LD,MD,UD,D)

       !END DO

print*, "Cleaning Execution Directory"
call system("rm *.dat")

end program
