module duram(
data_a,
data_b,
wren_a,
wren_b,
address_a,
address_b,
clock_a,
clock_b,
q_a,
q_b);   //synthesis syn_black_box

parameter DATA_WIDTH    = 32; 
parameter ADDR_WIDTH    = 5;  
parameter BLK_RAM_TYPE  = "AUTO";
parameter DURAM_MODE    = "BIDIR_DUAL_PORT";
parameter ADDR_DEPTH    = 2**ADDR_WIDTH;



input   [DATA_WIDTH -1:0]   data_a;
input                       wren_a;
input   [ADDR_WIDTH -1:0]   address_a;
input                       clock_a;
output  [DATA_WIDTH -1:0]   q_a;
input   [DATA_WIDTH -1:0]   data_b;
input                       wren_b;
input   [ADDR_WIDTH -1:0]   address_b;
input                       clock_b;
output  [DATA_WIDTH -1:0]   q_b;
 
 

altsyncram U_altsyncram (
.wren_a         (wren_a),
.wren_b         (wren_b),
.data_a         (data_a),
.data_b         (data_b),
.address_a      (address_a),
.address_b      (address_b),
.clock0         (clock_a),
.clock1         (clock_b),
.q_a            (q_a),
.q_b            (q_b),
.aclr0 (),
.aclr1 (),
.addressstall_a (),
.addressstall_b (),
//.byteena_a (),
//.byteena_b (),
.clocken0 (),
.clocken1 (),
.rden_b ()
);
    defparam
     //   U_altsyncram.intended_device_family = "Stratix",
        U_altsyncram.ram_block_type = BLK_RAM_TYPE,
        U_altsyncram.operation_mode = DURAM_MODE,
        U_altsyncram.width_a = DATA_WIDTH,
        U_altsyncram.widthad_a = ADDR_WIDTH,
//      U_altsyncram.numwords_a = 256,
        U_altsyncram.width_b = DATA_WIDTH,
        U_altsyncram.widthad_b = ADDR_WIDTH,
//      U_altsyncram.numwords_b = 256,
        U_altsyncram.lpm_type = "altsyncram",
        U_altsyncram.width_byteena_a = 1,
      //  U_altsyncram.width_byteena_b = 1,
        U_altsyncram.outdata_reg_a = "UNREGISTERED",
        U_altsyncram.outdata_aclr_a = "NONE",
        U_altsyncram.outdata_reg_b = "UNREGISTERED",
        U_altsyncram.indata_aclr_a = "NONE",
        U_altsyncram.wrcontrol_aclr_a = "NONE",
        U_altsyncram.address_aclr_a = "NONE",
     //   U_altsyncram.indata_reg_b = "CLOCK1",
    //    U_altsyncram.address_reg_b = "CLOCK1",
     //   U_altsyncram.wrcontrol_wraddress_reg_b = "CLOCK1",
     //   U_altsyncram.indata_aclr_b = "NONE",
     //   U_altsyncram.wrcontrol_aclr_b = "NONE",
     //   U_altsyncram.address_aclr_b = "NONE",
     //   U_altsyncram.outdata_aclr_b = "NONE",
        U_altsyncram.power_up_uninitialized = "FALSE";
 
endmodule 

(* blackbox *)
module altsyncram(data_a, address_a, wren_a, rden_a, q_a, data_b, address_b,  wren_b, rden_b,
                  q_b, clock0, clock1, clocken0, clocken1, clocken2, clocken3, aclr0, aclr1,
                  addressstall_a, addressstall_b);

   parameter clock_enable_input_b          = "ALTERNATE";
   parameter clock_enable_input_a          = "ALTERNATE";
   parameter clock_enable_output_b         = "NORMAL";
   parameter clock_enable_output_a         = "NORMAL";
   parameter wrcontrol_aclr_a              = "NONE";
   parameter indata_aclr_a                 = "NONE";
   parameter address_aclr_a                = "NONE";
   parameter outdata_aclr_a                = "NONE";
   parameter outdata_reg_a                 = "UNREGISTERED";
   parameter operation_mode                = "SINGLE_PORT";
   parameter intended_device_family        = "MAX 10 FPGA";
   parameter outdata_reg_b                 = "UNREGISTERED";
   parameter lpm_type                      = "altsyncram";
   parameter init_type                     = "unused";
   parameter ram_block_type                = "AUTO";
   parameter lpm_hint                      = "ENABLE_RUNTIME_MOD=NO";
   parameter power_up_uninitialized        = "FALSE";
   parameter read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ";
   parameter width_byteena_a               = 1;
   parameter numwords_b                    = 0;
   parameter numwords_a                    = 0;
   parameter widthad_b                     = 1;
   parameter width_b                       = 1;
   parameter widthad_a                     = 1;
   parameter width_a                       = 1;

   // Port A declarations
   output [35:0] q_a;
   input [35:0]  data_a;
   input [7:0]   address_a;
   input         wren_a;
   input         rden_a;
   // Port B declarations
   output [35:0] q_b;
   input [35:0]  data_b;
   input [7:0]   address_b;
   input         wren_b;
   input         rden_b;
   // Control signals
   input         clock0, clock1;
   input         clocken0, clocken1, clocken2, clocken3;
   input         aclr0, aclr1;
   input         addressstall_a;
   input         addressstall_b;
   // TODO: Implement the correct simulation model

endmodule // altsyncram
