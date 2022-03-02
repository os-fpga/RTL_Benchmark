cd tb

iverilog -f filelist.f -o nlprg8
./nlprg8
rm nlprg8

cat log/nlprg8_tb.log

cd ..
