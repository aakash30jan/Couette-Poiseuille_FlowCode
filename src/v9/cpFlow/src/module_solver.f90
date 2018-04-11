!=======================================================================================
!>Module: module_solver                                                                !
!>Details: This module solves for flow paramters of the Couette-Poiseuille flow cases  !
!>======================================================================================

module module_solver
use module_triSolve
implicit none

contains
subroutine flowSolve(VW,H,N,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,MAX_ITER,OUTPUTFILE,NUM_CASE)
	implicit none
	REAL(8)                         :: UAVG                                 !Average flow velocity
	REAL(8)                         :: UTAU1        	                !Friction velocity at high-stress wall
	REAL(8)                         :: UTAU2	                        !Friction velocity at low-stress wall
	REAL(8)                         :: TKIN_VIS(1:N)	                !Average turbulent kinematic viscosity
	REAL(8)                         :: L_M(N), L_0(N),A1,A2                 !Parameters of Mixing Length Model
	REAL(8)                         :: U(N)                                 !Flow velocity at node points	
        !OTHER SUPPELEMENTARY PARAMETERS
        CHARACTER(len=15),INTENT(IN)    :: OUTPUTFILE
	INTEGER                         :: I,ITER
	INTEGER,INTENT(IN)              :: N,NUM_CASE,MAX_ITER
	REAL(8),INTENT(IN)              :: KIN_VIS,H,VW,ALPHA,DPDX,CONV_CRIT
	REAL(8),INTENT(IN)              :: YPAD(N),YHAD(N)
	REAL(8)			        :: ERROR,U1(N),LD(1:N),MD(1:N),UD(1:N),D(1:N)
	REAL(8)			        :: TKIN_VISN(1:N),TKIN_VISS(1:N),A(1:N),B(1:N),YF(N-1)
	

	YF(1)=0.0d0
	do I=2,N-1
		YF(I)=YPAD(I)+ (YPAD(I)-YF(I-1))
	end do
	do I= 2,N-1	
		L_0(I)=(0.21D0-(0.43D0*((1.0d0-(2.0d0*(YF(I)/H)))**4)) + (0.22D0*((1.0d0-(2.0d0*(YF(I))/H))**6)))*(H/2.0d0)
	end do
	ERROR=1.0d0
	ITER=0 
	do 
		if(ERROR>CONV_CRIT .AND. ITER<MAX_ITER )then 
		U1=0.0d0		
		     if (NUM_CASE<16) then
        		        UTAU1=DSQRT((dabs(U(2))/(YPAD(2)))*KIN_VIS)	
                     else		
				UTAU1=DSQRT((dabs(U(2)-U(1))/(YHAD(2)))*KIN_VIS)   
                     end if		
		UTAU2=DSQRT((dabs(U(N-1)-U(N))/(YHAD(N)))*KIN_VIS) 
		A1=26.0d0*KIN_VIS/UTAU1 			
		A2=26.0d0*KIN_VIS/UTAU2			
	        do I=2,(N+1)/2	
			L_M(I)=L_0(I)*(1.0d0-DEXP(-YF(I)/A1))
			L_M(N-(I-1))=L_0(N-(I-1))*(1.0d0-DEXP(-YF(I)/A2))	
		end do
		do I=2,N-1		
			TKIN_VISN(I)=(L_M(I)**2)*Dabs((U(I+1)-U(I))/(YHAD(I+1)))  
			TKIN_VISS(I)=(L_M(I)**2)*abs((U(I)-U(I-1))/(YHAD(I)))
			!AVERAGE of North and South Face Turbulent viscosity
			TKIN_VIS(I)=(TKIN_VISN(I)+TKIN_VISS(I))/2.0 
		end do
		do I=2,N-1
	                A(I)= KIN_VIS + TKIN_VIS(I)   
	                B(I)= KIN_VIS + TKIN_VIS(I-1)  	
 	        end do
		LD=0.0d0;MD=0.0d0;UD=0.0d0
		do I=2,N-1
			LD(I)=B(I)/YHAD(I)							
			MD(I)=-((A(I)/YHAD(I+1))+(B(I)/YHAD(I)))	
			UD(I)=A(I)/(YHAD(I+1))						
		end do
		MD(1)=1.0d0;MD(N)=1.0d0							
		UD(1)=1.0d0;LD(N)=1.0d0;LD(1)=0.0d0;UD(N)=0.0d0 
		if (NUM_CASE<16) then
        		D(1)=0.0d0			
		else
		        D(1)=2.0d0*VW		
		end if
		do I=2,N-1
			D(I)=DPDX*((YPAD(I+1)-YPAD(I-1))/2.0d0)
		end do
		if (NUM_CASE<16) then
        		D(N)=2.0d0*VW		
		else
		        D(N)=0.0d0	        
                end if
                !Solving with Tridiagonal Matrix Solver
                CALL triSolve(LD,MD,UD,D,U1,N)
                ERROR=0.0d0
		do I=2,N-1
  			ERROR=ERROR+(U(I)-U1(I))**2
  		end do
		ERROR=DSQRT(ERROR/DFLOAT(N-2))
		U=U1
		ITER= ITER+1
		
		else
      		       		EXIT
  		end if
	end do
  	if (ITER==MAX_ITER) then
          	print *, "Convergence was not reached !"
       		print *, "Calculations terminated after", MAX_ITER,"iterations."
  	else
        	print*,"Convergence was reached after, iterations =",ITER
	end if
	if (NUM_CASE<16) then
        	UTAU1=SQRT((abs(U(2))/(YPAD(2)))*KIN_VIS)			
	else
	        UTAU1=DSQRT((dabs(U(2)-U(1))/(YHAD(2)))*KIN_VIS)                
	end if
	UTAU2=SQRT((abs(U(N-1)-U(N))/(YHAD(N)))*KIN_VIS)
	print*,"UTAU1=",UTAU1,"UTAU2=",UTAU2
	UAVG=SUM(U(2:N-1))/DFLOAT(N-2)
	print*,"UAVG=",ABS(UAVG),"UMAX=",MAXVAL(ABS(U))
	open(33,file=OUTPUTFILE)
	write(33,*) "######################################################################"
	write(33,*) "#Data for Case=",NUM_CASE	
	write(33,*) "#   ALPHA,             N,       ITER, VW,          UMAX ,       UAVG,           UTAU1,          UTAU2    "
	write(33,"(A3,ES16.8,I8,I10,5ES16.8)") "#",ALPHA,N,ITER,VW,MAXVAL(ABS(U)),ABS(UAVG),UTAU1,UTAU2
	write(33,*) "######################################################################"
	if (NUM_CASE<16) then
        	write(33,*) "# YPAD(I)/H,     U(I)/VW	"		
	        write(33,"(2ES16.8)")0.0d0,0.0d0 			
	else
	        write(33,*) "# YPAD(I)/H,     U(I)/UAVG	"
	        write(33,"(2ES16.8)")0.0d0,VW/UTAU2 		        
	end if
	do I=2,N-1
		if (NUM_CASE<15) then
		        write(33,"(2ES16.8)")YPAD(I)/H,U(I)/VW			
		else if(NUM_CASE==15) then
		        write(33,"(2ES16.8)")YPAD(I)/H,U(I)/(MAXVAL(ABS(U)))    
		else
		        write(33,"(2ES16.8)")YPAD(I)/H,U(I)/UAVG 		
		end if
	end do
	if (NUM_CASE<15) then
	        write(33,"(2ES16.8)")1.0d0,1.0d0        
	else
	        write(33,"(2ES16.8)")1.0d0,0.0d0 	
	end if
	close(33)
end subroutine
end module module_solver
