rem
rem Assemble the testbench file
rem
as8080 test=test
ln testr=test
genrom testr.obj > test.lst
