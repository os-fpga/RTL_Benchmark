
BUILD_NAME =  C:/official/prj/prj_svn_apb_to_spi/apb2spi/trunk
QVH_HOME = C:/questasim64_10.2c/uvm-1.1d/win64
RTL_DIR =  ${BUILD_NAME}/rtl
RTL_INC =  +incdir+${RTL_DIR}
APB_INC =  +incdir+${BUILD_NAME}/tb/env/apb_agent
SPI_INC =  +incdir+${BUILD_NAME}/tb/env/spi_agent
ENV_INC =  +incdir+${BUILD_NAME}/tb/env
TESTS_INC = +incdir+${BUILD_NAME}/tb/tests

WORK : clean
	${vlib} work

RTL : WORK
	${vlog} -sv ${RTL_INC} ${RTL_DIR}/APB_SLAVE.v ${RTL_DIR}/APB_SPI_Top.v
	#Vlog -sv ${RTL_DIR}/defines.v ${RTL_DIR}/APB_SLAVE.v ${RTL_DIR}/APB_SPI_Top.v

TB : RTL
	${vlog} -sv ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${TESTS_INC} tb_top.sv

SIM : TB
	#${qverilog} -sv ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${ENV_SRC_INC} ${TESTS_INC} tb_top.sv -R -sv_lib ${QVH_HOME}/uvm_dpi -c -do "run -all; q" -l questa.log
	${vsim} -novopt ${RTL_INC} ${APB_INC} ${SPI_INC} ${ENV_INC} ${ENV_SRC_INC} ${TESTS_INC} tb_top -sv_lib ${QVH_HOME}/uvm_dpi -c -do "run -all; q" -l vsim.log

clean:
	rm -rf work vlib.log vlog.log vsim.log
	
	
