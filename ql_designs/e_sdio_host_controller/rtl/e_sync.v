///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_sync
// File Name:    e_sync.v
// 
// Version 1.0   April  1, 2006  -Original
// Version 1.1   Feb.   7, 2007  -Added 16 bit support
// Version 1.2   May.   14,2007  -Fixed cmd to cmd delay
//                               -SDIO power on switch clock line level
//                               -Used latched signal for datline0
//                               -Optimized to use fifo controllers
//                               -Modified to use one RAMBLOCK instead of two
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module e_sync(
										rst                    	,
										sys_clk                	,
										sd_clk                 	,
										sd_bclkx2              	,
										send_cmd               	,
										cmd_active             	,
										cmd_done	             	,
										cmd_timeout_error      	,				
										cmd_crc_error          	,		
										resp_end_error         	,
										cmd_index_error        	,
										intr_gap_en             ,
										continue_req            ,
										stop_at_gap_req         ,
                              block_cnt_0             ,
										dat_active             	,
										dat_req                 ,
										dec_block_cnt           ,
										dat_timeout_error      	,
										dat_crc_error          	,
										dat_end_error          	,
										sd_clock_en            	,
										int_clock_en           	,
										load_clock_div         	,
                              sdclk_disable           ,
										send_cmd_sync2         	,
										cmd_active_sync2				,
										cmd_done_p	       	,
										cmd_timeout_error_p	,
										cmd_crc_error_p    	,		
										resp_end_error_p   	,		
										cmd_index_error_p  	,
										intr_gap_en_sync2             ,
										continue_req_sync2            ,
										stop_at_gap_req_sync2         ,
                              block_cnt_0_sync2       ,
										dat_active_sync2       	,
										dec_block_cnt_p			,
										dat_req_sync2           ,
										dat_timeout_error_p	, 
										dat_crc_error_p    	,
										dat_end_error_p    	,
										sd_clock_en_sync2      	,
										int_clock_en_sync2     	,
										load_clock_div_p      ,
                              sdclk_disable_sync2
									);

   input                  rst                     ;       
   input                  sys_clk                 ;       
   input                  sd_clk                  ;       
   input                  sd_bclkx2               ;       
   input                  send_cmd                ;       
   input                  cmd_active              ;       
   input                  cmd_done                ;       
   input                  cmd_timeout_error       ;       
   input                  cmd_crc_error           ;       
   input                  resp_end_error          ;       
   input                  cmd_index_error         ;       
   input                  intr_gap_en             ;
   input                  continue_req            ;
   input                  stop_at_gap_req         ;
   input                  block_cnt_0             ;       
   input                  dat_active              ;  
   input                  dat_req                 ;     
   input                  dec_block_cnt           ;
   input                  dat_timeout_error       ;       
   input                  dat_crc_error           ;       
   input                  dat_end_error           ;       
   input                  sd_clock_en             ;       
   input                  int_clock_en            ;       
   input                  load_clock_div          ;       
   input                  sdclk_disable           ;
   output                 send_cmd_sync2          ; //sys_clk -> sd_clk      
   output                 cmd_active_sync2        ; //sd_clk -> sys_clk   
   output                 cmd_done_p              ; //sd_clk -> sys_clk         
   output                 cmd_timeout_error_p  ;    //sd_clk -> sys_clk      
   output                 cmd_crc_error_p      ;    //sd_clk -> sys_clk      
   output                 resp_end_error_p     ;    //sd_clk -> sys_clk      
   output                 cmd_index_error_p    ;    //sd_clk -> sys_clk      
   output                 intr_gap_en_sync2          ; //sys_clk -> sd_clk
   output                 continue_req_sync2         ; //sys_clk -> sd_clk
   output                 stop_at_gap_req_sync2      ; //sys_clk -> sd_clk
   output                 block_cnt_0_sync2          ; //sys_clk -> sd_clk      
   output                 dat_active_sync2        ; //sd_clk -> sys_clk      
   output                 dec_block_cnt_p         ; //sd_clk -> sys_clk      
   output                 dat_req_sync2           ; //sd_clk -> sys_clk
   output                 dat_timeout_error_p  ;    //sd_clk -> sys_clk      
   output                 dat_crc_error_p      ;    //sd_clk -> sys_clk      
   output                 dat_end_error_p      ;    //sd_clk -> sys_clk      
   output                 sd_clock_en_sync2       ; //sys_clk -> sd_bclkx2
   output                 int_clock_en_sync2      ; //sys_clk -> sd_bclkx2      
   output                 load_clock_div_p     ;    //sys_clk -> sd_bclkx2 
   output                 sdclk_disable_sync2  ;    //sd_clk -> sd_bclkx2

   reg                 send_cmd_sync2          ;       
   reg                 cmd_active_sync2           ;    
   reg                 cmd_done_sync2           ;          
   reg                 cmd_timeout_error_sync2  ;          
   reg                 cmd_crc_error_sync2      ;          
   reg                 resp_end_error_sync2     ;          
   reg                 cmd_index_error_sync2    ;          
   reg                 intr_gap_en_sync2           ;
   reg                 continue_req_sync2          ;
   reg                 stop_at_gap_req_sync2       ;
   reg                 block_cnt_0_sync2          ;       
   reg                 dat_active_sync2        ;       
   reg                 dat_req_sync2           ;
   reg                 dec_block_cnt_sync2     ;
   reg                 dat_timeout_error_sync2  ;          
   reg                 dat_crc_error_sync2      ;          
   reg                 dat_end_error_sync2      ;          
   reg                 sd_clock_en_sync2       ;       
   reg                 int_clock_en_sync2      ;       
   reg                 load_clock_div_sync2    ;  
   reg                 sdclk_disable_sync2  ;
   reg                 sdclk_disable_synca  ;
	
   reg                 send_cmd_sync1          ;       
   reg                 cmd_active_sync1           ;    
   reg                 cmd_done_sync1           ;          
   reg                 cmd_timeout_error_sync1  ;          
   reg                 cmd_crc_error_sync1      ;          
   reg                 resp_end_error_sync1     ;          
   reg                 cmd_index_error_sync1    ;          
   reg                 intr_gap_en_sync1           ;
   reg                 continue_req_sync1          ;
   reg                 stop_at_gap_req_sync1       ;
   reg                 block_cnt_0_sync1          ;       
   reg                 dat_active_sync1        ;       
   reg                 dat_req_sync1           ;
   reg                 dec_block_cnt_sync1     ;
   reg                 dat_timeout_error_sync1  ;          
   reg                 dat_crc_error_sync1      ;          
   reg                 dat_end_error_sync1      ;          
   reg                 sd_clock_en_sync1       ;       
   reg                 int_clock_en_sync1      ;       
   reg                 load_clock_div_sync1    ;            
   reg                 sdclk_disable_sync1  ;
   wire				   rst_disable ;	
	
	assign	cmd_timeout_error_p	= cmd_timeout_error_sync1 ^ cmd_timeout_error_sync2;
	assign	cmd_done_p					= cmd_done_sync1 ^ cmd_done_sync2;
	assign	cmd_index_error_p		= cmd_index_error_sync1 ^ cmd_index_error_sync2;
	assign	cmd_crc_error_p			= cmd_crc_error_sync1 ^ cmd_crc_error_sync2;
	assign	dat_timeout_error_p	= dat_timeout_error_sync1 ^ dat_timeout_error_sync2;
	assign	dat_crc_error_p			= dat_crc_error_sync1 ^ dat_crc_error_sync2;
	assign	dat_end_error_p			= dat_end_error_sync1 ^ dat_end_error_sync2;
	assign	resp_end_error_p		= resp_end_error_sync1 ^ resp_end_error_sync2;
    assign  load_clock_div_p    =  load_clock_div_sync1 ^ load_clock_div_sync2;
    assign  dec_block_cnt_p    =  dec_block_cnt_sync1 ^ dec_block_cnt_sync2;
	assign  rst_disable = rst | (sdclk_disable_synca & ~sdclk_disable_sync1);
	
	always@( posedge rst or posedge sys_clk )
	begin
      if(rst)
      begin
			cmd_active_sync1            <= 1'b0;
         cmd_done_sync1              <= 1'b0;
         cmd_timeout_error_sync1     <= 1'b0;
         cmd_crc_error_sync1         <= 1'b0;
         resp_end_error_sync1        <= 1'b0;
         cmd_index_error_sync1       <= 1'b0;
         dat_active_sync1            <= 1'b0;
		 dat_req_sync1               <= 1'b0;
		 dec_block_cnt_sync1         <= 1'b0;
         dat_timeout_error_sync1     <= 1'b0;
         dat_crc_error_sync1         <= 1'b0;
         dat_end_error_sync1         <= 1'b0;
         cmd_active_sync2            <= 1'b0;
         cmd_done_sync2              <= 1'b0;
         cmd_timeout_error_sync2     <= 1'b0;
         cmd_crc_error_sync2         <= 1'b0;
         resp_end_error_sync2        <= 1'b0;
         cmd_index_error_sync2       <= 1'b0;
         dat_active_sync2            <= 1'b0;
		 dat_req_sync2               <= 1'b0;
		 dec_block_cnt_sync2         <= 1'b0;
         dat_timeout_error_sync2     <= 1'b0;
         dat_crc_error_sync2         <= 1'b0;
         dat_end_error_sync2         <= 1'b0;
      end
      else
      begin
			cmd_active_sync1            <= cmd_active             ;
			cmd_done_sync1            	 <= cmd_done              ;
			cmd_timeout_error_sync1     <= cmd_timeout_error      ;
			cmd_crc_error_sync1         <= cmd_crc_error          ;
			resp_end_error_sync1        <= resp_end_error         ;
			cmd_index_error_sync1       <= cmd_index_error        ;
			dat_active_sync1            <= dat_active             ;
			dat_req_sync1               <= dat_req                ;
		    dec_block_cnt_sync1         <= dec_block_cnt          ;
			dat_timeout_error_sync1     <= dat_timeout_error      ;
			dat_crc_error_sync1         <= dat_crc_error          ;
			dat_end_error_sync1         <= dat_end_error          ;
			cmd_active_sync2            <= cmd_active_sync1       ;
			cmd_done_sync2            	 <= cmd_done_sync1        ;
			cmd_timeout_error_sync2     <= cmd_timeout_error_sync1;
			cmd_crc_error_sync2         <= cmd_crc_error_sync1    ;
			resp_end_error_sync2        <= resp_end_error_sync1   ;
			cmd_index_error_sync2       <= cmd_index_error_sync1  ;
			dat_active_sync2            <= dat_active_sync1       ;
			dat_req_sync2               <= dat_req_sync1          ;
		    dec_block_cnt_sync2         <= dec_block_cnt_sync1    ;
			dat_timeout_error_sync2     <= dat_timeout_error_sync1;
			dat_crc_error_sync2         <= dat_crc_error_sync1    ;
			dat_end_error_sync2         <= dat_end_error_sync1    ;
      end
	end

	always@( posedge rst or posedge sd_clk )
	begin
      if(rst)
      begin
         send_cmd_sync1       <= 1'b0;
		 intr_gap_en_sync1    <= 1'b0;
		 continue_req_sync1   <= 1'b0;
		 stop_at_gap_req_sync1 <= 1'b0;
         block_cnt_0_sync1    <= 1'b0;
         send_cmd_sync2       <= 1'b0;
		 intr_gap_en_sync2    <= 1'b0;
		 continue_req_sync2   <= 1'b0;
		 stop_at_gap_req_sync2 <= 1'b0;
         block_cnt_0_sync2    <= 1'b0;
      end
      else
      begin
			send_cmd_sync1   	   <= send_cmd         ;
            intr_gap_en_sync1      <= intr_gap_en    ;
            continue_req_sync1     <= continue_req   ;
            stop_at_gap_req_sync1  <= stop_at_gap_req;
			block_cnt_0_sync1   	<= block_cnt_0         ;
			send_cmd_sync2   	   <= send_cmd_sync1   ;
            intr_gap_en_sync2      <= intr_gap_en_sync1    ;
            continue_req_sync2     <= continue_req_sync1   ;
            stop_at_gap_req_sync2  <= stop_at_gap_req_sync1;
			block_cnt_0_sync2   	<= block_cnt_0_sync1         ;
      end
	end
	
	always@( posedge rst or posedge sd_bclkx2 )
	begin
      if(rst)
      begin
         sd_clock_en_sync1    <= 1'b0;
         int_clock_en_sync1   <= 1'b0;
         load_clock_div_sync1 <= 1'b0;
         sdclk_disable_sync1  <= 1'b0;
         sd_clock_en_sync2    <= 1'b0;
         int_clock_en_sync2   <= 1'b0;
         load_clock_div_sync2 <= 1'b0;
         sdclk_disable_synca  <= 1'b0;
      end
      else
      begin
			sd_clock_en_sync1   	<= sd_clock_en         ;
			int_clock_en_sync1  	<= int_clock_en        ;
			load_clock_div_sync1	<= load_clock_div      ;
         sdclk_disable_sync1  <= sdclk_disable        ;
			sd_clock_en_sync2   	<= sd_clock_en_sync1   ;
			int_clock_en_sync2  	<= int_clock_en_sync1  ;
			load_clock_div_sync2	<= load_clock_div_sync1;
         sdclk_disable_synca  <= sdclk_disable_sync2  ;
      end
	end

	always@( posedge rst_disable or posedge sd_clk )
	begin
      if(rst_disable)
      begin
         sdclk_disable_sync2  <= 1'b0;
      end
      else
      begin
         sdclk_disable_sync2  <= sdclk_disable_sync1;
      end
	end
endmodule