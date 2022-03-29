sear_path=$(find . -name "*config.tcl")
for dir_s in $sear_path; do
    echo $dir_s
    sed -i 's/New_RTL/opentitan/IP/RTL_Benchmark/SVerilog/opentitan/g' $dir_s
done
