#first run
#create suitable directories


echo "Compiling modules"
gfortran -c module_*.f90
echo "Compiling main program with the modules"
gfortran cpflow_1D.f90 module_*.o -o cpflow_1D.exe -fcheck=all
echo "Generated cpflow_1D.exe"

