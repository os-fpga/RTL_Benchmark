/****************************************************************************
            Fetch Unit
op
  0  Conditional PC write
  1  UnConditional PC write

****************************************************************************/

module ifetch(clk,resetn,
        en,
        squashn,
        we,
        op,
        load,
        load_data,

        pc_out,
        next_pc,

  boot_iaddr, 
  boot_idata, 
  boot_iwe,

        opcode,
        rs,
        rt,
        rd,
        sa,
        offset,
        instr_index,
        func,
        instr);

parameter PC_WIDTH=30;
parameter I_DATAWIDTH=32;
parameter I_ADDRESSWIDTH=8;
parameter I_SIZE=64;

input [31:0] boot_iaddr;
input [31:0] boot_idata;
input boot_iwe;

input clk;
input resetn;
input en;     // PC increment enable
input we;     // PC write enable
input squashn;// squash fetch
input op;     // determines if conditional or unconditional branch
input load;
input [I_DATAWIDTH-1:0] load_data;
output [I_DATAWIDTH-1:0] pc_out;   // output pc + 1 shifted left 2 bits
output [PC_WIDTH-1:0] next_pc;
output [31:26] opcode;
output [25:21] rs;
output [20:16] rt;
output [15:11] rd;
output [10:6] sa;
output [15:0] offset;
output [25:0] instr_index;
output [5:0] func;
output [I_DATAWIDTH-1:0] instr;


wire [PC_WIDTH-1:0] pc_plus_1;
wire [PC_WIDTH-1:0] pc;
wire ctrl_load;
wire out_of_sync;

assign ctrl_load=(load&~op|op);

lpm_counter	#(.WIDTH(PC_WIDTH))
      pc_register(
        .data(load_data[I_DATAWIDTH-1:2]),
        .clk(clk),
        .clk_en(en|we),
        .cnt_en((~ctrl_load)&~out_of_sync),
        .aclr(~resetn),
        .aset(~resetn),
        .sload(ctrl_load),
        .updown(1'b1),  
        .q(pc)
        );
/*
lpm_counter pc_register(
        .data(load_data[I_DATAWIDTH-1:2]),
        .clock(clk),
        .clk_en(en|we),
        .cnt_en((~ctrl_load)&~out_of_sync),
        .aset(~resetn),
        .sload(ctrl_load),

        // synopsys translate_off
        .updown(), .cin(), .sset(), .sclr(), .aclr(), .aload(), 
        .eq(), .cout(),
        // synopsys translate_on

        .q(pc));
    defparam  pc_register.lpm_width=PC_WIDTH,
              pc_register.lpm_avalue="16777215";   // 0x4000000 divide by 4
*/

/****** Re-synchronize for case:
 * en=0 && we=1  ->  pc_register gets updated but not imem address
 *
 * Solution: stall pc_register and load memory address by changing 
 * incrementer to increment by 0
 *******/
register sync_pcs_up( (we&~en&squashn), clk, resetn,en|we, out_of_sync);
  defparam sync_pcs_up.WIDTH=1;

t_dpram_sclkb	#(.AWIDTH(I_ADDRESSWIDTH), .DWIDTH(I_DATAWIDTH), .DEPTH(256))
    imem(
				.we_a (1'b0),
        .we_b (boot_iwe),
				.clk (clk),
				.addr_a (next_pc[I_ADDRESSWIDTH-1:0]),
				.addr_b (boot_iaddr),
				.data_a (32'h0),
        .data_b (boot_idata),
        .q_a (instr),
				.q_b ()
        );
/*
altsyncram  imem (
    .clock0 (clk),
    .clocken0 (en|~squashn|~resetn),
    .clock1 (clk),                              // changed
    .clocken1 (boot_iwe),                       // changed
    `ifdef TEST_BENCH
    .aclr0(~resetn), 
    `endif
    .address_a (next_pc[I_ADDRESSWIDTH-1:0]),
    .wren_b (boot_iwe), .data_b (boot_idata), .address_b (boot_iaddr), //changed

    // synopsys translate_off
    .wren_a (), .rden_b (), .data_a (), 
    .aclr1 (), .byteena_a (), .byteena_b (),
    .addressstall_a (), .addressstall_b (), .q_b (),
    // synopsys translate_on
    
    .q_a (instr)
    );
    defparam
        imem.intended_device_family = "Stratix",
        imem.width_a = I_DATAWIDTH, 
        imem.widthad_a = I_ADDRESSWIDTH,
        imem.numwords_a = I_SIZE,
        imem.operation_mode = "BIDIR_DUAL_PORT",    // changed
        imem.width_b = I_DATAWIDTH,                 // new
        imem.widthad_b = I_ADDRESSWIDTH,            // new
        imem.numwords_b = I_SIZE,                   // new
        imem.outdata_reg_b = "UNREGISTERED",
        imem.outdata_reg_a = "UNREGISTERED",
        imem.address_reg_b = "CLOCK1",              // new
        imem.wrcontrol_wraddress_reg_b = "CLOCK1",  // new
        imem.width_byteena_a = 1,
        `ifdef TEST_BENCH
        imem.address_aclr_a = "CLEAR0",
        imem.outdata_aclr_a = "CLEAR0",
        imem.init_file = "instr.rif",
        `endif
        `ifdef QUARTUS_SIM
          imem.init_file = "instr.mif",
          imem.ram_block_type = "AUTO",
        `else
          imem.ram_block_type = "MEGARAM",
        `endif
        imem.lpm_type = "altsyncram";
 */       

wire dummy;

assign {dummy,pc_plus_1} = pc + {1'b0,~out_of_sync};
assign pc_out={pc_plus_1,2'b0};

assign next_pc = ctrl_load ? load_data[I_DATAWIDTH-1:2] : pc_plus_1;

assign opcode=instr[31:26];
assign rs=instr[25:21];
assign rt=instr[20:16];
assign rd=instr[15:11];
assign sa=instr[10:6];
assign offset=instr[15:0]; 
assign instr_index=instr[25:0];
assign func=instr[5:0];

endmodule
