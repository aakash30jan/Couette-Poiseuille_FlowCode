#first run
#clean 
# rm *.dat *.mod *.o *.exe
#create suitable directories


echo "Compiling modules . . . ."
gfortran -c module_triSolve.f90
gfortran -c module_parameters.f90
gfortran -c module_grid.f90
gfortran -c module_solver.f90
echo "Compiling main program with the modules . . . ."
gfortran cpflow_1D.f90 module_*.o -o cpflow_1D.exe -fcheck=all
echo "Generated cpflow_1D.exe"


echo "Running cpflow_1D.exe"
today=`date +%d%m%Y_%H%M%S` 
./cpflow_1D.exe | tee log_$today.log
echo "Run Complete"
echo "Log file created"



