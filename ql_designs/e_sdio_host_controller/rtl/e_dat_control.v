///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_dat_control
// File Name:    e_dat_control.v
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

module e_dat_control(           reset,      //global reset
										rst, 							
										clk, 							
										clkn, 							
										high_speed, 				
										intr_gap_en, 	//from sync		
										read_wait_en, 	
										continue_req,   //from sync
										stop_at_gap_req,//from sync		
										dat_width, 				
										data_dir, 					
										block_cnt_0, 	//from sync					
										block_size_reg, 		
										timeout_cfg, 					
										data_present, 			
										cmd_type, 					
										cmd_end,
										resp_end,
										resp_end_no_err,
										check_busy,
                              cmd_active,
										xmit_data, 				
										buffer_read_rdy,				
										buffer_write_rdy,

										rcv_data, 					
										pop_data, 					
										push_data, 				
										dat_active,  //to sync
										dat_req,     //to sync
										dec_block_cnt, //to sync
                              wr_dat_end,
                              rd_dat_end,
										dat_end_error, //to sync		
										timeout_error, //to sync		
										crc_error, 		//to sync		
										sdio_intr,
										sdclk_disable,
										dat_level, 				
										dat,
										datline0
									);

	input						reset; 							
	input						rst; 							
	input						clk; 							
	input						clkn; 						
	input						high_speed; 			
	input						intr_gap_en; 			
	input						read_wait_en; 	
	input                       continue_req;
	input                       stop_at_gap_req;		
	input						dat_width; 				
	input						data_dir; 				
	input						block_cnt_0; 			
	input		[11:0]	block_size_reg; 	
	input		[3:0]		timeout_cfg; 			
	input						data_present; 		
	input		[1:0]		cmd_type; 				
	input						cmd_end;
	input						resp_end;
	input						resp_end_no_err;
	input						check_busy;
	input						cmd_active;
	input		[7:0]		xmit_data;
	input						buffer_read_rdy;
	input						buffer_write_rdy;
				
	output	[7:0]		rcv_data; 				
	output					pop_data; 				
	output					push_data; 				

	output					dat_active;
	output                  dat_req;
	output                  dec_block_cnt;
   output               wr_dat_end;
   output               rd_dat_end;
	output					dat_end_error; 	//T flop	
	output					timeout_error; 	//T flop	
	output					crc_error; 			//T flop	
	output					sdio_intr;
	output					sdclk_disable;
	output	[3:0]		dat_level; 				
	inout		[3:0]		dat;
	output                  datline0;

  parameter	sDAT_IDLE	 	= 4'b0001;
  parameter	sWR_START	 	= 4'b0010;
  parameter	sWR_DATA	 	= 4'b0011;
  parameter	sWR_CRC	   	= 4'b0100;
  parameter	sWR_END	   	= 4'b0101; 
  parameter	sCRC_STATUS	= 4'b0110; 
  parameter	sCHECK_BUSY	= 4'b0111; 
  parameter	sRD_START	 	= 4'b1000; 
  parameter	sRD_DATA	 	= 4'b1001;
  parameter	sRD_CRC	   	= 4'b1010;
  parameter	sRD_END	   	= 4'b1011;
  
  parameter	INTR_START	= 2'b00;
  parameter	INTR_STOP	= 2'b01;
  parameter	INTR_WAIT1	= 2'b10;
  parameter	INTR_WAIT2	= 2'b11;

	reg		[7:0]		rcv_data;
	wire						dat_active;
	reg                     dec_block_cnt;
	reg						dat_end_error; 		
	reg						timeout_error; 		
	reg						crc_error; 				
	reg						wr_dat_end; 			
	reg						rd_dat_end; 			
	wire 					sdclk_disable;
	wire 					read_wait;

	wire					intr_period;
	reg     [1:0]           intr_period_state;
	reg                     intr_wait_flag;
	reg						intr_mode4; 		
	reg		[7:0]		xmit0_data;
	reg		[1:0]		xmit1_data;
	reg		[1:0]		xmit2_data;
	reg		[1:0]		xmit3_data;
	reg		[3:0]		bit_cnt;
	reg		[11:0]	shared_cnt;
	reg						inc_tmo_h;
	reg		[15:0]	tmo_cnt;
	reg						dat_req;
	reg						dat_req_hold;  // hold read wait until successful suspend command
	wire					stop_cmd;
	reg						rst_fsm;
	reg						clr_bit_cnt;
	reg		[3:0]		dat_state;
	reg		[1:0]		dat_phase;
	reg						timeout;
	
	wire	[7:0]		rcv0_data;
	wire	[1:0]		rcv1_data;
	wire	[1:0]		rcv2_data;
	wire	[1:0]		rcv3_data;
	wire	[3:0]		dat_in;
	wire	[2:0]		data_sel;
	wire					crc_rst;	
	wire					crc_check_en;
	wire					crc_check_en123;
	wire					dat_oe0;					
	wire					dat_oe1;					
	wire					dat_oe2;					
	wire					dat_oe3;					
	wire					last_bit;
	wire					crc_status_error;
	wire					crc_status_start_error;
	wire					dat_end_bit;
	wire					check_crc_status;
	wire					last_crc16_bit;
	
	wire					clr_timeout;
	wire					clr_block_size;
	wire					clr_cnt;
	wire					inc_timeout;
	wire					inc_block_size;
	wire					block_size_1;
	reg                     push_padding;
	
	wire					crc0_error;
	wire					crc1_error;
	wire					crc2_error;
	wire					crc3_error;

wire timeout_error_wire;
wire crc_error_wire    ;
wire dat_end_error_wire;
reg timeout_error_d1;
reg crc_error_d1    ;
reg dat_end_error_d1;

reg buffer_write_rdy_d1;
reg buffer_read_rdy_d1;
reg dat_idle_d1;

wire datline0;

	wire					state_DAT_IDLE;  
	wire					state_WR_START;  
	wire					state_WR_DATA;   
	wire					state_WR_CRC;    
	wire					state_WR_END;    
	wire					state_CRC_STATUS;
	wire					state_CHECK_BUSY;
	wire					state_RD_START;  
	wire					state_RD_DATA;   
	wire					state_RD_CRC;    
	wire					state_RD_END;
	

    assign  sdclk_disable = state_DAT_IDLE & data_dir & ~buffer_write_rdy & dat_req_hold & ~read_wait_en;
    assign  read_wait = state_DAT_IDLE & data_dir & ~buffer_write_rdy & dat_req_hold & read_wait_en;


	assign	last_bit	= ( ( dat_width & bit_cnt[0] ) | ( ~dat_width & ( bit_cnt[2:0] == 3'b111 ) ) );

	assign	dat_level								= dat_in;
	assign	pop_data								=  ( ( dat_width & ~bit_cnt[0] & ~clr_bit_cnt) | ( ~dat_width & ( bit_cnt[2:0] == 3'b110 ) ) ) & state_WR_DATA;
	//assign	push_data								= (last_bit & state_RD_DATA) | push_padding; 
    assign	push_data								= (last_bit & state_RD_DATA); 
	assign	crc_status_error 				= ( check_crc_status & ( rcv0_data[3:0] != 4'b0101 ) );
	assign	crc_status_start_error 	= check_crc_status & rcv0_data[4];
	assign	dat_end_bit 						= ( ~dat_width ) ? rcv0_data[0] : ( rcv0_data[0] & rcv1_data[0] & rcv2_data[0] & rcv3_data[0] );
	assign	check_crc_status 				= ( state_CRC_STATUS & &bit_cnt[2:0] );
	
	assign	sdio_intr	= ( ~dat_width ) ? ~dat_in[1] : intr_mode4;
   assign   dat_active = ~state_DAT_IDLE;
	
	assign	crc_rst 				= state_DAT_IDLE;
	assign	data_sel 				= bit_cnt[2:0];
	assign	crc_check_en 		= state_RD_DATA | state_RD_CRC;
	assign	crc_check_en123	= ( dat_width ) ? crc_check_en : 1'b0;
	assign	dat_oe0					= state_WR_START | state_WR_DATA | state_WR_CRC | state_WR_END;
	assign	dat_oe1					= ( dat_width ) ? dat_oe0 : 1'b0;
	assign	dat_oe2					= ( dat_width ) ? dat_oe0 : 1'b0;
	assign	dat_oe3					= ( dat_width ) ? dat_oe0 : 1'b0;
	
	assign	clr_timeout 		= state_DAT_IDLE & ~( dat_req & ~rcv0_data[0] );
	assign	clr_block_size 	= state_WR_START | ( state_RD_START & ~rcv0_data[0] );
	assign	clr_cnt 				= clr_timeout | clr_block_size;
	assign	inc_timeout 		= ( state_DAT_IDLE & dat_req & ~rcv0_data[0] ) | state_CHECK_BUSY | state_RD_START;
	assign	inc_block_size 	= last_bit & ( state_WR_DATA | state_RD_DATA );
	assign	block_size_1		= ( ( shared_cnt == block_size_reg ) | ~|block_size_reg );

	assign	state_DAT_IDLE  	= ( dat_state == sDAT_IDLE );
	assign	state_WR_START  	= ( dat_state == sWR_START );
	assign	state_WR_DATA   	= ( dat_state == sWR_DATA );
	assign	state_WR_CRC    	= ( dat_state == sWR_CRC );
	assign	state_WR_END    	= ( dat_state == sWR_END );
	assign	state_CRC_STATUS	= ( dat_state == sCRC_STATUS );
	assign	state_CHECK_BUSY	= ( dat_state == sCHECK_BUSY );
	assign	state_RD_START  	= ( dat_state == sRD_START );
	assign	state_RD_DATA   	= ( dat_state == sRD_DATA );
	assign	state_RD_CRC    	= ( dat_state == sRD_CRC );
	assign	state_RD_END    	= ( dat_state == sRD_END );
	
	assign	last_crc16_bit = ( &bit_cnt[3:1] );

assign	timeout_error_wire	= timeout;  	
assign	crc_error_wire			= crc_status_error | crc0_error | crc1_error | crc2_error | crc3_error;
assign	dat_end_error_wire	= state_RD_END & ~dat_end_bit;

	always@(posedge reset or posedge clk)
	begin
      if (reset)
      begin
	     dec_block_cnt      <= 1'b0;
         timeout_error      <= 1'b0;
         crc_error          <= 1'b0;
         dat_end_error      <= 1'b0;
         timeout_error_d1   <= 1'b0;
         crc_error_d1       <= 1'b0;
         dat_end_error_d1   <= 1'b0;
		 dat_idle_d1      <= 1'b0;
      end
      else
      begin
	     if (dat_idle_d1 && !state_DAT_IDLE)
		    dec_block_cnt <= ~dec_block_cnt;
		 
         if (timeout_error_wire & !timeout_error_d1)
            timeout_error <= ~timeout_error;
         
         if (crc_error_wire & !crc_error_d1)
            crc_error <= ~crc_error;
         
         if (dat_end_error_wire & !dat_end_error_d1)
            dat_end_error <= ~dat_end_error;
         
         timeout_error_d1  <= timeout_error_wire;
         dat_end_error_d1  <= dat_end_error_wire;
		 dat_idle_d1       <= state_DAT_IDLE;
		 if (state_DAT_IDLE) 
		    crc_error_d1 <= 1'b0;
		 else if (crc_error_wire)
            crc_error_d1      <= 1'b1;
      end
	end

	always@( dat_state )
	begin
		case( dat_state )
			sWR_START:
			begin
				dat_phase	<= 2'b00;
			end
			sWR_DATA:
			begin
				dat_phase	<= 2'b10;
			end
			sRD_DATA:
			begin
				dat_phase	<= 2'b10;
			end
			sWR_CRC:
			begin
				dat_phase	<= 2'b11;
			end
			sRD_CRC:
			begin
				dat_phase	<= 2'b11;
			end
			default:
			begin
				dat_phase	<= 2'b01;
			end
		endcase
	end			

	always@( timeout_cfg or tmo_cnt )
	begin
		case( timeout_cfg )
			4'h0:
			begin
				timeout	<= tmo_cnt[1];
			end
			4'h1:
			begin
				timeout	<= tmo_cnt[2];
			end
			4'h2:
			begin
				timeout	<= tmo_cnt[3];
			end
			4'h3:
			begin
				timeout	<= tmo_cnt[4];
			end
			4'h4:
			begin
				timeout	<= tmo_cnt[5];
			end
			4'h5:
			begin
				timeout	<= tmo_cnt[6];
			end
			4'h6:
			begin
				timeout	<= tmo_cnt[7];
			end
			4'h7:
			begin
				timeout	<= tmo_cnt[8];
			end
			4'h8:
			begin
				timeout	<= tmo_cnt[9];
			end
			4'h9:
			begin
				timeout	<= tmo_cnt[10];
			end
			4'hA:
			begin
				timeout	<= tmo_cnt[11];
			end
			4'hB:
			begin
				timeout	<= tmo_cnt[12];
			end
			4'hC:
			begin
				timeout	<= tmo_cnt[13];
			end
			4'hD:
			begin
				timeout	<= tmo_cnt[14];
			end
			default:
			begin
				timeout	<= tmo_cnt[15];
			end
		endcase
	end
			
	always@( dat_width or xmit_data or rcv0_data or rcv1_data or rcv2_data or rcv3_data )
	begin
		if( ~dat_width )
		begin
			rcv_data 		<= rcv0_data;
			xmit0_data	<= xmit_data;
			xmit1_data	<= 0;
			xmit2_data	<= 0;
			xmit3_data	<= 0;
		end
		else
		begin
			rcv_data[7]			<= rcv3_data[1];
			rcv_data[6]			<= rcv2_data[1];
			rcv_data[5]			<= rcv1_data[1];
			rcv_data[4]			<= rcv0_data[1];
			rcv_data[3]			<= rcv3_data[0];
			rcv_data[2]			<= rcv2_data[0];
			rcv_data[1]			<= rcv1_data[0];
			rcv_data[0]			<= rcv0_data[0];
			xmit0_data[7:2]	<= 6'b000000;
			xmit3_data[1]		<= xmit_data[7];
			xmit2_data[1]		<= xmit_data[6];
			xmit1_data[1]		<= xmit_data[5];
			xmit0_data[1]		<= xmit_data[4];
			xmit3_data[0]		<= xmit_data[3];
			xmit2_data[0]		<= xmit_data[2];
			xmit1_data[0]		<= xmit_data[1];
			xmit0_data[0]		<= xmit_data[0];
		end
	end	

	always@( posedge clk or posedge rst )
	begin
		if( rst )
		begin
			bit_cnt	<= 4'b0000;	
		end
		else
		begin 	
			if( clr_bit_cnt )
			begin
				bit_cnt	<= 4'b0000;
			end
			else
			begin
				bit_cnt	<= bit_cnt + 1;
			end
		end
	end

	always@( posedge clk or posedge clr_cnt )
	begin
		if( clr_cnt )
		begin
			inc_tmo_h		<= 1'b0;
			shared_cnt	<= 12'h1;	 
		end
		else
		begin
			inc_tmo_h	<= ( inc_timeout & ( &shared_cnt ) );
			if( inc_block_size | inc_timeout )
			begin
				shared_cnt	<= shared_cnt + 1;
			end  
		end
	end	

	always@( posedge clk or posedge clr_timeout )
	begin
		if( clr_timeout )
		begin
			tmo_cnt	<= 16'h0;
		end
		else
		begin
			if( inc_tmo_h & ~timeout )
			begin  
				tmo_cnt	<= tmo_cnt + 1;
			end
		end
	end

	assign intr_period = (intr_period_state == INTR_START)? 1'b1 : 1'b0;
	always@( posedge clk or posedge rst )
	begin
		if( rst )
		begin
		    intr_period_state <= INTR_START;
			intr_wait_flag <= 1'b0;
			intr_mode4 			<= 1'b0;
		end
		else
		begin
		    case (intr_period_state)
               INTR_START : 
               begin
                  if( (cmd_end & (data_present | (cmd_type == 2'b10 && !block_cnt_0 )) ) 
				  | ( intr_wait_flag & dat_req_hold ) )  // between blocks, end interrupt period 2 clocks after
                  begin
                     intr_period_state <= INTR_STOP;
                  end
                  intr_wait_flag <= 1'b1;
               end
               
               INTR_STOP  :
               begin
                  if( ((state_WR_END | state_RD_END)&&( intr_gap_en | block_cnt_0)) // after last data block or gap interrupt is enabled
				     || (cmd_type[0] & resp_end_no_err) )   // successful stop or suspend command finish
                  begin
                     intr_period_state <= INTR_WAIT1;
                  end
                  intr_wait_flag <= 1'b0;
               end
               
               INTR_WAIT1 :
               begin
                  if( intr_wait_flag )
                  begin
                     if (data_dir)
                        intr_period_state <= INTR_START;
                     else
                        intr_period_state <= INTR_WAIT2;
                  end
                  intr_wait_flag <= ~intr_wait_flag;
               end
               
               INTR_WAIT2 :
               begin
                  if( intr_wait_flag )
                  begin
                     intr_period_state <= INTR_START;
                  end
                  intr_wait_flag <= ~intr_wait_flag;
               end
               
               default    :
               begin
                  intr_period_state <= INTR_START;
                  intr_wait_flag <= 1'b1;
               end
            endcase
	
			if ( intr_period && (rcv0_data[0] || !data_dir) )
			begin 
				intr_mode4	<= ( rcv1_data != 2'b11 );
			end
			
		end
	end

	always@( posedge clk or posedge rst )
	begin				 
		if( rst )
		begin
			dat_req	  <= 1'b0;
			dat_req_hold <= 1'b0;
		end
		else
		begin
			if( stop_cmd | block_cnt_0 | stop_at_gap_req )
			begin
				dat_req	<= 1'b0;
			end
			else if( ( ( state_DAT_IDLE & (data_present || cmd_type == 2'b10) ) & ( ( resp_end & ~data_dir ) | ( cmd_end & data_dir ) ) )  | continue_req)
			begin
				dat_req <= 1'b1;
			end
			
			if( stop_cmd | block_cnt_0 | (resp_end_no_err & cmd_type[0]))
			begin
				dat_req_hold	<= 1'b0;
			end
			else if( ( ( state_DAT_IDLE & (data_present || cmd_type == 2'b10) ) & ( ( resp_end & ~data_dir ) | ( cmd_end & data_dir ) ) )  | continue_req)
			begin
				dat_req_hold <= 1'b1;
			end
		end
	end

	assign stop_cmd = cmd_end & ( &cmd_type );
	always@( posedge clk or posedge rst )
	begin
		if( rst )
		begin
			rst_fsm		<= 1'b1;
			wr_dat_end 		   	<= 1'b0;
			rd_dat_end 		   	<= 1'b0;
			//push_padding        <= 1'b0;
			buffer_write_rdy_d1 <= 1'b1;
			buffer_read_rdy_d1  <= 1'b0;
		end
		else
		begin
			if( state_DAT_IDLE )
			begin
				rst_fsm	<= 1'b0;
			end
			else if( stop_cmd )
			begin
				rst_fsm	<= 1'b1;
			end
			wr_dat_end 		   	<= #2 (state_WR_DATA & block_size_1 & last_bit) | (dat_active & stop_cmd & ~data_dir);
			rd_dat_end 		   	<= #2 (state_RD_DATA & block_size_1 & last_bit) | (dat_active & stop_cmd & data_dir);
			//push_padding        <= state_RD_DATA & block_size_1 & last_bit;
			buffer_write_rdy_d1 <= buffer_write_rdy; // sync before goes into state machine
			buffer_read_rdy_d1  <= buffer_read_rdy; // sync before goes into state machine
		end
	end

	always@( posedge clk or posedge rst_fsm )
	begin
		if( rst_fsm )
		begin
			dat_state					<= sDAT_IDLE;	  
			clr_bit_cnt				<= 1'b1;
		end
		else
		begin
			case( dat_state )
				sDAT_IDLE:
				begin
					clr_bit_cnt				<= 1'b1;
					if( dat_req )
					begin
						if( rcv0_data[0] )
						begin
							if( data_dir )
							begin
								if( buffer_write_rdy_d1 )
								begin
									dat_state			<= sRD_START;
								end
							end
							else
							begin
								if( buffer_read_rdy_d1 )
								begin
									dat_state			<= sWR_START;	 
                        end
							end
						end
					end
				end
				sWR_START:
				begin
					clr_bit_cnt				<= 1'b0;
					dat_state					<= sWR_DATA;
				end
				sWR_DATA:
				begin
					clr_bit_cnt				<= 1'b0;
					if( block_size_1 & last_bit )
					begin
						dat_state		<= sWR_CRC;
						clr_bit_cnt	<= 1'b1;
					end		
				end
				sWR_CRC:
				begin
					clr_bit_cnt				<= 1'b0;
					if( last_crc16_bit )
					begin
						dat_state	<= sWR_END;
					end
				end
				sWR_END:
				begin
					clr_bit_cnt				<= 1'b1;
					dat_state					<= sCRC_STATUS;				
				end
				sCRC_STATUS:
				begin
					clr_bit_cnt				<= 1'b0;
					if( &bit_cnt[2:0] )
					begin
						dat_state	<= sCHECK_BUSY;
					end		
				end
				sCHECK_BUSY:
				begin
					clr_bit_cnt				<= 1'b1;
					if( rcv0_data[0] | stop_at_gap_req )
					begin
						dat_state <= sDAT_IDLE;
					end
				end
				sRD_START:
				begin
					clr_bit_cnt				<= 1'b1;
					if( timeout )
					begin
						dat_state	<= sDAT_IDLE;
					end
					else if( ~rcv0_data[0] )
					begin 
						dat_state		<= sRD_DATA;
						clr_bit_cnt <= 1'b0;
					end
				end						
				sRD_DATA:
				begin
					clr_bit_cnt				<= 1'b0;
					if( block_size_1 & last_bit )
					begin
						dat_state		<= sRD_CRC;
						clr_bit_cnt <= 1'b1;
					end
				end
				sRD_CRC:
				begin
					clr_bit_cnt				<= 1'b0;
					if( last_crc16_bit )
					begin
						dat_state <= sRD_END;
					end
				end
				sRD_END:
				begin
					clr_bit_cnt				<= 1'b1;
					dat_state					<= sDAT_IDLE;
				end
				default:
				begin
					clr_bit_cnt 			<= 1'b1;
					dat_state					<= sDAT_IDLE;
				end
			endcase
		end
	end

	e_dat0_line e_iDAT0(
										.rst					( rst ),
										.clk					( clk ),
										.clkn 				( clkn ),
										.high_speed 	( high_speed ),
										.crc_rst 			( crc_rst ),
										.dat_width 		( dat_width ),
										.oe 					( dat_oe0 ),
										.data_sel 		( data_sel ),
										.crc_check_en ( crc_check_en ),
										.dat_phase 		( dat_phase ),
										.xmit_data 		( xmit0_data ),
										.rcv_data			( rcv0_data ),
										.crc_error		( crc0_error ),
										.dat_in				( dat_in[0] ),
										.dat					( dat[0] )
									);

	e_dat123_line e_iDAT1(
											.rst					( rst ),
											.clk					( clk ),
											.clkn					( clkn ),
											.high_speed		( high_speed ),
											.crc_rst			( crc_rst ),
											.read_wait          (1'b0),
											.oe						( dat_oe1 ),
											.data_sel			( data_sel[0] ),
											.crc_check_en	( crc_check_en123 ),
											.dat_phase		( dat_phase ),
											.xmit_data		( xmit1_data ),
											.rcv_data			( rcv1_data ),
											.crc_error		( crc1_error ),
											.dat_in				( dat_in[1] ),
											.dat					( dat[1] )
										);

	e_dat123_line e_iDAT2(
											.rst					( rst ),
											.clk					( clk ),
											.clkn					( clkn ),
											.high_speed		( high_speed ),
											.crc_rst			( crc_rst ),
											.read_wait          (read_wait),
											.oe						( dat_oe2 ),
											.data_sel			( data_sel[0] ),
											.crc_check_en	( crc_check_en123 ),
											.dat_phase		( dat_phase ),
											.xmit_data		( xmit2_data ),
											.rcv_data			( rcv2_data ),
											.crc_error		( crc2_error ),
											.dat_in				( dat_in[2] ),
											.dat					( dat[2] )
										);

	e_dat123_line e_iDAT3(
											.rst					( rst ),
											.clk					( clk ),
											.clkn					( clkn ),
											.high_speed		( high_speed ),
											.crc_rst			( crc_rst ),
											.read_wait          (1'b0),
											.oe						( dat_oe3 ),
											.data_sel			( data_sel[0] ),
											.crc_check_en	( crc_check_en123 ),
											.dat_phase		( dat_phase ),
											.xmit_data		( xmit3_data ),
											.rcv_data			( rcv3_data ),
											.crc_error		( crc3_error ),
											.dat_in				( dat_in[3] ),
											.dat					( dat[3] )
										);

assign datline0 = rcv0_data[0];


endmodule
