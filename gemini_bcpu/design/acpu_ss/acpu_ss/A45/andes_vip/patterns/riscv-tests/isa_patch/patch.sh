#!/bin/sh

RISCV_TESTS_TOP=$NDS_HOME/andes_vip/patterns/riscv-tests
original_files=("rv64mi/access.S" "rv64mi/breakpoint.S" "rv64ui/fence_i.S" "rv64uf/move.S")
updated_files=("access.S" "breakpoint.S" "fence_i.S", "move.S")
for ((i=0; i< ${#original_files[@]};i++));
do
        if [ -f "$RISCV_TESTS_TOP/isa_patch/${updated_files[$i]}.patch" ] ; then
	        patch -Rsf --dry-run $RISCV_TESTS_TOP/isa/${original_files[$i]} < $RISCV_TESTS_TOP/isa_patch/${updated_files[$i]}.patch 1>/dev/null
        	if [ $? -ne 0 ]; then
	        	patch $RISCV_TESTS_TOP/isa/${original_files[$i]} < $RISCV_TESTS_TOP/isa_patch/${updated_files[$i]}.patch || exit $?
        	else
	        	echo "Patch $RISCV_TESTS_TOP/isa/${original_files[$i]} already applied"
        	fi
        fi
done
