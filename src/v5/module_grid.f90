module module_grid

contains
!==================================================================
!> SUBROUTINE TO GENERATE 1D STRETCHED GRID WITH N1 POINTS
!> This subroutine basically divides the domain of length 1 unit from 0 to 1 in N1 number points
!> According to the requirement, the discretized points have to be multiplied with length H to have a grid of size H. If this is not multiplied, it wil simply create the mesh from 0 to 1 
!> modified version of original code by Dr. Laval 
!> Original code : http://imp-turbulence.ec-lille.fr/Webpage/Laval/Lectures/TD-Programs.tar
!==================================================================
SUBROUTINE sGrid_Generator(H,N1,ALPHA,YPAD,YHAD) 

IMPLICIT NONE 


REAL(8),INTENT(IN)				::ALPHA
INTEGER,INTENT(IN)				::N1
REAL(8),DIMENSION(N1),INTENT(INOUT)		::YPAD,YHAD
INTEGER						::J
REAL(8)						::ALPHA1,ALPHA2
INTEGER						::N05,N06
REAL(8)						::COEF
REAL(8),INTENT(IN)				::H	


!WRITE(*,3)N1,ALPHA
!3 FORMAT('# GRID: NUMBER OF POINTS: ',I3,' STRETCHING COEFFICIENT ALPHA: ',F7.3)

ALPHA1=ALPHA
ALPHA2=ALPHA

N05=(N1+1)/2
N06=N05+1

!---  MESH FOR HALF LOWER CHANNEL ---

COEF=DEXP(ALPHA1*(1.-N05))
DO J=2,N05
   YPAD(J)=(.5*(DEXP(ALPHA1*(J-N05))-COEF)/(1.-COEF))*(H) 	!Multiplying by H
ENDDO

!---  MESH FOR HALF UPPER CHANNEL ---

COEF=DEXP(ALPHA2*(N05-N1))
DO J=N06,N1-1
  YPAD(J)=(1.-.5*(DEXP(ALPHA2*(N05-J))-COEF)/(1.-COEF))*(H) 	!Multiplying by H
ENDDO

!---  NEAR WALL POINTS ---

YPAD(1)=-YPAD(2)
YPAD(N1)=(2.*H)-YPAD(N1-1)

YHAD(1)=0.
DO J=2,N1
  YHAD(J)=YPAD(J)-YPAD(J-1)
ENDDO


!Print *, "# The first grid point out of the domain is:  ", YPAD(1)  !First grid point out of FVM domain
!Print *, "# The last grid point out of the domain is:  ", YPAD(N1)  !Last grid point out of FVM domain
 
end subroutine


end module module_grid
