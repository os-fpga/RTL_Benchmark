SRC_KER_DIR = ../ANN_kernel/RTL_VHDL_files
SRC_TB_DIR = ./src
VHDLS = \
	${SRC_KER_DIR}/layers_pkg.vhd \
	${SRC_KER_DIR}/support_pkg.vhd \
	${SRC_KER_DIR}/wb_init.vhd \
	${SRC_KER_DIR}/mac.vhd \
	${SRC_KER_DIR}/af_sigmoid.vhd \
	${SRC_KER_DIR}/af_sigmoid2.vhd \
	${SRC_KER_DIR}/af_sigmoid_mat.vhd \
	${SRC_KER_DIR}/activation_function.vhd \
	${SRC_KER_DIR}/shiftreg_pl.vhd \
	${SRC_KER_DIR}/shiftreg_pu.vhd \
	${SRC_KER_DIR}/adder_tree.vhd \
	${SRC_KER_DIR}/layerPS.vhd \
	${SRC_KER_DIR}/layerPS_top.vhd \
	${SRC_KER_DIR}/layerSP.vhd \
	${SRC_KER_DIR}/layerSP_top.vhd \
	${SRC_KER_DIR}/ann.vhd \
	${SRC_TB_DIR}/ann_tb.vhd

# STD=standard
STD=synopsys
VSTD=93c
# VSTD=08
ENTITY=ann_tb
#RUN_OPTIONS= --stop-time=1000ns --wave=${ENTITY}.ghw 
RUN_OPTIONS=  --wave=${ENTITY}.ghw 

all: ${ENTITY}.ghw
no_ghw : ${ENTITY}
	./${ENTITY}
reader:   ${ENTITY} ${ENTITY}.ghw
	gtkwave ${ENTITY}.ghw ${ENTITY}.sav
${ENTITY}: ${VHDLS}
	ghdl -a -g --mb-comments --workdir=comp --std=${VSTD} ${VHDLS} 
	ghdl -e -g --mb-comments --workdir=comp --std=${VSTD} -fexplicit --ieee=${STD} ${ENTITY}
${ENTITY}.ghw: ${ENTITY}
	./${ENTITY} ${RUN_OPTIONS} 
clean:
	rm -f comp/* *.o *.vcd *.ghw events* ${ENTITY}
	
