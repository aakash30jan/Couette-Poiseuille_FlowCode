echo "Script to Make the Original Experimental Data Files Python-Friendly"
echo "Renaming all files to suitable convention . . . . "

for number in {1..9}
do
echo "Renaming Case_"$number"_El_Telbany.dat to Case_"$number"_exp.dat "
mv Case_0"$number"_El_Telbany.dat Case_0"$number"_exp.dat 
done
#exit 0


for number in {10..15}
do
echo "Renaming Case_"$number"_El_Telbany.dat to Case_"$number"_exp.dat "
mv Case_"$number"_El_Telbany.dat Case_"$number"_exp.dat 
done
#exit 0

echo "Renaming other three cases . . . ."

mv Case_16_Gilliot_Couette.dat Case_16_exp.dat
mv Case_17_Gilliot_Intermediate.dat Case_17_exp.dat
mv Case_18_Gilliot_Poiseuil.dat Case_18_exp.dat


echo "All files have been renamed to suitable convention . . . . "

echo "Commenting header of data files . . . "
sed -i "1s/ /# /" *_exp.dat
sed -i "2s/ /# /" *_exp.dat
echo "Completed commenting headers . . . "
echo "Proceed to manual cleaning of headers for file case 1,14,16,17,18."
echo "Replace commas(,) with dots(.) for files 16,17,18"

