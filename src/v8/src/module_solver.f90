module module_solver
use module_triSolve
implicit none

contains
!====================================================================
!>Calculating velocity profile
!====================================================================
SUBROUTINE SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,MAX_ITER,OUTPUTFILE,NUM_CASE)
!SUBROUTINE SOLVE_CP(U,ERROR,U1,VW,H,N,LD,MD,UD,D,YPAD,YHAD,ALPHA,DPDX,KIN_VIS,CONV_CRIT,OUTPUTFILE,NUM_CASE)
	IMPLICIT NONE
	INTEGER :: I,J,K,ITERATIONS
	INTEGER,INTENT(IN):: N,NUM_CASE,MAX_ITER
	REAL(8),INTENT(IN):: YPAD(N),H,VW,YHAD(N),ALPHA,DPDX,CONV_CRIT
	REAL(8),INTENT(IN):: KIN_VIS
	REAL(8),INTENT(INOUT):: U(N)
	REAL(8)			  ::ERROR,U1(N),LD(1:N),MD(1:N),UD(1:N),D(1:N),LEN_ZERO(N),UTAU1,UTAU2,A1,A2,MIX_LEN(N)
	REAL(8)			  ::TKIN_VIS(1:N),TKIN_VISN(1:N),TKIN_VISS(1:N),A(1:N),B(1:N),U_AVG,YF(N-1)
	CHARACTER(len=15),INTENT(IN):: OUTPUTFILE
	open(33,file=OUTPUTFILE)	
	
	ERROR=1.0D0
	U1=0.0d0
	YF(1)=0.0D0
	DO I=2,N-1
		YF(I)=YPAD(I)+ (YPAD(I)-YF(I-1)) !YPAD at the faces of the control volume
	END DO
	DO I= 2,N-1	
		LEN_ZERO(I)=(0.21D0-(0.43D0*((1.0D0-(2.0D0*(YF(I)/H)))**4)) + (0.22D0*((1.0D0-(2.0D0*(YF(I))/H))**6)))*(H/2.0D0)
	END DO
	
	ITERATIONS=0 ! iterations for convergence
	Do 
		IF(ERROR>CONV_CRIT .AND. ITERATIONS<MAX_ITER )THEN !convergence criteria
		!IF(ERROR>CONV_CRIT)THEN !convergence criteria
		!print *, ITERATIONS
		U1=0.0d0										!Iniatialise the array
		     IF (NUM_CASE<16) THEN
        		        UTAU1=DSQRT((dabs(U(2))/(YPAD(2)))*KIN_VIS)		!case 1 to 15
                     ELSE		
				UTAU1=DSQRT((dabs(U(2)-U(1))/(YHAD(2)))*KIN_VIS)        !case 16 to 18, lower wall is moving
                     END IF		
		UTAU2=DSQRT((dabs(U(N-1)-U(N))/(YHAD(N)))*KIN_VIS) 
			
		A1=26.0d0*KIN_VIS/UTAU1 			!CORROESPONDS TO LOWER WALL
		A2=26.0d0*KIN_VIS/UTAU2				!CORROSPONDS TO UPPER WALL
	
		Do I=2,(N+1)/2	
			MIX_LEN(I)=LEN_ZERO(I)*(1.0d0-DEXP(-YF(I)/A1))
			MIX_LEN(N-(I-1))=LEN_ZERO(N-(I-1))*(1.0d0-DEXP(-YF(I)/A2))	
		END DO
		DO I=2,N-1		
			TKIN_VISN(I)=(MIX_LEN(I)**2)*Dabs((U(I+1)-U(I))/(YHAD(I+1)))    !North faced Turbulent viscosity
			!print*,"TKIN_VISN=",TKIN_VISN(I)
			TKIN_VISS(I)=(MIX_LEN(I)**2)*abs((U(I)-U(I-1))/(YHAD(I)))	 !South faced Turbulent viscosity
			!print*,"TKIN_VISS=",TKIN_VISS(I)
			TKIN_VIS(I)=(TKIN_VISN(I)+TKIN_VISS(I))/2.0   !AVERAGE of North and South
		END DO
		DO I=2,N-1
			!A(I)= KIN_VIS + TKIN_VISN(I)   
	                !B(I)= KIN_VIS + TKIN_VISN(I-1) 
	                A(I)= KIN_VIS + TKIN_VIS(I)   
	                B(I)= KIN_VIS + TKIN_VIS(I-1)  	
 	
		END DO
		!Initialise thomas matrix
		LD=0.0d0;MD=0.0d0;UD=0.0d0
		
		DO I=2,N-1
			LD(I)=B(I)/YHAD(I)							!LD= lower diagonal of TDMA
			MD(I)=-((A(I)/YHAD(I+1))+(B(I)/YHAD(I)))	!MD= middle diagonal of TDMA
			UD(I)=A(I)/(YHAD(I+1))						!UP= Uppar diagonal of TDMA
		END DO
		MD(1)=1.0D0;MD(N)=1.0D0							!Boundary Conditions
		UD(1)=1.0D0;LD(N)=1.0D0;LD(1)=0.0D0;UD(N)=0.0D0 !!Boundary Condition
		IF (NUM_CASE<16) THEN
        		D(1)=0.0d0			!for case 1-15
		ELSE
		        D(1)=2.0D0*VW		!for 16-18 case
		END IF
		DO I=2,N-1
			D(I)=DPDX*((YPAD(I+1)-YPAD(I-1))/2.0d0)
		END DO
		IF (NUM_CASE<16) THEN
        		D(N)=2.0D0*VW		!for case 1-15
		ELSE
		        D(N)=0.0d0	        !for 16-18 case
                END IF
                
                call  triSolve(LD,MD,UD,D,U1,N)
                ERROR=0.0d0
		DO I=2,N-1
  			ERROR=ERROR+(U(I)-U1(I))**2
  		END DO
		ERROR=DSQRT(ERROR/DFLOAT(N-2))
		!print*,"Error=",ERROR
		U=U1
		ITERATIONS= ITERATIONS+1
		
		ELSE
      		       		EXIT
  		ENDIF

  		
  	END DO
  	IF (ITERATIONS==MAX_ITER) THEN
          	PRINT *, "Convergence was not reached !"
       		PRINT *, "Calculations terminated after", MAX_ITER,"iterations."
  	ELSE
        	print*,"Total Number Iterations=",ITERATIONS
	END IF
	IF (NUM_CASE<16) THEN
        	UTAU1=SQRT((abs(U(2))/(YPAD(2)))*KIN_VIS)			!Case 1 to 15
	ELSE
	        UTAU1=DSQRT((dabs(U(2)-U(1))/(YHAD(2)))*KIN_VIS)                !Case 16 to 18
	END IF
	PRINT*,"UTAU1=",UTAU1		
	UTAU2=SQRT((abs(U(N-1)-U(N))/(YHAD(N)))*KIN_VIS)
	PRINT*,"UTAU2=",UTAU2
	U_AVG=SUM(U(2:N-1))/DFLOAT(N-2)
	print*,"U Average=",ABS(U_AVG),"U Max=",MAXVAL(ABS(U))
	WRITE(33,*) "######################################################################"
	WRITE(33,*) "#Data for Case=",NUM_CASE	
	WRITE(33,*) "#   ALPHA,             N,       ITERATIONS, VW,          UMAX ,       UAVG,           UTAU1,          UTAU2    "
	WRITE(33,"(A3,ES16.8,I8,I10,5ES16.8)") "#",ALPHA,N,ITERATIONS,VW,MAXVAL(ABS(U)),ABS(U_AVG),UTAU1,UTAU2
	WRITE(33,*) "######################################################################"
	PRINT *, "this is the val",MAXVAL(ABS(U))
	IF (NUM_CASE<16) THEN
        	WRITE(33,*) "# YPAD(I)/H,     U(I)/VW	"		
	        WRITE(33,"(2ES16.8)")0.0D0,0.0D0 			!Case 1 to 15
	ELSE
	        WRITE(33,*) "# YPAD(I)/H,     U(I)/U_AVG	"
	        WRITE(33,"(2ES16.8)")0.0d0,VW/UTAU2 		        !Case 16 to 18
	END IF
	DO I=2,N-1
		IF (NUM_CASE<15) THEN
		        WRITE(33,"(2ES16.8)")YPAD(I)/H,U(I)/VW			!Case 1 to 15
		ELSE IF(NUM_CASE==15) THEN
		        WRITE(33,"(2ES16.8)")YPAD(I)/H,U(I)/(MAXVAL(ABS(U)))    !Case 15
		        !WRITE(33,"(2ES16.8)")YPAD(I)/H,U(I)/(1000.0) 
		ELSE
		        WRITE(33,"(2ES16.8)")YPAD(I)/H,U(I)/U_AVG 		!Case 16 to 18 
		END IF
		
	END DO
	
	IF (NUM_CASE<15) THEN
	        WRITE(33,"(2ES16.8)")1.0D0,1.0d0        !For Case 1 to 15
	ELSE
	        WRITE(33,"(2ES16.8)")1.0D0,0.0D0 	!For Case 16 to 18 
	END IF
	CLOSE(33)
END SUBROUTINE



end module module_solver
