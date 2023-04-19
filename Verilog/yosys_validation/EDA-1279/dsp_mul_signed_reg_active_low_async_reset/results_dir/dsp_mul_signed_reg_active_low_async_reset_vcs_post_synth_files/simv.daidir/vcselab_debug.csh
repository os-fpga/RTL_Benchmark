#!/bin/csh -f

cd /nfs_scratch/scratch/FV/awais/Synthesis/v1/yosys_verific_rs/RTL_Benchmark/Verilog/yosys_validation/EDA-1279/dsp_mul_signed_reg_active_low_async_reset/rtl

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/nfs_cadtools/synopsys/vcs_all/S-2021.09-SP2/linux64/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

