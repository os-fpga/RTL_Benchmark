# Test Flow for Best Benchmark of Dhrystone, CoreMark, and Whetstone

* Execute configuration tool: ${NDS_HOME}/config_tools/nds-softcore-config
* Press ``Load'' to load a benchmark configuration
  * Select ${NDS_HOME}/andes_vip/patterns/samples/benchmark_cfg/nds_benchmark.cfg to configured a45_core
* Press ``Generate a45_core'' to generate selectd configuration
* Setup the Andes toolchain, the following information are demonstrated with ${ANDESIGHT_INSTALL_PATH}/AndeSight-v5_1_1/toolchains-bin/nds32le-elf-mculib-v5d/bin

## Get the Best Benchmark of Dhrystone

* Change directory to ${NDS_HOME}/andes_vip/patterns/samples/test_dhrystone_v5
* Execute the following commands
  * make clean
  * make cleanrom
  * make dhry
  * make
  * make getdmips
  * Return message:

```
./getdmips.pl
cat dmips.log
======= DMIPS report =======
insn per loop = 264
micro per loop = 264
cycle per loop = 192
DMIPS/MHz = 2.964333
============================
```

## Get the Best Benchmark of CoreMark

* Change directory to ${NDS_HOME}/andes_vip/patterns/samples/test_coremark_v5
* Execute the following commands
  * make clean
  * make cleanrom
  * make coremark
  * make
  * make getcoremark
  * Return message:

```
./getcoremark.pl
cat coremark.log
======= COREMARK report =======
insn per loop = 231047
micro per loop = 231047
cycle per loop = 177680
COREMARK/MHz = 5.628095
============================
```

## Get the Best Benchmark of Double Precision Whetstone

This test flow is only supported when configured with Double precision.

* Change directory to ${NDS_HOME}/andes_vip/patterns/samples/test_whetstone_v5
* Execute the following commands
  * make clean
  * make cleanrom
  * make whet FPU_TEST_TYPE=dp
  * make
  * make getwips
  * Return message:

```
./getwips.pl
cat whet.log
N1 array elements                  : Fpu ops/cycle =       0.30,  MFLOPS =      11.99, (delta_t=  160102)
N2 array as function parameter     : Fpu ops/cycle =       0.04,  MFLOPS =       1.48, (delta_t=  905775)
N3 (integer) condictional jumps    : Fpu ops/cycle =       0.48,  MOPS   =      19.21, (delta_t=   53875)
N4 integer arithmetic              : Fpu ops/cycle =       0.12,  MOPS   =       4.99, (delta_t=  631800)
N5 trig functions (sin,cos,atan)   : Fpu ops/cycle =       0.00,  MOPS   =       0.13, (delta_t= 6377975)
N6 procedure calls                 : Fpu ops/cycle =       0.03,  MFLOPS =       1.20, (delta_t= 4496524)
N7 array reference                 : Fpu ops/cycle =       0.86,  MOPS   =      34.22, (delta_t=   54000)
N8 standard function (exp,sqrt,log): Fpu ops/cycle =       0.00,  MOPS   =       0.08, (delta_t= 4723850)
MWIPS =                57.46, MWIPS/MHz =                 1.44
Core clock period = 25 (for the accuracy, the clk period shoud be an integer)
```

