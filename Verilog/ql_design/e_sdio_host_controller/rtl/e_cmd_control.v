///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_cmd_control
// File Name:    e_cmd_control.v
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

module e_cmd_control(             reset,    // global reset
                                rst,                            
                                clk,                            
                                clkn,
                                                            
                                high_speed,  
								datline0,               
                                send_cmd,     // from sync      
                                cmd_crc_check,                      
                                cmd_index_check,        
                                cmd_index,                  
                                resp_type,          
                                argu_data,              
                               
                                resp_addr,                   
                                resp_data,                  
                                write_resp,                 
                                cmd_end,        
                                resp_end, 
								resp_end_no_err,
								check_busy,              
                                o_cmd_active,    // to sync
								cmd_done,        //T flop, no reset. need deposit value in simulation
                                resp_end_error,  //T flop, no reset. need deposit value in simulation
                                timeout_error,   //T flop, no reset. need deposit value in simulation
                                crc_error,       //T flop, no reset. need deposit value in simulation
                                cmd_index_error, //T flop, no reset. need deposit value in simulation
                                cmd_level,              
                                cmd
                            );

    input               reset;                            
    input               rst;                            
    input               clk;                            
    input               clkn;

    input               high_speed;   
	input               datline0;              
    input               send_cmd;           
    input               cmd_crc_check;                      
    input               cmd_index_check;        
    input   [5:0]       cmd_index;                  
    input   [1:0]       resp_type;          
    input   [31:0]      argu_data;              

    output  [2:0]       resp_addr;                   
    output  [15:0]      resp_data;                  
    output              write_resp;                 
    output              cmd_end;        
    output              resp_end; 
	output              resp_end_no_err; 
	output              check_busy;             
    output              o_cmd_active;
	output              cmd_done;
    output              resp_end_error;
    output              timeout_error;
    output              crc_error;
    output              cmd_index_error;
    output              cmd_level;              
    inout               cmd;
    
    wire    [2:0]       resp_addr;                   
    wire    [15:0]      resp_data;                  
    wire                write_resp;                 
    wire                cmd_end;        
    wire                resp_end;    
	wire                resp_end_no_err;
	wire                check_busy;           
    reg                 cmd_active;
	reg                 cmd_done;
    reg                 resp_end_error;
    reg                 timeout_error;
    reg                 crc_error;
    reg                 cmd_index_error;

    wire                cmd_level;              
    wire                cmd;

	
    parameter   sCMD_IDLE     = 3'b000;
    parameter   sSEND_CMD     = 3'b100;
    parameter   sWAIT_RESP    = 3'b101;
    parameter   sRCV_RESP     = 3'b110;
    parameter   sCHK_BUSY     = 3'b111;
	parameter   s8CLK_WAIT    = 3'b001;
	
	reg     [2:0]       cmd_state;
	reg     [7:0]       cmd_cnt;
	
	wire                dout_reg;
	wire                oe_reg;
	reg                 dout_reg_hs;
	reg                 oe_reg_hs;
	reg                 dout_reg_ls;
	reg                 oe_reg_ls;
	
	reg     [7:0]       cmd_in_dly;
	
	wire                dout;
	wire                sdata;
	reg     [7:0]       cmd_reg;
	wire    [7:0]       cmd_index_byte;
	reg     [7:0]       argu_byte;
	
	wire                crc_out;
	wire                crc_din;
	reg     [6:0]       crc_reg;

   wire        crc_err;
   wire        index_err;
   reg         crc_err_d1;
   reg         index_err_d1;     
	
	wire                gen48,out48,gen136,out136;
	wire                gen_en;
	wire                out_en;
	wire                byte_end;
	wire                end48;
	wire                cmd_phase;
	wire                wait_resp;
	wire                rcv_resp;
	wire                resp_phase;
	wire                clk8_wait;
	wire                cmd_idle;
	
//--------------------------------------------------
// -- internal port assignment
//--------------------------------------------------
   assign resp_addr[0] = !cmd_cnt[4];
   assign resp_addr[1] = (resp_type[1])? 1'b0 : !cmd_cnt[5];
   assign resp_addr[2] = (resp_type[1])? 1'b0 : !cmd_cnt[6];
	assign resp_data = {cmd_reg[7:0],cmd_in_dly[7:0]};
	assign write_resp = rcv_resp & (cmd_cnt[3:0]=={resp_type[1],3'h6}) & !cmd_cnt[7]; //every 16 bits
	assign cmd_end = end48 & cmd_phase;
	assign resp_end = byte_end & out_en & rcv_resp;
	assign check_busy = (cmd_state == sCHK_BUSY)? 1 : 0;
    assign  cmd_level   = cmd;
//--------------------------------------------------
// -- CMD IO PAD
//--------------------------------------------------	
    assign	cmd			= ( oe_reg ) ? dout_reg : oe_reg_ls;  
    assign	dout_reg	= ( high_speed ) ? dout_reg_hs : dout_reg_ls;
    assign	oe_reg		= ( high_speed ) ? oe_reg_hs : oe_reg_ls;	

//-- high speed output reference to clk positive edge	
	always@( posedge clk or posedge rst )	 
	begin
		if( rst )
		begin
			dout_reg_hs		<= 1'b0;
			oe_reg_hs			<= 1'b0;
		end
		else
		begin
			dout_reg_hs	<= dout;
			oe_reg_hs		<= cmd_phase;	
		end
	end

//-- low speed output reference to clk negetive edge	
	always@( posedge clkn or posedge rst )
	begin
		if( rst )
		begin
			dout_reg_ls	<= 1'b0;
			oe_reg_ls		<= 1'b0;
		end
		else
		begin
			dout_reg_ls	<= dout_reg_hs;
			oe_reg_ls		<= oe_reg_hs;
		end
	end
    
//----------------------------------------------------
//-- Inbound Packet framing
//----------------------------------------------------
	always@( posedge clk or posedge rst )	 
	begin
		if( rst )
		begin
			cmd_in_dly      <= 'b0;
		end
		else
		begin
			cmd_in_dly <= cmd_in_dly << 1;	
			cmd_in_dly[0]   <= cmd | oe_reg_hs;
		end
	end

//----------------------------------------------------
//-- Outbound Packet framing
//----------------------------------------------------
    assign dout = (cmd_cnt[5:4] == 2'b10)? (crc_out|cmd_end) : sdata;
	assign sdata = cmd_reg[7];
	
	always@( posedge clk or posedge rst)
	begin  //in rcv_resp period, it works as lower byte rcv data
	    if( rst )
            cmd_reg <= 'b0;
		else if( !cmd_phase && !rcv_resp )
		    cmd_reg <= cmd_index_byte;
		else if( byte_end & cmd_phase )
		    cmd_reg <= argu_byte;
		else
		begin
		    cmd_reg <= cmd_reg << 1;
			cmd_reg[0] <= cmd_in_dly[7];  // when receive response, keep lower 8 bits
		end
	end
	
	assign cmd_index_byte = {1'b0,!wait_resp,cmd_index};
		
    always @ (cmd_cnt or argu_data)
	    case (cmd_cnt[4:3])
		    2'b10   :  argu_byte <= argu_data[7:0];
		    2'b01   :  argu_byte <= argu_data[15:8];
		    2'b00   :  argu_byte <= argu_data[23:16];
		    default :  argu_byte <= argu_data[31:24];
		endcase

//----------------------------------------------------
//-- CRC generation
//----------------------------------------------------
// CRC output phase is right after generation phase
    assign crc_out = crc_reg[6];
	assign crc_din = (resp_phase)? cmd_in_dly[1] : sdata;
	assign crc_rst = !cmd_phase & !rcv_resp;
	
    always@( posedge clk or posedge crc_rst) begin
      if(crc_rst == 1'b 1) begin
        crc_reg <= 'b0;
      end
      else begin
        if(gen_en == 1'b 1) begin
          crc_reg[6:4]  <= crc_reg[5:3] ;
          crc_reg[3] <= crc_din ^ crc_reg[6] ^ crc_reg[2];
          crc_reg[2:1]  <= crc_reg[1:0] ;
          crc_reg[0] <= crc_din ^ crc_reg[6];
        end
        else begin
          crc_reg  <= crc_reg << 1;
        end
      end
    end

	
//----------------------------------------------------
//-- Error Detection (T flops)
//----------------------------------------------------
assign crc_err =  (cmd_crc_check & out_en & rcv_resp & !resp_end & (crc_out^cmd_in_dly[1])) |   // crc check
		            (oe_reg_hs&&(cmd^dout_reg_hs));  // collision
assign index_err = cmd_index_check & cmd_cnt[7] & rcv_resp & (sdata^cmd_in_dly[1]);

assign resp_end_no_err = resp_end & !(crc_err_d1 | index_err_d1 | ~cmd_in_dly[1]);

    always@(posedge reset or posedge clk)
	begin
      if (reset)
      begin
         timeout_error <= 1'b0;  
         crc_error <= 1'b0;
         resp_end_error <= 1'b0;
         cmd_index_error <= 1'b0;
         cmd_done <= 1'b0;
         crc_err_d1 <= 1'b0;
         index_err_d1 <= 1'b0;
		 cmd_active <= 1'b0;
      end
      else
      begin
	      if ((wait_resp && cmd_cnt[7])||     // response time out
		      (oe_reg_hs&&(cmd^dout_reg_hs)))  // collision
		      timeout_error <= ~ timeout_error;
				
		   if (crc_err & !crc_err_d1)
		      crc_error <= ~ crc_error;
				
		   if (resp_end && !cmd_in_dly[1])   // last bit should be 1
		      resp_end_error <= ~ resp_end_error;
				
		   if (index_err & !index_err_d1)
		      cmd_index_error <= ~ cmd_index_error;

         //if ( (cmd_end && resp_type == 2'b00) ||                      //no reponse, end command
         //   ( resp_end && resp_type != 2'b11 && cmd_in_dly[1] ) ||  //no check busy, end response
         if ( (clk8_wait && byte_end && resp_type == 2'b00) ||                      //no reponse, end command
            ( clk8_wait && byte_end && resp_type != 2'b11 && cmd_in_dly[1] ) ||  //no check busy, end response
            ( cmd_state == sCHK_BUSY && datline0) )                    // end check busy
            cmd_done <= ~ cmd_done;

         if (cmd_active)
         begin
            if (crc_err)  crc_err_d1 <= 1'b1;
            if (index_err) index_err_d1 <= 1'b1;
         end
         else
         begin
            crc_err_d1 <= 1'b0;
            index_err_d1 <= 1'b0;
         end
		 
	     cmd_active <= ~cmd_idle;
		 
      end
	end
	
assign o_cmd_active = ~cmd_idle;  

//----------------------------------------------------
//-- Internal Control
//----------------------------------------------------
// ---CRC generation control
    assign gen48 = !out48;
	assign out48 = (cmd_cnt[5:4] == 2'b10)? 1'b1 : 1'b0;
	assign gen136 = (cmd_cnt[7])? 1'b0 : !out136;
	assign out136 = (cmd_cnt[7:3] == 5'b01111)? 1'b1 : 1'b0;
	assign gen_en = (resp_phase && !resp_type[1])? gen136 : gen48;
	assign out_en = (resp_phase && !resp_type[1])? out136 : out48;
    
// ---End bit flag	
    assign byte_end = (cmd_cnt[2:0]==3'b111)? 1'b1 : 1'b0;
	assign end48 = byte_end & out48;
			   
// --- states
    assign cmd_phase = (cmd_state == sSEND_CMD)? 1'b1 : 1'b0;
	assign wait_resp = (cmd_state == sWAIT_RESP)? 1'b1 : 1'b0;
	assign rcv_resp = (cmd_state == sRCV_RESP)? 1'b1 : 1'b0;
	assign resp_phase = wait_resp | rcv_resp;
	assign clk8_wait = (cmd_state == s8CLK_WAIT) ? 1'b1 : 1'b0;
	assign cmd_idle = (cmd_state == sCMD_IDLE) ? 1'b1 : 1'b0;

//----------------------------------------------------
//-- State Machine and command counter
//----------------------------------------------------
    always@( posedge clk or posedge rst)
	begin
	    if (rst)
		begin
			cmd_cnt <= 'h0;
		    cmd_state <= sCMD_IDLE;
		end
		else
		begin
		    case (cmd_state)
			    sCMD_IDLE :	
				begin
        			cmd_cnt <= 8'hF8;
					
				    if (send_cmd)
					    cmd_state <= sSEND_CMD;
				end
				
				sSEND_CMD :
				begin
				    cmd_cnt <= cmd_cnt + 1;
					
				    if (end48)
					begin
					    if (resp_type == 2'b00)
						begin
						    cmd_state <= s8CLK_WAIT; ////////sCMD_IDLE;
						end
						else
						    cmd_state <= sWAIT_RESP;
					end
				end
				
				sWAIT_RESP :
				begin
				    if (!cmd_in_dly[0])
					    cmd_cnt <= 8'hF8;
					else
					    cmd_cnt <= cmd_cnt + 1;
					
					if (cmd_cnt[7])
					    cmd_state <= sCMD_IDLE;
					else if (!cmd_in_dly[0])
					    cmd_state <= sRCV_RESP;
				end
					    
				sRCV_RESP :
				begin
				    cmd_cnt <= cmd_cnt + 1;
					
					if (byte_end & out_en)
					begin
					    if (resp_type == 2'b11 && cmd_in_dly[1]) // not resp end error
						    cmd_state <= sCHK_BUSY;
						else
						begin
					        cmd_state <= s8CLK_WAIT; ////////sCMD_IDLE;
						end
					end
				end

                s8CLK_WAIT :
				begin
				    cmd_cnt <= cmd_cnt + 1;
					if (byte_end)
			          cmd_state <= sCMD_IDLE;
				end
					    
				sCHK_BUSY :
				begin
					if (datline0)
					begin
				        cmd_state <= sCMD_IDLE;
					end
				end
					    
				default :
				begin
				    cmd_cnt <= 8'hF8;
					cmd_state <= sCMD_IDLE;
				end
			endcase
		end
	end
					
					

endmodule
