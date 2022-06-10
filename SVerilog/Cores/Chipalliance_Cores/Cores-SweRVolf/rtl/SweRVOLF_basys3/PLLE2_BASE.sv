
 
module PLLE2_BASE (

   input wire CLKIN1,
   input wire RST,
   input wire PWRDWN,
   input wire CLKFBIN,
   
   
   output wire LOCKED,
   output wire CLKOUT0,
   output wire CLKOUT1,
   output wire CLKOUT2,
   output wire CLKOUT3,
   output wire CLKOUT4,
   output wire CLKOUT5,
   output wire  CLKFBOUT
   );

   parameter BANDWIDTH          = 0;
   parameter CLKFBOUT_MULT      = 1;
   parameter CLKFBOUT_PHASE     = 0;
   parameter CLKIN1_PERIOD      = 10;
   parameter DIVCLK_DIVIDE      = 1;
   parameter REF_JITTER1        = 0;
   parameter STARTUP_WAIT       = 0;

   parameter CLKOUT0_DIVIDE     = 1;
   parameter CLKOUT0_DUTY_CYCLE = 0.5;
   parameter CLKOUT0_PHASE      = 0;

   parameter CLKOUT1_DIVIDE     = 1;
   parameter CLKOUT1_DUTY_CYCLE = 0.5;
   parameter CLKOUT1_PHASE      = 0;

   parameter CLKOUT2_DIVIDE     = 1;
   parameter CLKOUT2_DUTY_CYCLE = 0.5;
   parameter CLKOUT2_PHASE      = 0;
   
   parameter CLKOUT3_DIVIDE     = 1;
   parameter CLKOUT3_DUTY_CYCLE = 0.5;
   parameter CLKOUT3_PHASE      = 0;

   parameter CLKOUT4_DIVIDE     = 1;   
   parameter CLKOUT4_DUTY_CYCLE = 0.5;
   parameter CLKOUT4_PHASE      = 0;

   parameter CLKOUT5_DIVIDE     = 1;
   parameter CLKOUT5_DUTY_CYCLE = 0.5;
   parameter CLKOUT5_PHASE      = 0;

   //#LOCAL DERIVED PARAMETERS
   parameter VCO_PERIOD = (CLKIN1_PERIOD * DIVCLK_DIVIDE) / CLKFBOUT_MULT;
   parameter CLK0_DELAY = VCO_PERIOD * CLKOUT0_DIVIDE * (CLKOUT0_PHASE/360);
   parameter CLK1_DELAY = VCO_PERIOD * CLKOUT1_DIVIDE * (CLKOUT1_PHASE/360);
   parameter CLK2_DELAY = VCO_PERIOD * CLKOUT2_DIVIDE * (CLKOUT2_PHASE/360);
   parameter CLK3_DELAY = VCO_PERIOD * CLKOUT3_DIVIDE * (CLKOUT3_PHASE/360);
   parameter CLK4_DELAY = VCO_PERIOD * CLKOUT4_DIVIDE * (CLKOUT4_PHASE/360);
   parameter CLK5_DELAY = VCO_PERIOD * CLKOUT5_DIVIDE * (CLKOUT5_PHASE/360);
      
   
   //##############
   //#VCO 
   //##############
   reg 	  vco_clk;
   initial
     begin
	vco_clk = 1'b0;	
     end
   
   always
     #(VCO_PERIOD/2) vco_clk = ~vco_clk;

   //##############
   //#DIVIDERS
   //##############
   wire [3:0] DIVCFG[5:0]; 
   wire [5:0] CLKOUT_DIV;
      
   assign DIVCFG[0] = $clog2(CLKOUT0_DIVIDE);
   assign DIVCFG[1] = $clog2(CLKOUT1_DIVIDE);
   assign DIVCFG[2] = $clog2(CLKOUT2_DIVIDE);
   assign DIVCFG[3] = $clog2(CLKOUT3_DIVIDE);
   assign DIVCFG[4] = $clog2(CLKOUT4_DIVIDE);
   assign DIVCFG[5] = $clog2(CLKOUT5_DIVIDE);


   //ugly POR reset
   reg 	      POR;
   initial
     begin
	POR=1'b1;
	#1
	POR=1'b0;	
     end

   genvar i;
   generate for(i=0; i<6; i=i+1)
     begin : gen_clkdiv
	clock_divider clkdiv (/*AUTOINST*/
			      // Outputs
	//		      .clkout		(CLKOUT_DIV[i]),
			      // Inputs
	//		      .clkin		(vco_clk),
	//		      .divcfg		(DIVCFG[i]),
	//		      .reset		(RST | POR)
			      );		
     end      
   endgenerate

   //##############
   //#PHASE DELAY
   //##############
   reg CLKOUT0;
   reg CLKOUT1;
   reg CLKOUT2;
   reg CLKOUT3;
   reg CLKOUT4;
   reg CLKOUT5;
   
   always @ (CLKOUT_DIV)
     begin	
	CLKOUT0 <= #(CLK0_DELAY) CLKOUT_DIV[0];
	CLKOUT1 <= #(CLK1_DELAY) CLKOUT_DIV[1];
	CLKOUT2 <= #(CLK2_DELAY) CLKOUT_DIV[2];
	CLKOUT3 <= #(CLK3_DELAY) CLKOUT_DIV[3];
	CLKOUT4 <= #(CLK4_DELAY) CLKOUT_DIV[4];
	CLKOUT5 <= #(CLK5_DELAY) CLKOUT_DIV[5];
     end

   //##############
   //#DUMMY DRIVES
   //##############
   assign CLKFBOUT=CLKIN1;
   assign LOCKED=1'b0;
  
   
endmodule // PLLE2_BASE
// Local Variables:



module clock_divider
#(
    parameter DIV_INIT     = 0,
    parameter BYPASS_INIT  = 1
)
(
    input   wire      clk_i,
    input    wire     rstn_i,
    input  wire       test_mode_i,
    input  wire       clk_gate_async_i,
    input  wire [7:0] clk_div_data_i,
    input  wire       clk_div_valid_i,
    output logic       clk_div_ack_o,
    output logic       clk_o
);

   enum                logic [1:0] {IDLE, STOP, WAIT, RELEASE} state, state_next;

   logic               s_clk_out;
   logic               s_clock_enable;
   logic               s_clock_enable_gate;
   logic               s_clk_div_valid;

   logic [7:0]         reg_clk_div;
   logic               s_clk_div_valid_sync;

   logic               s_rstn_sync;

   logic [1:0]         reg_ext_gate_sync;

    assign s_clock_enable_gate =  s_clock_enable & reg_ext_gate_sync;

`ifndef PULP_FPGA_EMUL
    rstgen i_rst_gen
    (
        // PAD FRAME SIGNALS
        .clk_i(clk_i),
        .rst_ni(rstn_i),            //async signal coming from pads

        // TEST MODE
        .test_mode_i(test_mode_i),

        // OUTPUT RESET
        .rst_no(s_rstn_sync),
        .init_no()                 //not used
    );
  `else
  assign s_rstn_sync = rstn_i;
`endif


    //handle the handshake with the soc_ctrl. Interface is now async
    pulp_sync_wedge i_edge_prop
    (
        .clk_i(clk_i),
        .rstn_i(s_rstn_sync),
        .en_i(1'b1),
        .serial_i(clk_div_valid_i),
        .serial_o(clk_div_ack_o),
        .r_edge_o(s_clk_div_valid_sync),
        .f_edge_o()
    );

    clock_divider_counter
    #(
        .BYPASS_INIT(BYPASS_INIT),
        .DIV_INIT(DIV_INIT)
    )
    i_clkdiv_cnt
    (
        .clk(clk_i),
        .rstn(s_rstn_sync),
        .test_mode(test_mode_i),
        .clk_div(reg_clk_div),
        .clk_div_valid(s_clk_div_valid),
        .clk_out(s_clk_out)
    );

    pulp_clock_gating i_clk_gate
    (
        .clk_i(s_clk_out),
        .en_i(s_clock_enable_gate),
        .test_en_i(test_mode_i),
        .clk_o(clk_o)
    );

    always_comb
    begin
        case(state)
        IDLE:
        begin
            s_clock_enable   = 1'b1;
            s_clk_div_valid  = 1'b0;
            if (s_clk_div_valid_sync)
                state_next = STOP;
            else
                state_next = IDLE;
        end

        STOP:
        begin
            s_clock_enable   = 1'b0;
            s_clk_div_valid  = 1'b1;
            state_next = WAIT;
        end

        WAIT:
        begin
            s_clock_enable   = 1'b0;
            s_clk_div_valid  = 1'b0;
            state_next = RELEASE;
        end

        RELEASE:
        begin
            s_clock_enable   = 1'b0;
            s_clk_div_valid  = 1'b0;
            state_next = IDLE;
        end
        endcase
    end

    always_ff @(posedge clk_i or negedge s_rstn_sync)
    begin
        if (!s_rstn_sync)
            state <= IDLE;
        else
            state <= state_next;
    end

    //sample the data when valid has been sync and there is a rise edge
    always_ff @(posedge clk_i or negedge s_rstn_sync)
    begin
        if (!s_rstn_sync)
            reg_clk_div <= '0;
        else if (s_clk_div_valid_sync)
                  reg_clk_div <= clk_div_data_i;
    end

    //sample the data when valid has been sync and there is a rise edge
    always_ff @(posedge clk_i or negedge s_rstn_sync)
    begin
        if (!s_rstn_sync)
            reg_ext_gate_sync <= 2'b00;
        else
            reg_ext_gate_sync <= {clk_gate_async_i, reg_ext_gate_sync[1]};
    end

endmodule


module rstgen (
    input  wire clk_i,
    input  wire rst_ni,
    input  wire test_mode_i,
    output logic rst_no,
    output logic init_no
);

    rstgen_bypass i_rstgen_bypass (
        .clk_i            ( clk_i       ),
        .rst_ni           ( rst_ni      ),
        .rst_test_mode_ni ( rst_ni      ),
        .test_mode_i      ( test_mode_i ),
        .rst_no           ( rst_no      ),
        .init_no          ( init_no     )
    );

endmodule

module rstgen_bypass #(
    parameter NumRegs = 4
) (
    input  wire clk_i,
    input  wire rst_ni,
    input  wire rst_test_mode_ni,
    input  wire test_mode_i,
    output logic rst_no,
    output logic init_no
);

    // internal reset
    logic rst_n;

    logic [NumRegs-1:0] synch_regs_q;
    // bypass mode
    always_comb begin
        if (test_mode_i == 1'b0) begin
            rst_n   = rst_ni;
            rst_no  = synch_regs_q[NumRegs-1];
            init_no = synch_regs_q[NumRegs-1];
        end else begin
            rst_n   = rst_test_mode_ni;
            rst_no  = rst_test_mode_ni;
            init_no = 1'b1;
        end
    end

    always @(posedge clk_i or negedge rst_n) begin
        if (~rst_n) begin
            synch_regs_q <= 0;
        end else begin
            synch_regs_q <= {synch_regs_q[NumRegs-2:0], 1'b1};
        end
    end

    initial begin : p_assertions
        if (NumRegs < 1) $fatal(1, "At least one register is required.");
    end
endmodule


module pulp_sync_wedge #(
    parameter int unsigned STAGES = 2
) (
    input  wire clk_i,
    input  wire rstn_i,
    input  wire en_i,
    input  wire serial_i,
    output logic r_edge_o,
    output logic f_edge_o,
    output logic serial_o
);
    logic clk;
    logic serial, serial_q;

    assign serial_o =  serial_q;
    assign f_edge_o = ~serial &  serial_q;
    assign r_edge_o =  serial & ~serial_q;

    pulp_sync #(
        .STAGES(STAGES)
    ) i_pulp_sync (
        .clk_i,
        .rstn_i,
        .serial_i,
        .serial_o ( serial )
    );

    pulp_clock_gating i_pulp_clock_gating (
        .clk_i,
        .en_i,
        .test_en_i ( 1'b0    ),
        .clk_o     ( clk )
    );

    always_ff @(posedge clk, negedge rstn_i) begin
        if (!rstn_i) begin
            serial_q <= 1'b0;
        end else begin
            serial_q <= serial;
        end
    end

endmodule

module pulp_sync
  #(
    parameter STAGES = 2
    )
   (
    input  wire clk_i,
    input  wire rstn_i,
    input  wire serial_i,
    output logic serial_o
    );
   
   logic [STAGES-1:0] r_reg;
   
   always_ff @(posedge clk_i, negedge rstn_i)
     begin
	if(!rstn_i)
          r_reg <= 'h0;
	else
          r_reg <= {r_reg[STAGES-2:0], serial_i};
     end
   
   assign serial_o   =  r_reg[STAGES-1];
   
endmodule

module pulp_clock_gating
  (
   input  wire clk_i,
   input  wire en_i,
   input  wire test_en_i,
   output logic clk_o
   );

   assign clk_o = clk_i;
   
endmodule

module clock_divider_counter
#(
    parameter BYPASS_INIT = 1,
    parameter DIV_INIT    = 'hFF
)
(
    input  wire       clk,
    input  wire       rstn,
    input  wire       test_mode,
    input  wire [7:0] clk_div,
    input  wire       clk_div_valid,
    output logic       clk_out
);

    logic [7:0]         counter;
    logic [7:0]         counter_next;
    logic [7:0]         clk_cnt;
    logic               en1;
    logic               en2;

    logic               is_odd;

    logic               div1;
    logic               div2;
    logic               div2_neg_sync;

    logic [7:0]         clk_cnt_odd;
    logic [7:0]         clk_cnt_odd_incr;
    logic [7:0]         clk_cnt_even;
    logic [7:0]         clk_cnt_en2;

    logic               bypass;

    logic               clk_out_gen;
    logic               clk_div_valid_reg;

    logic               clk_inv_test;
    logic               clk_inv;

    //        assign clk_cnt_odd_incr = clk_div + 1;
    //        assign clk_cnt_odd  = {1'b0,clk_cnt_odd_incr[7:1]}; //if odd divider than clk_cnt = (clk_div+1)/2
    assign clk_cnt_odd  = clk_div - 8'h1; //if odd divider than clk_cnt = clk_div - 1
    assign clk_cnt_even = (clk_div == 8'h2) ? 8'h0 : ({1'b0,clk_div[7:1]} - 8'h1);   //if even divider than clk_cnt = clk_div/2
    assign clk_cnt_en2  = {1'b0,clk_cnt[7:1]} + 8'h1;

    always_comb
    begin
        if (counter == 'h0)
            en1 = 1'b1;
        else
            en1 = 1'b0;

        if (clk_div_valid)
            counter_next = 'h0;
        else if (counter == clk_cnt)
                counter_next = 'h0;
             else
                counter_next = counter + 1;

        if (clk_div_valid)
            en2 = 1'b0;
        else if (counter == clk_cnt_en2)
                en2 = 1'b1;
             else
                en2 = 1'b0;
    end

   always_ff @(posedge clk, negedge rstn)
   begin
        if (~rstn)
        begin
             counter            <=  'h0;
             div1               <= 1'b0;
             bypass             <= BYPASS_INIT;
             clk_cnt            <= DIV_INIT;
             is_odd             <= 1'b0;
             clk_div_valid_reg  <= 1'b0;
        end
        else
        begin
              if (!bypass)
                  counter <= counter_next;

              clk_div_valid_reg <= clk_div_valid;
              if (clk_div_valid)
              begin
                if ((clk_div == 8'h0) || (clk_div == 8'h1))
                  begin
                      bypass <= 1'b1;
                      clk_cnt <= 'h0;
                      is_odd  <= 1'b0;
                  end
                else
                  begin
                      bypass <= 1'b0;
                      if (clk_div[0])
                        begin
                          is_odd  <= 1'b1;
                          clk_cnt <= clk_cnt_odd;
                        end
                      else
                        begin
                          is_odd  <= 1'b0;
                          clk_cnt <= clk_cnt_even;
                        end
                  end
                div1 <= 1'b0;
              end
              else
              begin
                if (en1 && !bypass)
                  div1 <= ~div1;
              end
        end
    end

    pulp_clock_inverter clk_inv_i
    (
        .clk_i(clk),
        .clk_o(clk_inv)
    );

`ifndef PULP_FPGA_EMUL
 `ifdef PULP_DFT
   pulp_clock_mux2 clk_muxinv_i
     (
      .clk0_i(clk_inv),
      .clk1_i(clk),
      .clk_sel_i(test_mode),
      .clk_o(clk_inv_test)
      );
 `else
   assign clk_inv_test = clk_inv;
 `endif
`else
   assign clk_inv_test = clk_inv;
`endif

    always_ff @(posedge clk_inv_test or negedge rstn)
    begin
        if (!rstn)
        begin
            div2    <= 1'b0;
        end
        else
        begin
            if (clk_div_valid_reg)
                div2 <= 1'b0;
            else if (en2 && is_odd && !bypass)
                    div2 <= ~div2;
        end
    end // always_ff @ (posedge clk_inv_test or negedge rstn)

    pulp_clock_xor2 clock_xor_i
    (
        .clk_o(clk_out_gen),
        .clk0_i(div1),
        .clk1_i(div2)
    );

    pulp_clock_mux2 clk_mux_i
    (
        .clk0_i(clk_out_gen),
        .clk1_i(clk),
        .clk_sel_i(bypass || test_mode),
        .clk_o(clk_out)
    );

endmodule
module pulp_clock_inverter
  (
   input  wire clk_i,
   output logic clk_o
   );
   
   assign clk_o = ~clk_i;
   
endmodule

module pulp_clock_xor2
  (
   input  wire clk0_i,
   input  wire clk1_i,
   output logic clk_o
   );
   
   assign clk_o = clk0_i ^ clk1_i;
   
endmodule

module pulp_clock_mux2
  (
   input  wire clk0_i,
   input  wire clk1_i,
   input  wire clk_sel_i,
   output logic clk_o
   );
   
  BUFGMUX bufgmux_i (
    .S(clk_sel_i),
    .I0(clk0_i),
    .I1(clk1_i),
    .O(clk_o)
  );
   
endmodule

module BUFGMUX (O, I0, I1, S);

    parameter CLK_SEL_TYPE = "SYNC";
    output wire O;
    input wire I0, I1, S;


    // SIGASI: body removed, I/O is enough

endmodule