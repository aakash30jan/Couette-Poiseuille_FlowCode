!======================================================================================================
!> Program: cpFlow                                                                                   !!
!> Details: PROGRAM TO COMPUTE FLOW PARAMETERS FOR COUETTE-POISEUILLE FLOW USING MIXING LENGTH MODEL !!
!> @Author: Aakash PATIL, IMP Turbulence                                                             !!
!> Mentor:  Dr. Jean-Philip LAVAL                                                                    !! 
!======================================================================================================
program cpflow

use module_parameters
use module_grid
use module_triSolve
use module_solver
implicit none  
        INTEGER		    :: NUM_CASE         !Case number under consideration 
	REAL(8),ALLOCATABLE :: YHAD(:),YPAD(:)  !Grid parameters 
        CHARACTER(len=15)   :: OUTPUTFILE       !Output filename
        REAL(8)             :: VW, H, DPDX      !Input conditions for a given case number
        !VW is the Velocity of Wall, H is the Height of Channel, and DPDX is Pressure Gradient
        CHARACTER(len=100)  :: EXCOMMAND        !String for writing command line arguments
        
        print*, "########################################"
        print*, "###### Couette_Poiseuille-FlowCode #####"         
        print*, "########################################"
           
        !CASE SELECTION
        print*,"Please Enter a Case Number(from 1 to 18): "
        read*, NUM_CASE
        !do NUM_CASE=1,18 !end of RunAllCasesLoop
        !NUM_CASE=15      !single case
        
        !Checking Case Number and Managing Filenames
        if (NUM_CASE<1 .OR. NUM_CASE>18) then
                  print *, "Invalid Case Number. Exiting"
                  STOP   
        else if (NUM_CASE < 10) then
                  write (OUTPUTFILE, "(A6,I1,A8)") "Case_0",NUM_CASE,"_sim.dat"
        else if (NUM_CASE<19) then
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

	!Call Main Functions
	print *, "### Generating Grid ###"
	ALLOCATE(YPAD(N),YHAD(N))
	CALL sGrid_Generator(H,N,ALPHA,YPAD,YHAD)
	print *, "### Solving for Flow Parameters ###"
        CALL flowSolve(VW,H,N,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,MAX_ITER,OUTPUTFILE,NUM_CASE)
        DEALLOCATE(YPAD,YHAD) 	
 	
        !Data Management
        print *, "### Organizing Data Files ###"
        print *, "Copied Successfully "
        print *, "Copying Generated simulation data to the directory '../Simulated_Data'"
        EXCOMMAND="cp "//OUTPUTFILE//" ../Simulated_Data/"//OUTPUTFILE
        print *, trim(EXCOMMAND)
        call system(trim(EXCOMMAND))
        print *, "Copied Successfully "

        !Automatic Plotting
        print *, "### Plotting ###"
        EXCOMMAND="python autoplotting.py --file "//OUTPUTFILE
        if (PLOT=='Y') then
                print *, "Creating Plots"
                print *, trim(EXCOMMAND)
                call system(trim(EXCOMMAND))
        else
                print *, "Auto Plotting Disabled" 
                print *, "For direct plotting, type 'python autoplotting.py --file ",OUTPUTFILE," '"
        end if

        print*, "Cleaning Execution Directory"
        call system("rm *.dat")

       !end do !end of RunAllCasesLoop
end program
