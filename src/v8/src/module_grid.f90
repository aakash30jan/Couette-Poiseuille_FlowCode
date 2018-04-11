!==================================================================================================
!>Module: module_grid                                                                             !
!>Details: This module generates a stretched grid and is a modified version of the original code  !
!>=================================================================================================

module module_grid

contains
SUBROUTINE sGrid_Generator(H,N1,ALPHA,YPAD,YHAD) 

IMPLICIT NONE 

REAL(8),INTENT(IN)				::ALPHA
INTEGER,INTENT(IN)				::N1
REAL(8),DIMENSION(N1),INTENT(INOUT)		::YPAD,YHAD
INTEGER						::J,I
REAL(8)						::ALPHA1,ALPHA2
INTEGER						::N05,N06
REAL(8)						::COEF
REAL(8),INTENT(IN)				::H	

ALPHA1=ALPHA
ALPHA2=ALPHA
N05=(N1+1)/2
N06=N05+1

!---  MESH FOR HALF LOWER CHANNEL ---
COEF=DEXP(ALPHA1*(1.-N05))
DO J=2,N05
   YPAD(J)=(.5*(DEXP(ALPHA1*(J-N05))-COEF)/(1.-COEF))*(H) 
ENDDO
!---  MESH FOR HALF UPPER CHANNEL ---
COEF=DEXP(ALPHA2*(N05-N1))
DO J=N06,N1-1
  YPAD(J)=(1.-.5*(DEXP(ALPHA2*(N05-J))-COEF)/(1.-COEF))*(H) 
ENDDO
!---  NEAR WALL POINTS ---
YPAD(1)=-YPAD(2)
YPAD(N1)=(2.*H)-YPAD(N1-1)
YHAD(1)=0.
DO J=2,N1
  YHAD(J)=YPAD(J)-YPAD(J-1)
ENDDO


!UNCOMMENT this block, if you want to save grid points in a separate file.
!OPEN(12,file='GRID.dat')
!WRITE(12,"(A26,I4,A31,1ES16.8)") '# GRID: NUMBER OF POINTS: ',N1,' STRETCHING COEFFICIENT ALPHA: ',ALPHA
!WRITE(12,*) "#I        YPAD              YHAD"
!DO I=1,N1
!        WRITE(12,11)I,YPAD(I),YHAD(I)
!ENDDO
!11 FORMAT(I3,2x,2(F16.8,2x))	
!CLOSE(12)

print *,"Grid Generation Successfull."
end subroutine
end module module_grid
