!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! PROGRAM TO COMPUTE FLOW PARAMETERS FOR COUETTE-POISEUILLE FLOW !!
!! Written by: Aakash PATIL, IMP Turbulence                       !!
!! Mentor:  Dr. Jean-Philip LAVAL                                 !! 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program cpflow1D

use module_parameters
use module_grid
use module_solver
use module_triSolve

implicit none  

        INTEGER		    ::I,K
	REAL(8)	            ::UMAX,UAVG,UTAU1,UTAU2
	REAL(8),ALLOCATABLE ::YHAD(:),YPAD(:),A(:),B(:)
	REAL(8),ALLOCATABLE ::U(:),U1(:),MIX_LEN(:),LEN_ZERO(:),TKIN_VIS(:),TKIN_VISN(:),TKIN_VISS(:),LD(:),MD(:),UD(:),D(:)
	REAL(8)	::A1,A2,ERROR
        CHARACTER(len=100)::excommand
        CHARACTER(len=15):: OUTPUTFILE
        REAL(8)          ::VW, H, DPDX
        INTEGER:: NUM_CASE
        
        print*, "########################################"
        print*, "###### Couette_Poiseuille-FlowCode #####"         
        print*, "########################################"
           
        !CASE SELECTION
        print*,"Please Enter a Case Number(from 1 to 18):"
        read*, NUM_CASE
        !DO NUM_CASE=1,19 !start of allCaseLoop
        !NUM_CASE=15     !hard assign
        
        !Checking Case Number and Managing Filenames
        if (NUM_CASE < 10) then
                  write (OUTPUTFILE, "(A6,I1,A8)") "Case_0",NUM_CASE,"_sim.dat"
        elseif (NUM_CASE<19) then
                  write (OUTPUTFILE, "(A5,I2,A8)") "Case_",NUM_CASE,"_sim.dat"
        else
                  print *, "Invalid Case Number. Exiting"
                  STOP         
        endif
        
        !Read the Parameters
        print *, "### Fetching Values from the Parameters File ###"     
        CALL case_select(NUM_CASE,VW, H, DPDX)
        print *, "The selected CASE NUMBER is ",NUM_CASE
        print *, "Here, the values of VW, H, DPDX are ",VW, H, DPDX, "respectively."
        print *, "The data generated will be saved to file ", OUTPUTFILE 


	ALLOCATE(YPAD(N),YHAD(N),U(N),U1(N),MIX_LEN(N),LEN_ZERO(N),A(N),B(N))
	ALLOCATE(TKIN_VIS(N),TKIN_VISN(N),TKIN_VISS(N),LD(N),MD(N),UD(N),D(N))
	U=0.0d0

	!Call Main Functions
	print *, "### Generating Grid ###"
	CALL sGrid_Generator(H,N,ALPHA,YPAD,YHAD)
	print *, "### Solving for Flow Parameters ###"
        CALL SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,MAX_ITER,OUTPUTFILE,NUM_CASE) 	
 	
        !Data Management
        print *, "### Organizing Data Files ###"
        !print *, "Copying Generated GRID.dat to the directory '../Simulated_Data'"
        !call system('cp GRID.dat ../Simulated_Data/GRID.dat')
        print *, "Copied Successfully "
        print *, "Copying Generated simulation data to the directory '../Simulated_Data'"
        excommand="cp "//OUTPUTFILE//" ../Simulated_Data/"//OUTPUTFILE
        print *, trim(excommand)
        call system(trim(excommand))
        print *, "Copied Successfully "

        !Automatic Plotting
        print *, "### Plotting ###"
        excommand="python autoplotting.py --file "//OUTPUTFILE
        if (PLOT=='Y') then
                print *, "Creating Plots"
                print *, trim(excommand)
                call system(trim(excommand))
        else
                print *, "Auto Plotting Disabled" 
        end if

        DEALLOCATE(YPAD,YHAD,U,U1,MIX_LEN,LEN_ZERO,A,B)
	DEALLOCATE(TKIN_VIS,TKIN_VISN,TKIN_VISS,LD,MD,UD,D)
	

        print*, "Cleaning Execution Directory"
        call system("rm *.dat")

        !END DO
end program
