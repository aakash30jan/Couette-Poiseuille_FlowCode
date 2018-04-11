!=========================================================================
!>Module: module_triSolve                                                !
!>Details: This module solves a tridiagonal matrix by Thomas algorithm   !
!>=========================================================================

module module_triSolve

implicit none
contains
	subroutine triSolve(a,b,c,d,x,n) 
		implicit none
		integer::i
		integer,intent(IN) ::n
		real(8) ::a(n),b(n),c(n),d(n),x(n)
	        ! a is the lower diagonal of the tridiagonal matrix
	        ! b is the main diagonal of the tridiagonal matrix
	        ! c is the upper diagonal of the tridiagonal matrix
	        ! d is the right hand side of the equations of the tridiagonal matrix
	        ! x is the numerical value calculated from the thomas algorithm
	        ! n is the number of discritizations
		do i=2,n
			b(i)=b(i)-((a(i)/b(i-1))*c(i-1))
			d(i)=d(i)-((a(i)/b(i-1))*d(i-1))
		end do
			x(n)=d(n)/b(n)
		do i=n-1,1,-1
			x(i)=(d(i)-(c(i)*x(i+1)))/b(i) 
		end do
	end subroutine triSolve
end module module_triSolve

!USAGE: USE module_triSolve
!way to define in main program  
!a=-1.0d0
!a(1)=0.0d0	
!b=2.0d0			
!c=-1.0d0
!c(n)=0.0d0
!call  triSolve(a,b,c,d,u,n)
