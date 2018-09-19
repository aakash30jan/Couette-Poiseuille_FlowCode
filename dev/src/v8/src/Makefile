.SUFFIXES: .o .f90 .F90

.F90.o:
	$(CPP) $(CPPFLAGS) -P $*.F90 > $*.f90
	$(CFT) -c $(FFLAGS) $*.f90

.f90.o:
	$(CFT) -c $(FFLAGS) $<

.F90.f90:
	$(CPP) $(CPPFLAGS) -P $*.F90 > $*.f90

.F90:
	$(CFT) -o $@ $(FFLAGS) $<

.f90:
	$(CFT) -o $@ $(FFLAGS) $<

         RM = /bin/rm
         CFT = gfortran -fcheck=all
       

RBIN = cpFlow.exe

SRCS =	module_triSolve.f90             \
        module_parameters.f90           \
        module_grid.f90                 \
        module_solver.f90               \
        cpFlow.f90


OBJS=$(SRCS:.f90=.o)

$(RBIN): ${OBJS}
		${CFT} ${FFLAGS} -o $(RBIN) ${OBJS} ${LIBS}

clean:
		$(RM) -f *.o *.mod *.out *.exe
		
check:
	        $ python --version	



