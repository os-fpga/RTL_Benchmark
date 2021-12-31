///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_registers
// File Name:    e_registers.v
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

module e_registers(                   //system interface
                  reset,
                  clk,
                  sd_clk,
                  
                  intr,                                      
                  
                  //local bus interface
                  cs,               
                  we,
                  be_n,              
                  addr,             
                  wdata,            
                  rdata,            
                  
                  //DMA interface and user define settings
                  sdclk_freq,       
                  volt_supported,   
                  max_current33v,   
                  max_current30v,   
                  max_current18v,   
                                    
                  // Data Buffer (FIFO) interface                  
                  buffer_write_en,  
                  buffer_read_en,

                  // cmd and dat control common interface
                  cmd_rst,          
                  dat_rst,          
                  all_rst,          
                  high_speed,  
                  // cmd control interface
                  send_cmd,          //to sync 
                  cmd_crc_check,                      
                  cmd_index_check,        
                  cmd_index,                  
                  resp_type,          
                  argu_data,              
                  resp_addr,                   
                  resp_data,                  
                  write_resp,                 
                  cmd_active,        //from sync
                  resp_end_error_p,  //from sync (pulse)
                  cmd_timeout_error_p,   //from sync (pulse)
                  cmd_crc_error_p,   //from sync (pulse)
                  cmd_index_error_p, //from sync (pulse)
                  cmd_done_p,        //from sync (pulse)
                  cmd_level,              
                  
                  //dat control interface
                  dat_width,              
                  data_dir,                   
                  block_cnt_0,        //to sync                
                  block_size_reg,         
                  timeout_cfg,                    
                  data_present,           
                  cmd_type,   
                  intr_gap_en,        //to sync
                  read_wait_en, 
                  continue_req,       //to sync
                  stop_at_gap_req,    //to sync         
                  dat_active,         //from sync
                  dat_req,            // from sync
                  dec_block_cnt_p,    //from sync (pulse)          
                  dat_end_error_p,    //from sync (pulse) 
                  dat_timeout_error_p, //from sync (pulse)
                  dat_crc_error_p,    //from sync (pulse)
                  sdio_intr,
                  dat_level,              
                  
                  // clock management interface                  
                  load_clock_div,    //T flop to sync
                  sd_clock_en,       // to sync
                  int_clock_en,      // to sync
                  clock_div,  
                        
                  // Card Detect interface                  
                  wp_level,                 
                  cd_level,         
                  card_stable,      
                  card_inserted,    
                  sd_pon,

				  dreq,

				  normal_int_st

                  );
//-- ******** ports declaration **********
   input                reset;
   input                clk;
   input                sd_clk;
                       
   output               intr;
   
   input                cs;
   input                we;
   input    [1:0]       be_n;
   input    [8:1]       addr;
   input    [15:0]      wdata;
   output   [15:0]      rdata;
                       
   input    [5:0]       sdclk_freq;
   input    [2:0]       volt_supported;
   input    [7:0]       max_current33v;
   input    [7:0]       max_current30v;
   input    [7:0]       max_current18v;    
                   
   input                buffer_write_en;
   input                buffer_read_en;

   output               cmd_rst;
   output               dat_rst;
   output               all_rst;
   output               high_speed;  
   output               send_cmd;          
   output               cmd_crc_check;                      
   output               cmd_index_check;        
   output   [5:0]       cmd_index;                  
   output   [1:0]       resp_type;          
   output   [31:0]      argu_data;              
   input    [2:0]       resp_addr;                   
   input    [15:0]      resp_data;                  
   input                write_resp;                 
   input                cmd_active;   
   input                resp_end_error_p;  
   input                cmd_timeout_error_p;   
   input                cmd_crc_error_p;   
   input                cmd_index_error_p; 
   input                cmd_done_p;        
   input                cmd_level;              
                 
   output               dat_width;              
   output               data_dir;                   
   output               block_cnt_0;                        
   output   [11:0]      block_size_reg;         
   output   [3:0]       timeout_cfg;                    
   output               data_present;           
   output   [1:0]       cmd_type;       
   output               intr_gap_en;            
   output               read_wait_en;  
   output               continue_req;
   output               stop_at_gap_req;          
   input                dat_active;
   input                dat_req;
   input                dec_block_cnt_p;              
   input                dat_end_error_p;        
   input                dat_timeout_error_p;        
   input                dat_crc_error_p;                
   input                sdio_intr;
   input    [3:0]       dat_level;              
   
   output               load_clock_div;
   output               sd_clock_en;
   output               int_clock_en; 
   output   [7:0]       clock_div;

   input                wp_level;               
   input                cd_level;
   input                card_stable;
   input                card_inserted;
   output               sd_pon;
    
   output				dreq;

   output [15:0]        normal_int_st;


   reg   [7:0]          dreq_cnt;
   reg                  dreq_start;
   reg         		    dreq_mode;

   wire                 intr;
   reg                  led;
   reg      [15:0]      rdata;

   wire                 cmd_rst;
   wire                 dat_rst;
   wire                 all_rst;
   reg                  high_speed;  
   wire                 send_cmd;          
   wire                 cmd_crc_check;                      
   wire                 cmd_index_check;        
   wire     [5:0]       cmd_index;                  
   wire     [1:0]       resp_type;          
   wire     [31:0]      argu_data;   
   reg                  continue_req;
   reg                  stop_at_gap_req;           
   reg                  dat_width;              
   wire                 data_dir;                   
   wire                 block_cnt_0;                        
   reg      [11:0]      block_size_reg;         
   reg      [3:0]       timeout_cfg;                    
   wire                 data_present;           
   wire     [1:0]       cmd_type;       
   wire                 intr_gap_en;            
   wire                 read_wait_en;            
   reg                  load_clock_div;
   wire                 sd_clock_en;
   wire                 int_clock_en; 
   reg      [7:0]       clock_div;
   wire                 sd_pon;

//--******* Internal signals declaration ********
   parameter   max_block_length        = 2'b00;
   parameter   high_speed_support  = 1'b1;
   parameter   suspend_support         = 1'b1;
   parameter   soft_rst_ctrl           = 8'h0;
   parameter   spec_version                = 8'h0;
   parameter   vendor_version          = 8'h0;

   wire                 int_req;
   wire                 wakeup_req;
   wire     [15:0]      normal_int_sig_en_wire;
   wire     [15:0]      error_int_sig_en_wire;
   reg      [15:0]      normal_int_sig;
   reg      [15:0]      error_int_sig;

   reg                  cmd_req;
   reg                  autoCMD12_req;
   reg                  send_cmd_req;
   reg                  cmd_gnt;
   reg                  autoCMD12_active;
   reg                  block_cnt_is_0;
   reg                  xfer_complete_pulse;

   reg      [15:0]      block_cnt;
   reg      [31:0]      argument_reg;
   wire     [31:0]      command_reg;
   reg                  block_cnt_en;
   reg                  autoCMD12_en;
   reg                  data_direction;
   reg                  multi_block;
   reg      [1:0]       resp_type_reg;
   reg                  cmd_crc_check_reg;
   reg                  cmd_index_check_reg;
   reg                  data_present_reg;
   reg      [1:0]       cmd_type_reg;
   reg      [5:0]       cmd_index_reg;
   wire     [31:0]      present_state;
   wire                  write_active;
   wire                  read_active;

   wire    [7:0]       host_ctrl;
   wire    [7:0]       power_ctrl;
   wire    [7:0]       block_gap_ctrl;
   wire    [7:0]       wakeup_ctrl;
   reg                     sd_pon_reg;
   reg     [2:0]           sd_volt_reg;
   reg                     sdio_intr_gap_en;
   reg                     sdio_read_wait_en;
   reg                     wake_intr_en;
   reg                     wake_on_insertion;
   reg                     wake_on_removal;
   wire    [7:0]       clock_ctrl;   
   reg                     internal_clock_en;
   reg                     sdio_clock_en;
   reg                     soft_rst_cmd;
   reg                     soft_rst_dat; 
   reg                     rst;
   wire    [15:0]  normal_int_st;
   reg                     cmd_complete;
   reg                     xfer_complete;
   reg                     block_gap_event;
   reg                     buffer_write_rdy;
   reg                     buffer_read_rdy;
   reg                     card_insertion;
   reg                     card_removal;
   reg                     buffer_wr_req;

   wire    [15:0]  error_int_st;
   reg                     cmd_timeout_err;
   reg                     cmd_crc_err;
   reg                     resp_end_err;
   reg                     cmd_index_err;
   reg                     cmd_index_err_hold;
   reg                     data_timeout_err;
   reg                     data_crc_err;
   reg                     data_end_err;
   reg                     autoCMD12_err;
   reg     [8:0]       normal_int_st_en;
   reg     [8:0]       error_int_st_en;
   reg     [8:0]       normal_int_sig_en;
   reg     [8:0]       error_int_sig_en;
   wire    [7:0]       autoCMD12_int_st;
   reg                     autoCMD12_timeout_err;
   reg                     autoCMD12_crc_err;
   reg                     autoCMD12_end_err;
   reg                     autoCMD12_index_err;

   wire    [31:0]  capabilities;
   wire    [7:0]       int_st;
   wire    [17:0]  rd_ram;
   wire    [1:0]       waddr_ram;

   wire                 xfer_active;
   wire                 xfer_active_f; //falling edge
   reg                  xfer_active_d1;
   wire                 card_inserted_f; //falling edge
   wire                 card_inserted_r; //rising edge
   reg                  card_inserted_d1;
   wire                 buffer_wr_req_r;
   reg                  buffer_wr_req_d1  ;
   wire                 buffer_read_en_d1_r;
   reg                  buffer_read_en_d1 ; // to sync input
   reg                  buffer_read_en_d2 ; 

   wire                 clkn;
//-- *******************Begin of Body************************
// -----output port assignment-----
   assign  dreq  = dreq_mode & dreq_cnt[3];
   
   assign  intr = int_req; 

   assign  all_rst = rst;
   assign  cmd_rst = soft_rst_cmd;
   assign  dat_rst = soft_rst_dat;
   assign  send_cmd            = send_cmd_req;

   assign  cmd_crc_check   = (autoCMD12_active)? 1'b1  : cmd_crc_check_reg;
   assign  cmd_index_check = (autoCMD12_active)? 1'b1  : cmd_index_check_reg;
   assign  cmd_index       = (autoCMD12_active)? 6'd12 : cmd_index_reg;
   assign  resp_type       = (autoCMD12_active)? 2'b11 : resp_type_reg;
   assign  argu_data       = argument_reg;   
   assign  data_dir        = data_direction;    
   assign  block_cnt_0     = block_cnt_is_0;
   assign  data_present    = (autoCMD12_active)? 1'b0  : data_present_reg;
   assign  cmd_type        = (autoCMD12_active)? 2'b11 : cmd_type_reg;
   assign  intr_gap_en     = sdio_intr_gap_en;
   assign  read_wait_en    = sdio_read_wait_en;
   assign  sd_clock_en     = sdio_clock_en;
   assign  int_clock_en    = internal_clock_en;
   assign  sd_pon          = sd_pon_reg;

// ------one delay signals------

    assign xfer_active = dat_req | dat_active;
    assign xfer_active_f = xfer_active_d1 & ~xfer_active;
    assign card_inserted_f = card_inserted_d1 & ~card_inserted;
    assign card_inserted_r = card_inserted & ~card_inserted_d1;
   always @ (posedge clk or posedge reset)
   begin
      if (reset)
      begin
         xfer_active_d1       <= 1'b0;
         card_inserted_d1     <= 1'b0;
      end
      else
      begin
         xfer_active_d1       <= xfer_active;
         card_inserted_d1     <= card_inserted;
      end
   end

   assign buffer_wr_req_r = buffer_wr_req & ~buffer_wr_req_d1;
   assign buffer_read_en_d1_r = buffer_read_en_d1 & ~buffer_read_en_d2;
   always @ (posedge clk or posedge soft_rst_dat)
   begin
      if (soft_rst_dat)
      begin
         buffer_wr_req_d1     <= 1'b0;
         buffer_read_en_d1    <= 1'b0;
         buffer_read_en_d2    <= 1'b0;
      end
      else
      begin
         buffer_wr_req_d1     <= buffer_wr_req;     //already sync before
         buffer_read_en_d1    <= buffer_read_en;    //sync1 before use it
         buffer_read_en_d2    <= buffer_read_en_d1;
      end
   end

// --------dreq logic------------------------------

   always@( posedge clk or posedge rst )
   begin 
      if( rst )
      begin
         dreq_mode <= 1'b0;
      end
      else
      begin
         if( cs & we & ~be_n[1] & ( addr == 8'b100_0000_0 ) )
         begin
            dreq_mode <= wdata[9];
         end
      end
   end 

   always@( posedge clk or posedge rst )
   begin
      if( rst )
      begin
         dreq_start <= 1'b0;
      end
      else
      begin
         if( &dreq_cnt | soft_rst_dat )
         begin
            dreq_start <= 1'b0;
         end
         else if( ( buffer_read_en_d1_r | buffer_wr_req_r ) & ~( ( ~data_dir & normal_int_st_en[4] ) | ( data_dir & normal_int_st_en[5] ) ) )
         begin
            dreq_start <= dreq_mode;
         end
      end
   end
  
   always@( posedge clk or posedge rst )
   begin
     if( rst )
     begin
        dreq_cnt <= 8'b00000000;
     end
     else
     begin
        if ( soft_rst_dat )
        begin
           dreq_cnt <= 8'b00000000;
        end
        else if ( dreq_start )
        begin
           dreq_cnt <= dreq_cnt + 1;
        end
     end
   end

// --------interrupt and wakeup logic--------------
   assign  int_req         = ~( ~|normal_int_sig & ~|error_int_sig );   
   assign  wakeup_req  = ( wake_intr_en & sdio_intr ) | ( wake_on_insertion & card_insertion ) | ( wake_on_removal & card_removal );
   assign  normal_int_sig_en_wire  = { 7'b0, normal_int_sig_en[8:0] };
   assign  error_int_sig_en_wire       = { 7'b0, error_int_sig_en[8:0] };

   integer i;
   always@( normal_int_st or normal_int_sig_en_wire or error_int_st or error_int_sig_en_wire )
   begin
       for( i = 0; i <= 15; i = i+1 )
       begin
           normal_int_sig[i]   <= normal_int_st[i] & normal_int_sig_en_wire[i];
           error_int_sig[i]    <= error_int_st[i] & error_int_sig_en_wire[i];  
       end
   end  


// -------- send command and autoCMD12 logic-------------
   always@( posedge clk or posedge soft_rst_cmd )
   begin
      if( soft_rst_cmd )
      begin
         cmd_req    <= 1'b0;
         autoCMD12_req  <= 1'b0;
      end
      else
      begin
         if( cs & we & ~be_n[1] & ( addr == 8'b000_0011_1 ) )   // offset 'hE
            begin
            cmd_req    <= 1'b1 ;
         end
         else if (cmd_gnt)
         begin
           cmd_req <= 1'b0;
         end

         if( autoCMD12_active )
         begin
            autoCMD12_req  <= 1'b0;
         end
         else if( multi_block & block_cnt_is_0 & autoCMD12_en & xfer_active_f)
         begin
            autoCMD12_req  <= 1'b1;
         end
      end
   end

   always@( posedge clk or posedge soft_rst_cmd )
   begin
       if( soft_rst_cmd )
       begin
           send_cmd_req    <= 1'b0;
           cmd_gnt <= 1'b0;
           autoCMD12_active <= 1'b0;
       end
       else
       begin
           if( cmd_active )   
           begin
               send_cmd_req    <= 1'b0;
           end
           else if (cmd_req || autoCMD12_req)
           begin
              send_cmd_req <= 1'b1;
           end

           if (!cmd_active && !send_cmd_req)
           begin
              cmd_gnt <= cmd_req & ~autoCMD12_req;
              
           end

              if( autoCMD12_req && !cmd_active && !send_cmd_req)     
                autoCMD12_active <= 1'b1;                            
              else if( cmd_done_p )                                  
                autoCMD12_active <= 1'b0;                            

       end
   end

//---------- transfer control flags -----------
    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            block_cnt_is_0  <= 1'b1;
        end
        else
        begin
            if( dat_active )
            begin
                block_cnt_is_0  <= ~( multi_block & ( ~block_cnt_en | |block_cnt ) );
            end
            else if ( cmd_req && ( data_present || cmd_type == 2'b10 ) )
            begin
                block_cnt_is_0  <= ( multi_block & block_cnt_en & ~|block_cnt );
            end
        end
    end

    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            xfer_complete_pulse <= 1'b0;
        end
        else
        begin
            if( multi_block & block_cnt_is_0 & autoCMD12_en )
            begin
                xfer_complete_pulse <= autoCMD12_active & cmd_done_p;    
            end
            else
            begin
                xfer_complete_pulse <= xfer_active_f;
            end
        end
    end 


//-----------register read logic------------------
   always@( addr or block_cnt or block_size_reg or argument_reg or command_reg or present_state
          or wakeup_ctrl or block_gap_ctrl or power_ctrl or host_ctrl or timeout_cfg or clock_div
          or clock_ctrl or error_int_st or normal_int_st or error_int_st_en or normal_int_st_en
          or normal_int_sig_en_wire or error_int_sig_en_wire or autoCMD12_int_st or capabilities
          or max_current18v or max_current30v or max_current33v or int_st or dreq_mode or rd_ram)
   begin
      case( addr )
         8'b000_0000_0:   
             rdata   <= 16'h0; 
            8'b000_0000_1:   
             rdata   <= 16'h0;           
         8'b000_0001_0:   
                rdata <= { 4'b0, block_size_reg[11:0] };
            8'b000_0001_1:   
                rdata <= { block_cnt[15:0] };
         8'b000_0010_0:    
                rdata <= argument_reg[15:0];
           8'b000_0010_1:   
             rdata <= argument_reg[31:16];
         8'b000_0011_0:    
             rdata <= command_reg[15:0];
            8'b000_0011_1:    
             rdata <= command_reg[31:16];    
         8'b000_1001_0:   
             rdata <= present_state[15:0];
            8'b000_1001_1:   
             rdata <= present_state[31:16];      
         8'b000_1010_0:   
                rdata <= { power_ctrl, host_ctrl};
         8'b000_1010_1:   
             rdata <= { wakeup_ctrl, block_gap_ctrl };       
         8'b000_1011_0:   
                rdata <= { clock_div,  clock_ctrl };
         8'b000_1011_1:   
             rdata <= { 12'b0, timeout_cfg };     
         8'b000_1100_0:   
             rdata   <= { normal_int_st };
         8'b000_1100_1:   
             rdata   <= { error_int_st }; 
         8'b000_1101_0:   
             rdata   <= { 7'b0, normal_int_st_en };
         8'b000_1101_1:   
             rdata   <= { 7'b0, error_int_st_en };       
         8'b000_1110_0:   
             rdata   <= { normal_int_sig_en_wire };
         8'b000_1110_1:   
             rdata   <= { error_int_sig_en_wire };   
         8'b000_1111_0:    
                rdata <= { 8'b0, autoCMD12_int_st[7:0] };
         8'b000_1111_1:    
             rdata <= { 16'b0 };     
         8'b001_0000_0: 
             rdata <= capabilities[15:0];           
         8'b001_0000_1:    
             rdata <= capabilities[31:16];       
         8'b001_0001_0:   
             rdata <= 16'b0;
         8'b001_0001_1:   
             rdata <= 16'b0;             
         8'b001_0010_0:   
                rdata <= { max_current30v, max_current33v };
         8'b001_0010_1:    
             rdata <= { 8'b0, max_current18v };      
         8'b001_0011_0:  
             rdata <= 16'b0;            
         8'b001_0011_1:   
             rdata <= 16'b0;     
         8'b011_1111_0:   
                rdata <= { 8'b0, int_st[7:0] };
         8'b011_1111_1:   
             rdata <= { vendor_version, spec_version };
         8'b100_0000_0:   
             rdata <= { 6'b0, dreq_mode, 9'b0 };
         default: 
			 rdata <=  rd_ram[15:0];  
      endcase
   end


    //--****************************************
    //-- registers
    //--****************************************   
    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            block_size_reg  <= 12'b0;
            block_cnt   <= 16'b0;
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_0001_0 ) ) // offset 'h4
                begin
                if( ~be_n[0] )
                begin
                    block_size_reg[7:0] <= wdata[7:0];
                end
                if( ~be_n[1] )
                begin
                    block_size_reg[9:8]    <= wdata[9:8];
                    block_size_reg[11:10]    <= 2'b00;
                end
                end
                
                if( cs & we & ( addr == 8'b000_0001_1 ) ) // offset 'h6
            begin
                    if( ~be_n[0] )  
                begin
                    block_cnt[7:0]  <= wdata[7:0];  
                end
                if( ~be_n[1] )  
                begin
                    block_cnt[15:8] <= wdata[15:8];  
                end
            end
            else if( dec_block_cnt_p & block_cnt_en & multi_block & ~block_cnt_is_0 )
            begin
                block_cnt <= block_cnt - 1;
            end
        end
    end 

    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            argument_reg    <= 32'h0;
        end
        else
        begin
                if( cs & we & ( addr == 8'b000_0010_0 ) ) //offset 'h8
            begin
                if( ~be_n[0] )
                begin
                    argument_reg[7:0] <= wdata[7:0];
                end
                if( ~be_n[1] )
                begin
                    argument_reg[15:8] <= wdata[15:8];
                end
                end 
                
                if( cs & we & ( addr == 8'b000_0010_1 ) ) //offset 'hA
            begin    
                if( ~be_n[0] )  
                begin
                    argument_reg[23:16] <= wdata[7:0];  
                end
                if( ~be_n[1] )  
                begin
                    argument_reg[31:24] <= wdata[15:8];  
                end
            end
        end
    end

    assign command_reg = { 2'b0, cmd_index, cmd_type, data_present, cmd_index_check, cmd_crc_check, 1'b0, resp_type, 10'b0, multi_block, data_direction, 1'b0, autoCMD12_en, block_cnt_en, 1'b0 };
    always@( posedge clk or posedge rst )
    begin 
        if( rst )
        begin
            block_cnt_en        <= 1'b0;
            autoCMD12_en        <= 1'b0;
            data_direction  <= 1'b0;
            multi_block         <= 1'b0;
            resp_type_reg           <= 2'b00;
            cmd_crc_check_reg   <= 1'b0;
            cmd_index_check_reg <= 1'b0;
            data_present_reg        <= 1'b0;
            cmd_type_reg                <= 2'b00;
            cmd_index_reg   <= 5'b00000;
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_0011_0 ) )   //offset 'hC
                begin
                if( ~be_n[0] )
                begin
                    block_cnt_en        <= wdata[1];
                    autoCMD12_en        <= wdata[2];
                    data_direction  <= wdata[4];
                    multi_block         <= wdata[5];
                end
                end  
                
                if( cs & we & ( addr == 8'b000_0011_1 ) )   //offset 'hE  
            begin              
                    if( ~be_n[0] )  
                begin
                    resp_type_reg       <= wdata[1:0]; 
                    cmd_crc_check_reg   <= wdata[3];   
                    cmd_index_check_reg <= wdata[4];   
                    data_present_reg    <= wdata[5];   
                    cmd_type_reg        <= wdata[7:6]; 
                end
                if( ~be_n[1] )  
                begin
                    cmd_index_reg       <= wdata[13:8]; 
                end
            end
        end
    end 
        
   // --- register 'h24       read only    
   assign  present_state[0]            = cmd_req | cmd_gnt;
   assign  present_state[1]            = xfer_active | (cmd_active & &resp_type);
   assign  present_state[2]            = xfer_active;
   assign  present_state[7:3]      = 5'b0;
   assign  present_state[8]            = write_active;
   assign  present_state[9]            = read_active;
   assign  present_state[10]           = buffer_write_en;
   assign  present_state[11]           = buffer_read_en;
   assign  present_state[15:12]    = 4'b0;
   assign  present_state[16]           = card_inserted;
   assign  present_state[17]           = card_stable;
   assign  present_state[18]           = ~cd_level;
   assign  present_state[19]           = ~wp_level;
   assign  present_state[23:20]    = dat_level;
   assign  present_state[24]       = cmd_level;
   assign  present_state[31:25]    = 7'b0;

   assign  write_active = xfer_active & ~data_direction;
   assign  read_active = xfer_active & data_direction;

   assign  host_ctrl = { 5'b0, high_speed, dat_width, ~led };
   assign  power_ctrl = {4'b000, sd_volt_reg, sd_pon_reg};
   assign  block_gap_ctrl  = { 4'b0000, sdio_intr_gap_en, sdio_read_wait_en, continue_req, stop_at_gap_req };
   assign  wakeup_ctrl = {5'b0, wake_on_removal, wake_on_insertion, wake_intr_en};
    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            led                 <= 1'b1;
            dat_width       <= 1'b0;  
            high_speed  <= 1'b0;
            sd_pon_reg <= 1'b0;
            sd_volt_reg <= 3'b0;
            stop_at_gap_req <= 1'b0;
            continue_req <= 1'b0;
            sdio_read_wait_en <= 1'b0;
            sdio_intr_gap_en <= 1'b0;
            wake_intr_en            <= 1'b0;
            wake_on_insertion <= 1'b0;
            wake_on_removal     <= 1'b0;
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_1010_0 ) )   // offset 'h28
                begin
                if( ~be_n[0] )
                begin
                    led         <= ~wdata[0];
                    dat_width   <= wdata[1];     
                    high_speed  <= wdata[2];
                end
                if( ~be_n[1] )
                begin
                        sd_volt_reg <= wdata[11:9];
                    sd_pon_reg  <= wdata[8];
                end
                end
                
                if( cs & we & ( addr == 8'b000_1010_1 ) )   // offset 'h2A
                begin 
                if( ~be_n[0] )  
                begin
                        stop_at_gap_req <= wdata[0];  
                         if (!stop_at_gap_req)
                         begin
                             continue_req <= wdata[1];  
                         end
                    sdio_read_wait_en <= wdata[2]; 
                    sdio_intr_gap_en <= wdata[3];  
                end
                if( ~be_n[1] )  
                begin
                    wake_intr_en        <= wdata[8];   
                    wake_on_insertion   <= wdata[9];   
                    wake_on_removal     <= wdata[10];  
                end
            end
               else if (dat_active)
               begin
                   continue_req <= 1'b0;
               end
        end
    end 

   assign  clock_ctrl  = { 5'b00000, sdio_clock_en, 1'b1, internal_clock_en };
    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            internal_clock_en <= 1'b0;
            sdio_clock_en           <= 1'b0;
            clock_div                   <= 8'h0;
            timeout_cfg <= 4'h0;
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_1011_0 ) )    // offset 'h2C
                begin
                if( ~be_n[0] )
                begin
                    internal_clock_en   <= wdata[0];
                    sdio_clock_en           <= wdata[2];
                end
                if( ~be_n[1] )
                begin
                    clock_div   <= wdata[15:8];
                end
                end
                
                if( cs & we & ( addr == 8'b000_1011_1 ) )    // offset 'h2E   
            begin            
                    if( ~be_n[0] )  
                begin
                    timeout_cfg <= wdata[3:0];  
                end
            end
        end
    end 

    always@( posedge clk or posedge reset )
    begin
        if( reset )
        begin
            load_clock_div  <= 1'b0;
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_1011_0 ) & ~be_n[1])    // offset 'h2C
                begin
               load_clock_div  <= ~ load_clock_div;
            end
        end
    end 
    
    
//--*********** reset logic 
    always@( posedge clk or posedge reset )
    begin
        if( reset )
        begin
            soft_rst_cmd    <= 1'b1;
            soft_rst_dat    <= 1'b1; 
            rst                     <= 1'b1;
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_1011_1 ) )  // offset 'h2E
                begin
                if( ~be_n[1] )  
                begin
                    soft_rst_cmd    <= wdata[8] | wdata[9];  
                    soft_rst_dat    <= wdata[8] | wdata[10];  
                    rst             <= wdata[8];              
                end
            end
            else
            begin
                soft_rst_cmd    <= 1'b0;
                soft_rst_dat    <= 1'b0; 
                rst             <= 1'b0;
            end
        end
    end

        
   assign  normal_int_st[0]        = cmd_complete;
   assign  normal_int_st[1]        = xfer_complete;
   assign  normal_int_st[2]        = block_gap_event;
   assign  normal_int_st[3]        = 1'b0; 
   assign  normal_int_st[4]        = buffer_write_rdy;
   assign  normal_int_st[5]        = buffer_read_rdy;
   assign  normal_int_st[6]        = card_insertion;
   assign  normal_int_st[7]        = card_removal;
   assign  normal_int_st[8]        = sdio_intr & normal_int_st_en[8];
   assign  normal_int_st[14:9] = 6'b0;
   assign  normal_int_st[15]       = |error_int_st;

    always@( posedge clk or posedge rst )
    begin
        if( rst )
        begin
            cmd_complete                        <= 1'b0;
            xfer_complete                       <= 1'b0;
            block_gap_event                     <= 1'b0;
            buffer_write_rdy                <= 1'b0;
            buffer_read_rdy                 <= 1'b0;
            card_insertion                  <= 1'b0;
            card_removal                        <= 1'b0;
            buffer_wr_req                   <= 1'b0;
        end
        else
        begin           
            if( normal_int_st[15] | soft_rst_cmd | ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[0] ) )  // offset 'h30
                begin
                cmd_complete                        <= 1'b0;
            end
            else if( cmd_done_p & !autoCMD12_active)
            begin
                cmd_complete                        <= normal_int_st_en[0];
            end
            
            if( normal_int_st[15] | soft_rst_dat | ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[1]) )  // offset 'h30
                begin
                xfer_complete <= 1'b0;
            end
            else if( xfer_complete_pulse || ( cmd_done_p && resp_type == 2'b11 ) )
            begin
                xfer_complete <= normal_int_st_en[1];
            end
            
            if( normal_int_st[15] | soft_rst_dat | ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[2]) )  // offset 'h30
                begin
                block_gap_event <= 1'b0;
            end
            else if( xfer_complete_pulse & ~block_cnt_is_0 & stop_at_gap_req)
            begin
                block_gap_event <= normal_int_st_en[2];
            end
            
            if( buffer_wr_req_r )
            begin
                buffer_write_rdy <= normal_int_st_en[4];
            end
            else if( normal_int_st[15] | soft_rst_dat | ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[4] ) )  // offset 'h30
                begin
                buffer_write_rdy <= 1'b0;
            end

            if( buffer_read_en_d1_r ) 
            begin
                buffer_read_rdy <= normal_int_st_en[5];
            end
            else if( normal_int_st[15] | soft_rst_dat | ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[5]) )  // offset 'h30
                begin
                buffer_read_rdy <= 1'b0;
            end
            
            if( card_inserted_r )
            begin
                card_insertion <= normal_int_st_en[6];
            end
            else if( normal_int_st[15] | (cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[6]) )  // offset 'h30
                begin
                card_insertion <= 1'b0;
            end
            
            if( card_inserted_f )
            begin
                card_removal <= normal_int_st_en[7];
            end 
            else if( normal_int_st[15] | (cs & we & ~be_n[0] & ( addr == 8'b000_1100_0 ) & wdata[7]) )  // offset 'h30
                begin
                card_removal <= 1'b0;
            end
            
            buffer_wr_req <= write_active & buffer_write_en & ~block_cnt_is_0 & ~stop_at_gap_req;
        end
    end 
    
   assign  error_int_st[0]         = cmd_timeout_err;
   assign  error_int_st[1]         = cmd_crc_err;
   assign  error_int_st[2]         = resp_end_err;
   assign  error_int_st[3]         = cmd_index_err;
   assign  error_int_st[4]         = data_timeout_err;
   assign  error_int_st[5]         = data_crc_err;
   assign  error_int_st[6]         = data_end_err;
   assign  error_int_st[7]         = 1'b0;
   assign  error_int_st[8]         = autoCMD12_err;
   assign  error_int_st[15:9]  = 7'b0; 

    always@( posedge clk or posedge rst )   // offset 'h30
    begin
        if( rst )
        begin
            cmd_timeout_err         <= 1'b0;
            cmd_crc_err             <= 1'b0;
            resp_end_err            <= 1'b0;
            cmd_index_err           <= 1'b0;
            cmd_index_err_hold      <= 1'b0;
            data_timeout_err        <= 1'b0;
            data_crc_err            <= 1'b0;
            data_end_err            <= 1'b0;
            autoCMD12_err           <= 1'b0;
        end
        else
        begin
            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[0] ) | soft_rst_cmd )  //offset 'h32            
                    cmd_timeout_err <= 1'b0;
            else if( cmd_timeout_error_p & ~autoCMD12_active )
                cmd_timeout_err <= error_int_st_en[0];
            
            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[1] ) | soft_rst_cmd )  //offset 'h32            
                    cmd_crc_err <= 1'b0;
            else if( cmd_crc_error_p  & ~autoCMD12_active  )
                cmd_crc_err <= error_int_st_en[1];

            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[2] ) | soft_rst_cmd )  //offset 'h32
                 resp_end_err <= 1'b0;
            else if( resp_end_error_p  & ~autoCMD12_active )
                resp_end_err <= error_int_st_en[2];

            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[3] ) | soft_rst_cmd )  //offset 'h32
                cmd_index_err <= 1'b0;
            else 
			  begin
			    if( cmd_index_error_p  & ~autoCMD12_active )
                  cmd_index_err_hold <= error_int_st_en[3];
                if( cmd_done_p )
				  cmd_index_err <= cmd_index_err_hold;
              end

            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[4] ) | soft_rst_cmd )  //offset 'h32
                data_timeout_err <= 1'b0;
            else if( dat_timeout_error_p )
                data_timeout_err <= error_int_st_en[4];

            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[5] ) | soft_rst_cmd )  //offset 'h32
                data_crc_err <= 1'b0;
            else if( dat_crc_error_p )
                data_crc_err <= error_int_st_en[5];
            
            if( ( cs & we & ~be_n[0] & ( addr == 8'b000_1100_1 ) & wdata[6] ) | soft_rst_cmd )  //offset 'h32
                data_end_err <= 1'b0;
            else if( dat_end_error_p  )
                data_end_err <= error_int_st_en[6];
            
            if( ( cs & we & ~be_n[1] & ( addr == 8'b000_1100_1 ) & wdata[8] ) | soft_rst_cmd )  //offset 'h32
                autoCMD12_err <= 1'b0;
            else if( autoCMD12_active & ( cmd_timeout_error_p | cmd_crc_error_p | resp_end_error_p | cmd_index_error_p ) )
                autoCMD12_err <= error_int_st_en[8];
        end
    end 
            
    always@( posedge clk or posedge rst )  
    begin
        if( rst )
        begin
            normal_int_st_en[8:0] <= 9'h0;  
            error_int_st_en[8:0] <= 9'h0;  
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_1101_0 ) )  // offset 'h34
            begin
                if( ~be_n[0] )
                begin
                    normal_int_st_en[7:0]   <= wdata[7:0];
                end
                if( ~be_n[1] )
                begin
                    normal_int_st_en[8] <= wdata[8];
                end
                end  
                
            if( cs & we & ( addr == 8'b000_1101_1 ) )  // offset 'h36
            begin               
                if( ~be_n[0] )  
                begin
                    error_int_st_en[7:0]    <= wdata[7:0];  
                end
                if( ~be_n[1] )  
                begin
                    error_int_st_en[8]  <= wdata[8];  
                end
            end
        end
    end 
            
    always@( posedge clk or posedge rst )   
    begin
        if( rst )
        begin
            normal_int_sig_en[8:0] <= 9'h0;  
            error_int_sig_en[8:0] <= 9'h0;  
        end
        else
        begin
            if( cs & we & ( addr == 8'b000_1110_0 ) )  // offset 'h38
                begin
                if( ~be_n[0] )
                begin
                    normal_int_sig_en[7:0]  <= wdata[7:0];
                end
                if( ~be_n[1] )
                begin
                    normal_int_sig_en[8]    <= wdata[8];
                end
                end
                
                if( cs & we & ( addr == 8'b000_1110_1 ) )  // offset 'h3A
                begin    
                if( ~be_n[0] )  
                begin
                    error_int_sig_en[7:0]   <= wdata[7:0];  
                end
                if( ~be_n[1] )  
                begin
                    error_int_sig_en[8] <= wdata[8];  
                end
            end
        end
    end 
            
   assign  autoCMD12_int_st[0]     = 1'b0;
   assign  autoCMD12_int_st[1]     = autoCMD12_timeout_err;
   assign  autoCMD12_int_st[2]     = autoCMD12_crc_err;
   assign  autoCMD12_int_st[3]     = autoCMD12_end_err;
   assign  autoCMD12_int_st[4]     = autoCMD12_index_err;
   assign  autoCMD12_int_st[7:5]   = 3'b0;

    always@( posedge clk or posedge soft_rst_cmd ) 
    begin 
        if( soft_rst_cmd )
        begin
            autoCMD12_timeout_err <= 1'b0;
            autoCMD12_crc_err           <= 1'b0;
            autoCMD12_end_err           <= 1'b0;
            autoCMD12_index_err     <= 1'b0;
        end
        else  
        begin
            if( cs & we & ~be_n[0] & ( addr == 8'b000_1111_0 ) & wdata[1] )  // offset 'h3C
                   autoCMD12_timeout_err <= 1'b0;
            else if( cmd_timeout_error_p & autoCMD12_active )
                autoCMD12_timeout_err <= 1'b1;
            
            if( cs & we & ~be_n[0] & ( addr == 8'b000_1111_0 ) & wdata[2] )  // offset 'h3C
                    autoCMD12_crc_err <= 1'b0;
            else if( cmd_crc_error_p & autoCMD12_active )
                autoCMD12_crc_err <= 1'b1;
            
            if( cs & we & ~be_n[0] & ( addr == 8'b000_1111_0 ) & wdata[3] )  // offset 'h3C
                    autoCMD12_end_err <= 1'b0;
            else if( resp_end_error_p & autoCMD12_active )
                autoCMD12_end_err <= 1'b1;
            
            if( cs & we & ~be_n[0] & ( addr == 8'b000_1111_0 ) & wdata[4] )  // offset 'h3C
                    autoCMD12_index_err <= 1'b0;
            else if( cmd_index_error_p & autoCMD12_active )
                autoCMD12_index_err <= 1'b1;

        end
    end

   assign  capabilities[5:0]   = sdclk_freq;
   assign  capabilities[6]     = 1'b0;
   assign  capabilities[7]     = 1'b1; 
   assign  capabilities[13:8]  = sdclk_freq;
   assign  capabilities[15:14] = 2'b0;
   assign  capabilities[17:16] = max_block_length;
   assign  capabilities[20:18] = 3'b0;
   assign  capabilities[21]    = high_speed_support;
   assign  capabilities[22]    = 1'b0;
   assign  capabilities[23]    = suspend_support;
   assign  capabilities[26:24] = volt_supported;
   assign  capabilities[31:27] = 5'b0;

   ///////////////////////////////////////////
   // CEATA interrupts
   assign  int_st[0]   = int_req | wakeup_req;           
   assign  int_st[7:1] = 6'b0;
   ///////////////////////////////////////////

   assign waddr_ram[0] = resp_addr[1] | autoCMD12_active;
   assign waddr_ram[1] = resp_addr[2] | autoCMD12_active;

   r256x18_256x18  REG_RAM(.WA({ 5'b0, waddr_ram, resp_addr[0] }),
        .RA     ({ 5'b0, addr[3:1] }),
        .WD     ({ 2'b0, resp_data }),
        .RD     (rd_ram),
        .WClk   (sd_clk),
        .WEN    (2'b11),
        .WD_SEL (write_resp),
        .RD_SEL (1'b1),
        .RClk   (clk)   
        );                                                       

endmodule
