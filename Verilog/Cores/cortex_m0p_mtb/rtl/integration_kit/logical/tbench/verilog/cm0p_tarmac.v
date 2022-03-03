//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2011-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-09-12 16:06:58 +0100 (Wed, 12 Sep 2012) $
//   Revision   : $Revision: 222412 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_tarmac
  (input wire        en_i,
   input wire        echo_i,
   input wire [31:0] id_i,
   input wire        use_time_i,
   input wire [31:0] tube_i,
   input wire        hclk,
   input wire [ 3:0] apsr_i,
   input wire        tbit_i,
   input wire [ 5:0] ipsr_i,
   input wire        spsel_i,
   input wire        npriv_i,
   input wire        primask_i,
   input wire        cc_pass_i,
   input wire        ppb_trans_i,
   input wire [31:0] scs_rdata_i,
   input wire        ahb_trans_i,
   input wire [15:0] op_i,
   input wire        op_s_i,
   input wire [15:0] iq_i,
   input wire        iq_s_i,
   input wire        msp_en_i,
   input wire        psp_en_i,
   input wire [31:0] wr_data_i,
   input wire [29:0] wr_data_sp_i,
   input wire [ 3:0] wr_addr_en_i,
   input wire [ 3:0] state_i,
   input wire [30:0] iaex_i,
   input wire        int_ready_i,
   input wire        preempt_i,
   input wire        hresetn_i,
   input wire [ 1:0] htrans_i,
   input wire        hwrite_i,
   input wire [31:0] haddr_i,
   input wire [ 3:0] hprot_i,
   input wire [31:0] hrdata_i,
   input wire [31:0] hwdata_i,
   input wire [ 2:0] hsize_i,
   input wire        hready_i,
   input wire        hresp_i,
   input wire        irq_ack_i,
   input wire        rfe_ack_i,
   input wire [ 5:0] int_pend_num_i,
   input wire        atomic_i,
   input wire        lockup_i,
   input wire        fault_i,
   input wire        halted_i,
   input wire        hardfault_i,
   input wire        iotrans_i,
   input wire        iowrite_i,
   input wire [ 1:0] iosize_i,
   input wire [31:0] ioaddr_i,
   input wire [31:0] iordata_i,
   input wire [31:0] iowdata_i,
   input wire [ 1:0] slvtrans_i,
   input wire [ 1:0] slvsize_i,
   input wire [31:0] slvaddr_i,
   input wire        slvready_i,
   input wire [31:0] slvwdata_i,
   input wire [31:0] slvrdata_i,
   input wire        slvwrite_i,
   input wire        slvresp_i );

   // -------------------------------------------------------------------------
   // File descriptor control
   // -------------------------------------------------------------------------

   localparam [31:0] fd_stdout = 32'h80000001;

   reg [8*20-1:0]    logname = {80*20{1'b0}};
   integer           fhandle = 0;

   wire [31:0]       fd [1:0];

   assign fd[0] = (en_i === 1'b1) ? fhandle : 32'b0;
   assign fd[1] = ((en_i & echo_i) === 1'b1) ? fd_stdout : 32'b0;

   initial
     begin
       `ifndef ARM_CM0P_DSM

        if((^{en_i, id_i}) === 1'bX) begin
           $write("Tarmac: waiting for control signals...\n");
           wait((^{en_i, id_i}) !== 1'bX);
           $write("Tarmac: ready...\n");
        end

        $swrite(logname,"tarmac%0x.log",id_i);
        fhandle = $fopen(logname,"w");

        if(!fhandle) $write("Tarmac: Warning, failed to open '%0s'\n", logname);
        else begin
           $write("Tarmac: Writing log data to '%0s'\n", logname);
           $fwrite(fhandle,"# CORTEXM0PLUS TARMAC %x\n# %m\n", id_i);
        end

      `else

        if((^{en_i, id_i}) === 1'bX) begin
           wait((^{en_i, id_i}) !== 1'bX);
        end

        if(en_i === 1'b1) begin
           $swrite(logname,"tarmac%0x.log",id_i);
           fhandle = $fopen(logname,"w");

           if(!fhandle)
             $write("Tarmac: Warning, failed to open '%0s'\n", logname);
           else
             $fwrite(fhandle,"# CORTEXM0PLUS TARMAC %x\n", id_i);
        end

      `endif // ARM_CM0P_DSM

     end

   // -------------------------------------------------------------------------
   // Definition of constant values for various states
   // -------------------------------------------------------------------------

   localparam [3:0] st_exe = 4'b0000;  // First / single-cycle execute
   localparam [3:0] st_t32 = 4'b1001;  // 32-bit opcode second cycle

   // -------------------------------------------------------------------------
   // Trace processor execution
   // -------------------------------------------------------------------------

   localparam tube_width = 40;

`include "cm0p_ualdis.v"

   wire [1:0] control = {spsel_i, npriv_i};
   wire [31:0] psr    = {apsr_i[3:0], 3'b0, tbit_i, 18'b0, ipsr_i[5:0]};

   genvar i;

   generate
      for(i=0;i<2;i=i+1) begin : gen_logger
         reg [31:0] haddr_q;
         reg [ 1:0] htrans_q;
         reg        ppb_trans_q;
         reg [ 2:0] hsize_q;
         reg        hwrite_q;
         reg [ 3:0] hprot_q;
         reg [31:0] psr_q;
         reg [ 1:0] control_q;
         reg        primask_q;
         reg        hresetn_q;
         reg        int_ready_q;
         reg [ 5:0] int_pend_num_q;
         reg        atomic_q;
         reg        lockup_q;
         reg        halted_q;
         reg        fault_q;
         reg [30:0] iaex_q;
         reg [31:0] slvaddr_q;
         reg [ 1:0] slvtrans_q;
         reg [ 1:0] slvsize_q;
         reg        slvwrite_q;

         reg [tube_width*8-1:0] tube_msg   = {tube_width{8'b0}};
         reg [32*8-1:0]         tstamp     = {32{8'b0}};
         reg [63:0]             hclk_count = 64'h0;

         always @(posedge hclk)
           begin

              hclk_count <= hclk_count + 1'b1;

              if(fd[i] && slvready_i && (slvtrans_i || slvtrans_q) ) begin
                 slvaddr_q <= slvaddr_i;
                 slvtrans_q <= slvtrans_i;
                 slvsize_q <= slvsize_i;
                 slvwrite_q <= slvwrite_i;

                 if(use_time_i)
                   $swrite(tstamp,"%t", $time);
                 else
                   $swrite(tstamp,"%d hclk", hclk_count);

                 if(slvtrans_q[1] & ~slvwrite_q)
                   $fwrite(fd[i],"%0s MR%d%sS %x %x\n",tstamp,
                           3'h1<<slvsize_q,slvresp_i?"E":"_",slvaddr_q,slvrdata_i);
                 else if(slvtrans_q[1] & slvwrite_q)
                   $fwrite(fd[i],"%0s MW%d%sS %x %x\n",tstamp,
                           3'h1<<slvsize_q,slvresp_i?"E":"_",slvaddr_q,slvwdata_i);
              end

              if(fd[i] && hready_i) begin
                 ppb_trans_q <= ppb_trans_i & ahb_trans_i;
                 haddr_q     <= haddr_i;
                 htrans_q    <= htrans_i;
                 hsize_q     <= hsize_i;
                 hwrite_q    <= hwrite_i;
                 hprot_q     <= hprot_i;
                 hresetn_q   <= hresetn_i;
                 psr_q       <= psr;
                 control_q   <= control;
                 primask_q   <= primask_i;
                 int_ready_q <= int_ready_i;
                 int_pend_num_q <= int_pend_num_i;
                 atomic_q    <= atomic_i;
                 lockup_q    <= lockup_i;
                 halted_q    <= halted_i;
                 fault_q     <= fault_i;
                 iaex_q      <= iaex_i;

                 // -----------------------------------------------------------
                 // Generate time stamp from HCLK count or simulation time
                 // -----------------------------------------------------------

                 if(use_time_i)
                   $swrite(tstamp,"%t", $time);
                 else
                   $swrite(tstamp,"%d hclk", hclk_count);

                 // -----------------------------------------------------------
                 // Special register trace
                 // -----------------------------------------------------------

                 if(control !== control_q)
                   $fwrite(fd[i],"%0s R CONTROL %x\n",tstamp,{30'b0,control});

                 if(primask_i !== primask_q)
                   $fwrite(fd[i],"%0s R PRIMASK %x\n",tstamp,{31'b0,primask_i});

                 if(psr !== psr_q)
                   $fwrite(fd[i],"%0s R PSR %x\n",tstamp,psr);

                 // -----------------------------------------------------------
                 // Memory trace
                 // -----------------------------------------------------------

                 if(hprot_q[0]) begin
                    if(htrans_q[1] & ~hwrite_q)
                      $fwrite(fd[i],"%0s MR%d%sD %x %x\n",tstamp,
                              3'h1<<hsize_q,hresp_i?"E":"_",haddr_q,hrdata_i);
                    else if(htrans_q[1] & hwrite_q)
                      $fwrite(fd[i],"%0s MW%d%sD %x %x\n",tstamp,
                              3'h1<<hsize_q,hresp_i?"E":"_",haddr_q,hwdata_i);
                 end

                 if(ppb_trans_q) begin
                   if(~hwrite_q)
                     $fwrite(fd[i],"%0s MR%d_D %x %x\n",tstamp,
                             3'h1<<hsize_q,haddr_q,scs_rdata_i);
                   else
                     $fwrite(fd[i],"%0s MW%d_D %x %x\n",tstamp,
                             3'h1<<hsize_q,haddr_q,hwdata_i);
                 end

                 if(~hprot_q[0]) begin
                    if(htrans_q[1])
                      $fwrite(fd[i],"%0s MR%d%sI %x %x\n",tstamp,
                              3'h1<<hsize_q,hresp_i?"E":"_",haddr_q,hrdata_i);
                 end

                 // -----------------------------------------------------------
                 // Tube trace
                 // -----------------------------------------------------------

                 if((tube_i != 32'h0) && htrans_q[1] && hwrite_q && (tube_i == haddr_q))
                   begin
                      $fwrite(fd[i],"%0s E TUBE %x %02x ; \"%s\" ... %0s\n",
                              tstamp, haddr_q, hwdata_i[7:0], tube_msg,
                              (hwdata_i[7:0] == 8'h0A) ? "EOL" :
                              (hwdata_i[7:0] == 8'h04) ? "EOF" :
                              (hwdata_i[7:0] <= 8'h1F) ? "???" :
                              {"\"",hwdata_i[7:0],"\""});
                      if(hwdata_i[7:0] < 8'h20) tube_msg = {tube_width{8'b0}};
                      else tube_msg = {tube_msg[(tube_width-1)*8-1:0], hwdata_i[7:0]};
                   end

                 // -----------------------------------------------------------
                 // Instruction trace
                 // -----------------------------------------------------------

                 if(state_i == st_exe) begin
                    if(op_s_i)
                      $fwrite(fd[i],"%0s E SPECIAL %x %x ; %0s\n",tstamp,
                              {iaex_i,1'b0},op_i,
                              op_i[12] ? "HALTREQ" : op_i[13] ? "IDLE" :
                              op_i[14] ? "FAULT" : op_i[15] ? "BREAKPOINT" :
                              "TSTATE" );
                    else if(({op_i[15:12],&op_i[11:9]} == 5'b1101_0) & ~cc_pass_i)
                      $fwrite(fd[i],"%0s IS %x %x        %0s\n",tstamp,
                              {iaex_i,1'b0},op_i, ual_dec_t16(op_i,{iaex_i,1'b0}));
                    else if (op_i[15:11] != 5'b11110)
                      $fwrite(fd[i],"%0s IT %x %x        %0s\n",tstamp,
                              {iaex_i,1'b0},op_i, ual_dec_t16(op_i,{iaex_i,1'b0}));
                 end else if(state_i == st_t32) begin
                    if(op_s_i | iq_s_i)
                      $fwrite(fd[i],"%0s E SPECIAL %x %x ; %0s\n",tstamp,{iaex_i,1'b0},
                              {op_i,iq_i}, iq_i[14] ? "FAULT" : "BREAKPOINT" );
                    else
                      $fwrite(fd[i],"%0s IT %x %x%x    %0s\n",tstamp,
                              {iaex_i,1'b0},op_i,iq_i, ual_dec_t32({op_i,iq_i},{iaex_i,1'b0}));
                 end

                 // -----------------------------------------------------------
                 // Event trace
                 // -----------------------------------------------------------

                 if(hresetn_i !== hresetn_q)
                   $fwrite(fd[i],"%0s E HRESETn %x\n", tstamp, hresetn_i);

                 if(fault_i && (fault_i !== fault_q))
                   $fwrite(fd[i],"%0s E FAULTING\n", tstamp);

                 if(hardfault_i)
                   $fwrite(fd[i],"%0s E HARDFAULT_REQ\n", tstamp);

                 if(lockup_i !== lockup_q)
                   $fwrite(fd[i],"%0s E LOCKUP %x\n", tstamp, lockup_i);

                 if(halted_i !== halted_q)
                   $fwrite(fd[i],"%0s E HALTED %x\n", tstamp, halted_i);

                 if(irq_ack_i)
                   $fwrite(fd[i],"%0s E INT_ENTRY %x\n", tstamp, ipsr_i);

                 if((int_ready_i !== int_ready_q) ||
                    (int_ready_i && (int_pend_num_i !== int_pend_num_q)))
                   begin
                      if(int_ready_i)
                        $fwrite(fd[i],"%0s E INT_READY %x\n", tstamp, int_pend_num_i);
                      else
                        $fwrite(fd[i],"%0s E INT_READY %x\n", tstamp, int_ready_i);
                   end

                 if(preempt_i)
                   $fwrite(fd[i],"%0s E INT_PREEMPT\n", tstamp);

                 if(rfe_ack_i)
                   $fwrite(fd[i],"%0s E INT_EXIT %x %x\n", tstamp, ipsr_i, {iaex_i,1'b1});

                 if(atomic_i !== atomic_q)
                   $fwrite(fd[i],"%0s E ATOMIC %x\n", tstamp, atomic_i);

                 // -----------------------------------------------------------
                 // Memory trace for IO port
                 // -----------------------------------------------------------

                 if(iotrans_i) begin
                    if(~iowrite_i)
                      $fwrite(fd[i],"%0s MR%d_P %x %x\n",tstamp,
                              3'h1<<iosize_i,ioaddr_i,iordata_i);
                    else if(iowrite_i)
                      $fwrite(fd[i],"%0s MW%d_P %x %x\n",tstamp,
                              3'h1<<iosize_i,ioaddr_i,iowdata_i);
                 end

                 // -----------------------------------------------------------
                 // General purpose register trace
                 // -----------------------------------------------------------

                 if((wr_addr_en_i != 4'hF) && (wr_addr_en_i != 4'd13))
                   $fwrite(fd[i],"%0s R r%0d %x\n",tstamp,wr_addr_en_i,wr_data_i);
                 else if(msp_en_i)
                   $fwrite(fd[i],"%0s R MSP %x\n",tstamp,{wr_data_sp_i,2'b0});
                 else if(psp_en_i)
                   $fwrite(fd[i],"%0s R PSP %x\n",tstamp,{wr_data_sp_i,2'b0});

                 if(halted_i && (iaex_i !== iaex_q))
                   $fwrite(fd[i],"%0s R PC %x\n", tstamp, {iaex_i,1'b0});

              end
           end
      end
   endgenerate

   // -------------------------------------------------------------------------

   initial
     begin
        wait((^{en_i, id_i}) !== 1'bX);

        if(en_i === 1'b1)
          display_ualdis_banner;

`ifndef ARM_CM0P_DSM
        $write("---------------------------------------------------------\n");
        $write("Tarmac Log Generator for ARM Cortex-M0+\n");
        $write("(C) COPYRIGHT 2010-2012 ARM Limited - All Rights Reserved\n");
        $write("Instance %x @ %m\n", id_i);
        $write("---------------------------------------------------------\n");
`endif // ARM_CM0P_DSM
     end

endmodule // cm0p_tarmac
