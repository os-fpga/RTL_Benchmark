//  Design Library
-v $GEMINI_IP/dti/hdl/dataflow_controller.v
-v $GEMINI_IP/dti/hdl/datapath.v
-v $GEMINI_IP/dti/hdl/dfi_bridge.v
-v $GEMINI_IP/dti/hdl/dynamo_mux.v
-v $GEMINI_IP/dti/hdl/port_bridge.v
-v $GEMINI_IP/dti/hdl/protocol_controller.v
-v $GEMINI_IP/dti/hdl/register_block.v
-v $GEMINI_IP/dti/hdl/dynamo_core.v
-v $GEMINI_IP/dti/hdl/dynamo_sram_rcb.sv
-v $GEMINI_IP/dti/hdl/dynamo_sram_wcb.sv
-v $GEMINI_IP/dti/hdl/dynamo_sram_rmw.sv
-v $GEMINI_IP/dti/hdl/dynamo_sram.v
-v $GEMINI_IP/dti/hdl/dynamo.v

-y $GEMINI_IP/dti/libs/dti_mem/hdl

//  Include Pat
+incdir+$GEMINI_IP/dti/inc

$GEMINI_IP/dti/hdl/dynamo.v
