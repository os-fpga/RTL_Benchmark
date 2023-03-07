# AndesCore&trade; A45 Quick Start Manual

## Table of Contents

+ [Prerequisites](#prerequisites)
+ [Configuration Tool](#configuration_tool)
+ [Simulation](#simulation)
    + [SystemVerilog Simulator Selection](#systemVerilog_simulator_selection)
    + [Test Case Organization](#test_case_organization)
    + [Extra Options for SystemVerilog Simulators](#extra_options_for_systemverilog_simulators)
    + [Simulation File List](#simulation_file_list)
    + [Clean Up of Simulation Results](#clean_up_of_simulation_results)

## <a name="prerequisites" /> Prerequisites

Please check the following items regarding your simulation environment before performing the verification:

* The A45 softcore RTL requires SystemVerilog compatible simulators.
* To run simulations, the simulation environment requires standard Unix tools like `make`, `sed`, `grep` and `perl`.
* The softcore GUI configuration tool requires the Tcl/Tk interpreter `wish` to be installed in the system.
* This document assumes that environment variable **$NDS_HOME** points to the top directory of the A45 distribution.

## <a name="configuration_tool" /> Configuration Tool

The configuration tool allows interactive selection of configurable options. The tool is Tcl/Tk based and it requires the Tk interpreter `wish` to exist in the search path. To start the tool, make sure that the **$DISPLAY** environment variable is set correctly to point to a valid X server, and then type the following command to launch the configuration tool:

```
${NDS_HOME}/config_tools/nds-softcore-config
```

The `Save` button saves your options so that it could later be loaded into the tool. The `Generate A45_core` button configures the A45 processor with the selected options. By clicking this button, the following files are generated and overwritten. If required, back up the files before re-configuring the processor.

* **$NDS_HOME**/andes_ip/kv_core/top/hdl/config.inc
    * Configuration for the A45, required by the accompanying testbench.
* **$NDS_HOME**/andes_ip/ae350/top/hdl/include/ae350_config.vh
    * Configurations for the platform, required by the AE350 CPU subsystem and chip.
* **$NDS_HOME**/andes_ip/kv_core/top/hdl/ae350_cpu_subsystem.v
    * Sample CPU subsystem that instantiates the a45_core_top. This subsystem is for the AE350 platform.
* **$NDS_HOME**/andes_ip/kv_core/top/hdl/a45_core_top.v
    * Top module of the A45 processor.
* **$NDS_HOME**/andes_ip/kv_core/top/hdl/a45_core.v
    * Core design wrapper of the A45 processor.
* **$NDS_HOME**/andes_ip/kv_core/top/hdl/kv_core.v
    * Core design of the A45 processor.
* **$NDS_HOME**/andes_ip/kv_core/top/hdl/a45_core_top.xml
    * IP-XACT XML for the A45 processor.

See AndesCore&trade; A45 Data Sheet for more details.

## <a name="simulation" /> Simulation

This section is a brief introduction on running simulation with A45; see AndesCore&trade; A45 Data Sheet for more details.

A simple test bench is included in the A45 distribution. To start a simulation with the generated image file,

1. Set **$NDS_HOME** to the top directory of the package:


```
bash: export NDS_HOME=<top directory of this package>
csh:  setenv NDS_HOME <top directory of this package>
```

2. Change directory to the sample pattern directory:


```
cd ${NDS_HOME}/andes_vip/patterns/samples
```


3. Select a test case and run it:

```
cd test_atcapbbrg100
```

4. Use `VERILOG` to set your favorite SystemVerilog simulator, the default is `xrun`.
```
xrun: make VERILOG=xrun
vcs:  make VERILOG=vcs
```

Output of the simulation should look like the following figure.


```
linux$ make
irun -l verilog.log -exit +licq +nowarn+CUVWSP +nowarn+LIBNOU +nowarn+SPDUSD -f flist
...
68644.53 ns:ipipe:reset 80000000
...
94907.03 ns:ipipe:0:@00000080=0080006f
95007.03 ns:ipipe:0:@00000088=00200197
95032.03 ns:ipipe:0:@0000008c=77818193
95057.03 ns:ipipe:0:@00000090=00201297
95082.03 ns:ipipe:0:@00000094=f7028293
...
487357.00 ns:ipipe:sim_ctrl finish=0
487357.03 ns:ipipe:0:---- SIMULATION PASSED ----
...
linux$
```

Upon a successful simulation, the `SIMULATION PASSED` string shall be observed at the end of the output file. Otherwise, simulations will either hang forever (most likely due to X-propagation) or `SIMULATION FAILED` string will appear if errors are detected.

The output message is intentionally terse to speed up simulation time. It could be decoded into assembly outputs with `ipipe_decode.pl`. The `ipipe_decode.pl` command can be found as

```
${NDS_HOME}/tools/bin/ipipe_decode.pl
```

The following example shows a sample decoded output.

```
linux$ export PATH=$NDS_HOME/tools/bin:$PATH
linux$ ipipe_decode.pl < verilog.log
...
68644.53 ns:ipipe:reset 80000000
...
94907.03 ns:ipipe:0:@00000080=0080006f jal zero, +0x00008 (0x00000088)
95007.03 ns:ipipe:0:@00000088=00200197 auipc gp, 0x00200000 (0x00200088)
95032.03 ns:ipipe:0:@0000008c=77818193 addi gp, gp, 0x778
95057.03 ns:ipipe:0:@00000090=00201297 auipc t0, 0x00201000 (0x00201090)
95082.03 ns:ipipe:0:@00000094=f7028293 addi t0, t0, -0x090
...
487182.00 ns:ipipe:sim_ctrl finish=0
487182.03 ns:ipipe:0:---- SIMULATION PASSED ----
...
linux$
```

### <a name="systemVerilog_simulator_selection" /> SystemVerilog Simulator Selection

The test cases are launched through Makefiles. Before starting the simulation, please edit


```
${NDS_HOME}/andes_vip/patterns/samples/Make.vars
```

such that the make variable **$(VERILOG)** points to a valid SystemVerilog simulator.

### <a name="test_case_organization" /> Test Case Organization

Test cases are organized as a hierarchy of directory tree through Makefiles. The default make target compiles and runs all test cases. Typing `make` at the topmost level will run all test cases under the directory. Individual test cases can also be run by starting make at the specific test case subdirectory. Examples as below: 

```
# run all test cases under the "samples" subdirectory
cd ${NDS_HOME}/andes_vip/patterns/samples; make

# or, run test_atcapbbrg100 only
cd ${NDS_HOME}/andes_vip/patterns/samples/test_atcapbbrg100; make
```

### <a name="extra_options_for_systemverilog_simulators" /> Extra Options for SystemVerilog Simulators
To pass extra options to the simulator, the **$(VPLUSDEFINES)** variable could be modified through the `make` command line or through modifying


```
${NDS_HOME}/andes_vip/patterns/samples/Make.vars
```

For example, the following command could be used to enable dumping waveforms:

```
make VPLUSDEFINES="+define+DUMP+TRN +access+rc"
```

### <a name="simulation_file_list" /> Simulation File List

The simulation file list is defined at:

```
${NDS_HOME}/flists/flist.in
```

The `flist.in` file must be processed to expand the **$NDS_HOME** variable to the actual path value before SystemVerilog simulators could accept it as a valid command line switch file. 
This is handled by the following rule in `Makefile`:


```
@rm -f flist
@sed -e pass:["s,\$$NDS_HOME,$$NDS_HOME,"] < pass:[$$NDS_HOME/flists/flist.in] \
 | grep -v "#" | sed -e "s,//*,/,g" > flist
```

### <a name="clean_up_of_simulation_results" /> Clean Up of Simulation Results
The target `make clean` can be used to clean up the simulation results.
