// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: sctag_mbist.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
// 
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
// 
// The above named program is distributed in the hope that it will be 
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
// 
// ========== Copyright Header End ============================================
///////////////////////////////////////////////////////////////////////////////
//
//
//    Released:           12/06/02
//    Description:        Memory BIST Controller for the L2 Cache
//    Block Type:         Control Block
//    Chip Name:          
//    Unit Name:         
//    Module:             mbist_engine
//    Where Instantiated: 
//
// Change: Increased the pipeline by one cycle 
///////////////////////////////////////////////////////////////////////////////


module sctag_mbist(/*AUTOARG*/
   // Outputs
   mbist_l2data_write, mbist_l2tag_read, mbist_l2tag_write, 
   mbist_arbctl_l2t_write, mbist_l2vuad_read, mbist_l2vuad_write, 
   mbist_l2data_index, mbist_l2data_way, mbist_l2data_word, 
   mbist_l2tag_index, mbist_l2tag_way, mbist_l2tag_dec_way, 
   mbist_l2vuad_index, mbist_l2vuad_vd, mbist_write_data, mbist_done, 
   mbist_l2data_fail, mbist_l2tag_fail, mbist_l2vuad_fail, 
   mbist_arb_l2d_en, mbist_arb_l2d_write, mbist_l2d_en, so, 
   // Inputs
   rclk, si, se, arst_l, grst_l, mbist_start, mbist_userdata_mode, 
   mbist_bisi_mode, mbist_loop_mode, mbist_loop_on_address, 
   mbist_stop_on_fail, mbist_stop_on_next_fail, mbist_l2data_data_in, 
   mbist_l2tag_data_in, mbist_l2vuad_data_in
   );




// /////////////////////////////////////////////////////////////////////////////
// Outputs
// /////////////////////////////////////////////////////////////////////////////

   output             mbist_l2data_write;
   output             mbist_l2tag_read;
   output             mbist_l2tag_write;
   output	      mbist_arbctl_l2t_write ; // POST_4.0
   output             mbist_l2vuad_read;
   output             mbist_l2vuad_write;
   output[9:0]        mbist_l2data_index;
   output[3:0]        mbist_l2data_way;
   output[3:0]        mbist_l2data_word;
   output[9:0]        mbist_l2tag_index;
   output[3:0]        mbist_l2tag_way;
   output	[11:0]	mbist_l2tag_dec_way ; // new output
   output[9:0]        mbist_l2vuad_index;
   output             mbist_l2vuad_vd;
   output[7:0]        mbist_write_data;

   output             mbist_done;
   output             mbist_l2data_fail;
   output             mbist_l2tag_fail;
   output             mbist_l2vuad_fail;
 
   output	mbist_arb_l2d_en; // POST_3.2 Right
   output	mbist_arb_l2d_write; // POST_3.2 Right
   output	mbist_l2d_en; // POST_3.2 Right


// /////////////////////////////////////////////////////////////////////////////
// Inputs
// /////////////////////////////////////////////////////////////////////////////

   input              rclk;
   input	      si;
   output	      so;
   input	      se;
   input	      arst_l, grst_l;

   input              mbist_start;
   input              mbist_userdata_mode;
   input              mbist_bisi_mode;
   input              mbist_loop_mode;
   input              mbist_loop_on_address;
   input              mbist_stop_on_fail;
   input              mbist_stop_on_next_fail;

   input[38:0]        mbist_l2data_data_in;
   input[27:0]        mbist_l2tag_data_in;
   input[25:0]        mbist_l2vuad_data_in;

// /////////////////////////////////////////////////////////////////////////////
// Wires
// /////////////////////////////////////////////////////////////////////////////


  wire [7:0] config_in; 
  wire [7:0] config_out;        
  wire start_transition;        
  wire reset_engine;    
  wire loop;    
  wire loop_on_address; 
  wire run;     
  wire bisi;    
  wire userdata_mode;   
  wire stop_on_fail;    
  wire stop_on_next_fail;       
  wire [7:0] userdata_in;       
  wire [7:0] userdata_out;      
  wire [15:0] useradd_in;       
  wire [15:0] useradd_out;      
  wire [28:0] control_in;       
  wire [28:0] control_out;      
  wire msb;     
  wire [1:0] array_sel; 
  wire [1:0] data_control;      
  wire address_mix;     
  wire [2:0] march_element;     
  wire address_lsb;     
  wire l2data_sel;      
  wire [17:0] address;  
  wire l2tag_sel;       
  wire l2vuad_sel;      
  wire [1:0] read_write_control;        
  wire four_cycle_march;        
  wire [28:0] qual_control_out; 
  wire [17:0] array_address;    
  wire upaddress_march; 
  wire array_write;     
  wire array_read;      
  wire initialize;      
  wire fail;    
  wire true_data;       
  wire [7:0] data_pattern;      
  wire second_time_through;     
  wire [1:0] qual_array_sel;    
  wire [7:0] l2data_read_pipe_in;       
  wire [7:0] l2data_read_pipe_out;      
  wire l2data_piped_read;       
  wire [4:0] l2tag_read_pipe_in;        
  wire [4:0] l2tag_read_pipe_out;       
  wire l2tag_piped_read;        
  wire [9:0] l2vuad_read_pipe_in;       
  wire [9:0] l2vuad_read_pipe_out;      
  wire l2vuad_piped_read;       
  wire [7:0] data_pipe_out1;    
  wire [7:0] data_pipe_out2;    
  wire [7:0] data_pipe_out3;    
  wire [7:0] data_pipe_out4;    
  wire [7:0] data_pipe_out5;    
  wire [7:0] data_pipe_out6;    
  wire [7:0] data_pipe_out7;    
  wire [7:0] data_pipe_out8;    
  wire [7:0] data_pipe_out9;    
  wire [7:0] data_pipe_out10;    
  wire [7:0] l2data_piped_data; 
  wire [7:0] l2tag_piped_data;  
  wire [7:0] l2vuad_piped_data; 
  wire [17:0] add_pipe_in;      
  wire [17:0] add_pipe_out1;    
  wire [17:0] add_pipe_out2;    
  wire [17:0] add_pipe_out3;    
  wire [17:0] add_pipe_out4;    
  wire [17:0] add_pipe_out5;    
  wire [17:0] add_pipe_out6;    
  wire [17:0] add_pipe_out7;    
  wire [17:0] add_pipe_out8;    
  wire [10:0] add_pipe_out9;    
  wire [17:0] l2data_address;   
  wire [13:0] l2tag_address;    
  wire [10:0] l2vuad_address;   
  wire [17:0] l2data_piped_address;     
  wire [13:0] l2tag_piped_address;      
  wire [10:0] l2vuad_piped_address;     
  wire [2:0] fail_reg_in;       
  wire [2:0] fail_reg_out;      
  wire qual_l2data_fail;        
  wire qual_l2tag_fail; 
  wire qual_l2vuad_fail;        
  wire beyond_last_fail;        
  wire l2data_fail;     
  wire l2tag_fail;      
  wire l2vuad_fail;     
  wire qual_fail;       
  wire mismatch;        
  wire [38:0] expect_data;      
  wire [38:0] compare_data;     
  wire [17:0] fail_add_reg_in;  
  wire [17:0] fail_add_reg_out; 
  wire [38:0] fail_data_reg_in; 
  wire [38:0] fail_data_reg_out;        
  wire [28:0] fail_control_reg_in;      
  wire [28:0] fail_control_reg_out;     


   wire             mbist_l2data_read_in;
   wire             mbist_l2data_write_in;
   wire             mbist_l2tag_read_in;
   wire             mbist_l2tag_write_in;
   wire             mbist_l2vuad_read_in;
   wire             mbist_l2vuad_write_in;
   wire[9:0]        mbist_l2data_index_in;
   wire[3:0]        mbist_l2data_way_in;
   wire[3:0]        mbist_l2data_word_in;
   wire[9:0]        mbist_l2tag_index_in;
   wire[3:0]        mbist_l2tag_way_in;
   wire[9:0]        mbist_l2vuad_index_in;
   wire             mbist_l2vuad_vd_in;
   wire[7:0]        mbist_write_data_in;
wire	[38:0]	mbist_l2data_data;
wire	[3:0]	dec_lo_way_sel_c1;
wire	[2:0]	 dec_hi_way_sel_c1 ;
wire	mbist_arb_l2d_en_in;
wire	mbist_arb_l2d_write_in;
  wire	[28:0]	 new_control_in ;
  wire	[16:0]	qual_control_out_plus1;
  wire	way_up_overflow, way_down_overflow ;
  wire		increment_count;
  wire	full_12_to_0, full_19_to_17, full_16_to_13 ;
  wire	l2data_fail_p, l2tag_fail_p, l2vuad_fail_p ;

wire	dbb_rst_l;
  wire	array_sel3_8, array_sel3_7, array_sel3_6, array_sel3_5;
  wire	array_sel3_4, array_sel3_3, array_sel3_2, array_sel3_1;
  wire	array_sel3_0, array_sel3_9, array_sel3_10 ;
  wire	engine_done;
wire	beyond_last_fail_d1;

///////////////////////////////////////////////////////////////////
 // Reset flop
 ///////////////////////////////////////////////////////////////////

 dffrl_async    #(1)    reset_flop      (.q(dbb_rst_l),
                                        .clk(rclk),
                                        .rst_l(arst_l),
                                        .din(grst_l),
                                        .se(se), .si(), .so());


// /////////////////////////////////////////////////////////////////////////////
//
// MBIST Config Register
//
// /////////////////////////////////////////////////////////////////////////////
//
// A low to high transition on mbist_start will reset and start the engine.  
// mbist_start must remain active high for the duration of MBIST.  
// If mbist_start deasserts the engine will stop but not reset.
// Once MBIST has completed mbist_done will assert and the fail status
// signals will be valid.  
// To run MBIST again the mbist_start signal must transition low then high.
//
// Loop on Address will disable the address mix function.
//
/////////////////////////////////////////////////////
//      LOOP_ON_ADDRESS         7
//      STOP_ON_NEXT_FAIL       6
//      STOP_ON_FAIL            5
//      LOOP_MODE               4
//      USER_DATA_MODE          3
//      BISI_MODE               2
//      START_D1                1
//      START                   0
/////////////////////////////////////////////////////
//
// /////////////////////////////////////////////////////////////////////////////



  dff_s #(8) config_reg (
		.se(se), .si(), .so(),
               .clk      ( rclk                  ),
               .din      ( config_in[7:0]       ),
               .q        ( config_out[7:0]      ));



  assign config_in[0]        =    mbist_start;
  assign config_in[1]        =    config_out[0];
  assign start_transition    =    config_out[0]     &&   ~config_out[1];
  assign reset_engine        =    start_transition  ||  ((loop  ||  loop_on_address)  &&  mbist_done) || ~dbb_rst_l ;
  assign run                 =    config_out[1]     &&   ~engine_done;

  assign config_in[2]        =    start_transition   ?   mbist_bisi_mode:      config_out[2];
  assign bisi                =    config_out[2];

  assign config_in[3]        =    start_transition   ?   mbist_userdata_mode:  config_out[3];
  assign userdata_mode       =    config_out[3];

  assign config_in[4]        =    start_transition   ?   mbist_loop_mode:  config_out[4];
  assign loop                =    config_out[4];

  assign config_in[5]        =    start_transition   ?   mbist_stop_on_fail:  config_out[5];
  assign stop_on_fail        =    config_out[5];

  assign config_in[6]        =    start_transition   ?   mbist_stop_on_next_fail:  config_out[6];
  assign stop_on_next_fail   =    config_out[6];

  assign config_in[7]        =    start_transition   ?   mbist_loop_on_address:  config_out[7];
  assign loop_on_address     =    config_out[7];


  dff_s #(8) userdata_reg (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( userdata_in[7:0]       ),
                 .q        ( userdata_out[7:0]      ));


  assign userdata_in[7:0]    =    userdata_out[7:0];




  dff_s #(16) user_address_reg (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( useradd_in[15:0]       ),
                 .q        ( useradd_out[15:0]      ));

  assign useradd_in[15:0]    =    useradd_out[15:0];


// /////////////////////////////////////////////////////////////////////////////
//
// MBIST Control Register
//
// /////////////////////////////////////////////////////////////////////////////
// Address mix may not be appropriate for l2data since we must move way to way
// fast to enabel consecutive cycle accesses.
// One of 2 MSBs of word select must change on consecutive cycles.
// /////////////////////////////////////////////////////////////////////////////


   dff_s #(29) control_reg  (
		.se(se), .si(), .so(),
                      .clk   ( rclk                        ),
                      .din   ( control_in[28:0]           ),
                      .q     ( control_out[28:0]          ));


  assign   address_lsb               =     l2data_sel                        ?    control_out[0]:   1'b1;
  assign   address[17:0]             =    (loop_on_address &&  l2data_sel)   ?   {14'h3FFF, control_out[5:3],  address_lsb}:
                                           loop_on_address                   ?   {13'h1FFF, control_out[6:3],  address_lsb}:
                                    	l2tag_sel                         ?   {3'h7,  control_out[16:13], control_out[12:3], address_lsb}:
                                    	l2vuad_sel                        ?   {6'h3f, control_out[13], control_out[12:3], address_lsb}:
                                    					  {control_out[19:13], control_out[12:3], address_lsb};


  assign   msb                       =     control_out[28];
  assign   array_sel[1:0]            =     loop_on_address    ?   {1'b1, control_out[26]}:   control_out[27:26];
  assign   data_control[1:0]         =     userdata_mode ? 2'h3 : control_out[25:24];
  assign   address_mix               =     loop_on_address    ?   1'b1:   control_out[23];
  assign   march_element[2:0]        =     control_out[22:20];
  assign   read_write_control[1:0]   =     four_cycle_march   ?   control_out[2:1]:   {1'b1, control_out[1]};

  assign   qual_control_out[28:0]    =     {msb, array_sel[1:0], data_control[1:0], address_mix, march_element[2:0], 
                                            address[17:1], read_write_control[1:0], address[0]};

  // Create a 4 state machine.
  // way_up_overflow: 	During an upaddress march, the way should toggle from 0-11 
  //			and switch back to 0.
  // way_down_overflow: During a down address march or a transition from one down address march element
  //			to another, the way should switch from 15 to 4.
  //			During a transition from a upaddress march element to a down 
  //			address march element, the way switches from 11 to 4 
  // increment count:	Asserted everytime the counter reaches a 1M boundary 


  assign   full_12_to_0 = (control_out[12:0] == 13'h1FFF) |
			(( control_out[12:1] == 12'hFFF ) & ~l2data_sel );

  assign   full_19_to_17 = ( control_out[19:17] == 3'h7 ) ;

  assign   full_16_to_13 = ( control_out[16:13] == 4'hF ) ;

  assign   way_up_overflow = ~l2vuad_sel & ( full_12_to_0 &
				upaddress_march & 
			      ( control_out[16:13] == 4'd11) )  ; // up-up ( same march element ) transition.

  assign   way_down_overflow = ~l2vuad_sel &
			(( 	((march_element[2:0] == 3'h2 ) | 
				  (march_element[2:0] == 3'h6 )) 
				& way_up_overflow & ( control_out[19:17] == 3'h7 ) ) | // upaddress march -down address march xsition
			( 	( (march_element[2:0] == 3'h3 ) |  
			  	  (march_element[2:0] == 3'h4 ) ) &  
				full_12_to_0 & full_19_to_17  &
				full_16_to_13 ) | // down-down ( different march element )trasnsition
			( ~upaddress_march & full_12_to_0 & full_16_to_13 & 
				( control_out[19:17] != 3'h7 )) ) ; // down-down ( same march element )trasnsition.

  assign   increment_count = ( way_up_overflow | way_down_overflow ) | 
			( full_19_to_17 & full_16_to_13 & full_12_to_0 )  ;

				
				
  // New code added for the conversion from a 16 way state m/c to 
  // a 12-way FSm
  assign   qual_control_out_plus1 =  qual_control_out[16:0]   +  17'b1;

  assign   new_control_in[12:0] = qual_control_out_plus1[12:0] ;

  assign   new_control_in[16:13] = ( way_down_overflow ) ? 4'd4 : 
				   ( way_up_overflow ) ? 4'd0 : qual_control_out_plus1[16:13] ;

  assign   new_control_in[28:17] =  (increment_count) ? (qual_control_out[28:17] + 12'b1):
							qual_control_out[28:17]  ;


  assign   control_in[28:0]          =     reset_engine        ?   29 'b0:
                                          ~run                 ?   qual_control_out[28:0]:
								   new_control_in[28:0] ;


  assign   array_address[17:1]       =     upaddress_march     ?   address[17:1]:    ~address[17:1];
  // Transitions from upaddress marches to downaddress march elements was causing
  // a column offset violation. To prevent this the MSB of the word_en is not inverted.
  assign   array_address[0]       =     address[0];

  //assign   array_address[10:1]       =     address[10:1] ;
  //assign   array_address[17:11]       =     upaddress_march     ?   
  //address[17:11]:    ~address[17:11];


  assign   array_write               =    ~run                 ?    1'b0:
                                           four_cycle_march    ?  
					(read_write_control[1] ^ read_write_control[0]):  read_write_control[0];

  assign   array_read                =    ~array_write        &&  run  &&  ~initialize;

  assign   engine_done                =    (stop_on_fail  &&  fail)      ||  (stop_on_next_fail  &&  fail)         ||
                                          (bisi  &&  march_element[0])  ||   array_sel3_0 ;

  assign   mbist_done 		      = (stop_on_fail  &&  fail)      |  (stop_on_next_fail  &&  fail) |
					(bisi  &&  march_element[0])  |  array_sel3_10 ;

  assign   mbist_write_data_in[7:0]     =     true_data           ?   data_pattern[7:0]:      ~data_pattern[7:0];


  assign   second_time_through       =    ~loop_on_address    &&   address_mix;
  assign   initialize                =    (march_element[2:0] == 3'b000)  &&  ~second_time_through;
  assign   four_cycle_march          =    (march_element[2:0] == 3'h6)    ||  (march_element[2:0] == 3'h7);
  assign   upaddress_march           =    (march_element[2:0] == 3'h0)    ||  (march_element[2:0] == 3'h1) ||
                                          (march_element[2:0] == 3'h2)    ||  (march_element[2:0] == 3'h6);

  assign   true_data                 =     four_cycle_march    ?   (read_write_control[1]  ^  ~march_element[0]):
                                                                   (read_write_control[0]  ^  ~march_element[0]);
  assign   data_pattern[7:0]         =     userdata_mode                ?    userdata_out[7:0]:
                                           bisi                         ?    8'hFF:                    // Read 8'hFF write 8'h00.
                                          (data_control[1:0] == 2'h0)   ?    8'hAA:
                                          (data_control[1:0] == 2'h1)   ?    8'h99:
                                          (data_control[1:0] == 2'h2)   ?    8'hCC:
                                                                             8'h00;

  assign   qual_array_sel[1:0]         =   loop_on_address   ?   useradd_out[15:14]:  array_sel[1:0];
  assign   l2data_sel                  =   ( qual_array_sel[1:0]  ==  2'h0) ;
  assign   l2tag_sel                   =   (qual_array_sel[1:0]  ==  2'h1) ;
  assign   l2vuad_sel                =   qual_array_sel[1:0]  ==  2'h2  ;
  //assign   l2vuad_sel                  =   ( qual_array_sel[1:0]  ==  2'h2 ) | bisi;

// /////////////////////////////////////////////////////////////////////////////
// Address and control outputs.
// Pipelines for each array
// /////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////
// Data array: 			C1 	C2	C3	C4	C5	C6	C7	C8
//			
//		piped_rd=	7	 6	5	4	3	2	1	0
//
//		data pipe	pipe1	2	3	4	5	6	7	8
/////////////////////////////////////////////////////////////////////////////////////////////////
// /////////////////////////////////////////////////////////////////////////////
// Tag	array:			PX2	C1	C2	C3	C4
//
//		piped_rd = 	4	3	2	1	0
//
//		data_pipe	pipe1	2	3	4	5
// /////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// VUAD array: 			PX1	PX2	C1 	C2	C3	C4	C5	C6	C7	C8
//			
//		piped_rd=	9	8	7	 6	5	4	3	2	1	0
//
//		data pipe	pipe1	2	3	4	5	6	7	8	9	10
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

  assign   mbist_l2data_word_in[3:0]      =     loop_on_address   ? {array_address[0], useradd_out[13:11]}:    {array_address[0], array_address[17:15]};
  assign   mbist_l2data_way_in[3:0]       =     loop_on_address   ?  useradd_out[10:7]:                         array_address[14:11];
  assign   mbist_l2data_index_in[9:0]     =     loop_on_address   ? {useradd_out[6:0], array_address[3:1]}:     array_address[10:1];

  assign   mbist_l2tag_way_in[3:0]        =     loop_on_address   ?  useradd_out[9:6]:                          array_address[14:11];
  assign   mbist_l2tag_index_in[9:0]      =     loop_on_address   ? {useradd_out[5:0], array_address[4:1]}:     array_address[10:1];

  assign   mbist_l2vuad_vd_in             =     loop_on_address   ?  useradd_out[6]:                            array_address[11];
  assign   mbist_l2vuad_index_in[9:0]     =     loop_on_address   ? {useradd_out[5:0], array_address[4:1]}:     array_address[10:1];



  assign   mbist_l2data_read_in          =     l2data_sel            &&  array_read;
  assign   mbist_l2data_write_in          =    (l2data_sel  ||  bisi) &&  array_write;

  assign   mbist_l2tag_read_in            =     l2tag_sel             &&  array_read;
  assign   mbist_l2tag_write_in           =    (l2tag_sel   ||  bisi) &&  array_write;

  assign   mbist_l2vuad_read_in           =     l2vuad_sel            &&  array_read;
  assign   mbist_l2vuad_write_in          =    (l2vuad_sel  ||  bisi) &&  array_write;


  
  dff_s #(1) ff_mbist_l2data_write (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_l2data_write_in),
                 .q        ( mbist_l2data_write));


  //// added post_3.2 for timing reasons ///////////
  assign	mbist_arb_l2d_write_in = mbist_l2data_write_in ;
  assign	mbist_arb_l2d_en_in = ( mbist_l2data_read_in | 
					mbist_arb_l2d_write_in ) ;
  
  dff_s #(1) ff_mbist_arb_l2d_write (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_arb_l2d_write_in),
                 .q        ( mbist_arb_l2d_write));

  dff_s #(1) ff_mbist_arb_l2d_en (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_arb_l2d_en_in),
                 .q        ( mbist_arb_l2d_en));

  dff_s #(1) ff_mbist_l2d_en (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_arb_l2d_en_in),
                 .q        ( mbist_l2d_en));


  //// added post_3.2 for timing reasons ///////////




  dff_s #(1) ff_mbist_l2tag_read (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_l2tag_read_in),
                 .q        ( mbist_l2tag_read));
  
  dff_s #(1) ff_mbist_l2tag_write (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_l2tag_write_in),
                 .q        ( mbist_l2tag_write));

  dff_s #(1) ff_mbist_arbctl_l2t_write (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_l2tag_write_in),
                 .q        ( mbist_arbctl_l2t_write));


  
  dff_s #(1) ff_mbist_l2vuad_read (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_l2vuad_read_in),
                 .q        ( mbist_l2vuad_read));
  
  dff_s #(1) ff_mbist_l2vuad_write (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( mbist_l2vuad_write_in),
                 .q        ( mbist_l2vuad_write));



  assign  l2data_address[17:0]         =  {mbist_l2data_word_in[3:0], mbist_l2data_way_in[3:0], 
						mbist_l2data_index_in[9:0]};

  assign  l2tag_address[13:0]          =  {mbist_l2tag_way_in[3:0], mbist_l2tag_index_in[9:0]};

  assign  l2vuad_address[10:0]         =  {mbist_l2vuad_vd_in, mbist_l2vuad_index_in[9:0]};

  assign  add_pipe_in[17:0]            =   l2data_sel   ?          l2data_address[17:0]:
                                           l2tag_sel    ?  {4'h0,  l2tag_address[13:0]}:
                                           l2vuad_sel   ?  {7'h00, l2vuad_address[10:0]}:
                                                                              18'h00000;


// /////////////////////////////////////////////////////////////////////////////
// Pipeline for Read, Data, and Address
// /////////////////////////////////////////////////////////////////////////////
// Pipelining read, data, and address so when fail occurs we have information for
// bitmapping and redundant fuse blow operation.
// /////////////////////////////////////////////////////////////////////////////

  assign l2data_read_pipe_in[7:0]    =    reset_engine   ?   8'h00:  
				{mbist_l2data_read_in, l2data_read_pipe_out[7:1]};
  assign l2data_piped_read           =    l2data_read_pipe_out[0];

  assign l2tag_read_pipe_in[4:0]    =    reset_engine   ?   5'h00:  
				{mbist_l2tag_read_in, l2tag_read_pipe_out[4:1]};
  assign l2tag_piped_read           =    l2tag_read_pipe_out[0];

  assign l2vuad_read_pipe_in[9:0]    =    reset_engine   ?   10'h000:  
				{mbist_l2vuad_read_in, l2vuad_read_pipe_out[9:1]};
  assign l2vuad_piped_read           =    l2vuad_read_pipe_out[0];


  // Px2  - C8
  dff_s #(8) l2data_read_pipe_reg (
		.se(se), .si(), .so(),
                   .clk      ( rclk                         ),
                   .din      ( l2data_read_pipe_in[7:0]    ),
                   .q        ( l2data_read_pipe_out[7:0]   ));


  // Px1  - C4
  dff_s #(5) l2tag_read_pipe_reg (
		.se(se), .si(), .so(),
                   .clk      ( rclk                        ),
                   .din      ( l2tag_read_pipe_in[4:0]    ),
                   .q        ( l2tag_read_pipe_out[4:0]   ));


  // Px1  - C8
  dff_s #(10) l2vuad_read_pipe_reg (
		.se(se), .si(), .so(),
                   .clk      ( rclk                         ),
                   .din      ( l2vuad_read_pipe_in[9:0]    ),
                   .q        ( l2vuad_read_pipe_out[9:0]   ));




  // Worst case pipeline depth = PX1-C8 for the VUAD
  // array. Hence the data needs to be flopped for 
  // 9 cycles.

  dff_s #(8) data_pipe_reg1 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( mbist_write_data_in[7:0]  ),
                   .q        ( data_pipe_out1[7:0]    ));

  assign	mbist_write_data = data_pipe_out1[7:0] ;

  dff_s #(8) data_pipe_reg2 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out1[7:0]    ),
                   .q        ( data_pipe_out2[7:0]    ));

  dff_s #(8) data_pipe_reg3 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out2[7:0]    ),
                   .q        ( data_pipe_out3[7:0]    ));

  dff_s #(8) data_pipe_reg4 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out3[7:0]    ),
                   .q        ( data_pipe_out4[7:0]    ));

  dff_s #(8) data_pipe_reg5 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out4[7:0]    ),
                   .q        ( data_pipe_out5[7:0]    ));

  dff_s #(8) data_pipe_reg6 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out5[7:0]    ),
                   .q        ( data_pipe_out6[7:0]    ));

  dff_s #(8) data_pipe_reg7 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out6[7:0]    ),
                   .q        ( data_pipe_out7[7:0]    ));

  dff_s #(8) data_pipe_reg8 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out7[7:0]    ),
                   .q        ( data_pipe_out8[7:0]    ));

  dff_s #(8) data_pipe_reg9 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out8[7:0]    ),
                   .q        ( data_pipe_out9[7:0]    ));

  dff_s #(8) data_pipe_reg10 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( data_pipe_out9[7:0]    ),
                   .q        ( data_pipe_out10[7:0]    ));


  assign l2data_piped_data[7:0]  =  data_pipe_out8[7:0];
  assign l2tag_piped_data[7:0]   =  data_pipe_out5[7:0];
  assign l2vuad_piped_data[7:0]  =  data_pipe_out10[7:0];


  // Worst case pipeline depth = PX1-C8 for the VUAD
  // array. Hence the data needs to be flopped for 
  // 9 cycles.


  dff_s #(18) add_pipe_reg1 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                        ),
                   .din      ( add_pipe_in[17:0]          ),
                   .q        ( add_pipe_out1[17:0]        ));

  assign	mbist_l2data_word = add_pipe_out1[17:14] ;
  assign	mbist_l2data_way = add_pipe_out1[13:10] ;
  assign	mbist_l2data_index = add_pipe_out1[9:0] ;

  assign	mbist_l2tag_way = add_pipe_out1[13:10] ;

  // MBIST l2tag way decoded for accessing the tag array


  
assign  dec_lo_way_sel_c1[0] = ( mbist_l2tag_way[1:0]==2'd0 );
assign  dec_lo_way_sel_c1[1] = ( mbist_l2tag_way[1:0]==2'd1 );
assign  dec_lo_way_sel_c1[2] = ( mbist_l2tag_way[1:0]==2'd2 );
assign  dec_lo_way_sel_c1[3] = ( mbist_l2tag_way[1:0]==2'd3 );


assign  dec_hi_way_sel_c1[0] = ( mbist_l2tag_way[3:2]==2'd0 ) ;
assign  dec_hi_way_sel_c1[1] = ( mbist_l2tag_way[3:2]==2'd1 ) ;
assign  dec_hi_way_sel_c1[2] = ( mbist_l2tag_way[3:2]==2'd2 ) ;



assign  mbist_l2tag_dec_way[0] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[0] ; // 0000

assign  mbist_l2tag_dec_way[1] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[1] ; // 0001

assign  mbist_l2tag_dec_way[2] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[2] ; // 0010

assign  mbist_l2tag_dec_way[3] = dec_hi_way_sel_c1[0] &
                                dec_lo_way_sel_c1[3] ; // 0011

assign  mbist_l2tag_dec_way[4] =  dec_hi_way_sel_c1[1] &
                                dec_lo_way_sel_c1[0] ; // 0100 or 1100

assign  mbist_l2tag_dec_way[5] =  dec_hi_way_sel_c1[1] &
                                dec_lo_way_sel_c1[1] ; // 0101 or 1101

assign  mbist_l2tag_dec_way[6] = dec_hi_way_sel_c1[1] &
                                dec_lo_way_sel_c1[2] ; // 0110 or 1110

assign  mbist_l2tag_dec_way[7] =  dec_hi_way_sel_c1[1] & 
                                dec_lo_way_sel_c1[3] ; // 0111 or 1111

assign  mbist_l2tag_dec_way[8] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[0] ; // 1000

assign  mbist_l2tag_dec_way[9] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[1] ; // 1001

assign  mbist_l2tag_dec_way[10] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[2] ; // 1010

assign  mbist_l2tag_dec_way[11] = dec_hi_way_sel_c1[2] &
                                dec_lo_way_sel_c1[3] ; // 1011


 

  assign	mbist_l2tag_index = add_pipe_out1[9:0] ;

  assign	mbist_l2vuad_vd = add_pipe_out1[10] ;
  assign	mbist_l2vuad_index = add_pipe_out1[9:0] ;

  dff_s #(18) add_pipe_reg2 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out1[17:0]    ),
                   .q        ( add_pipe_out2[17:0]    ));

  dff_s #(18) add_pipe_reg3 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out2[17:0]    ),
                   .q        ( add_pipe_out3[17:0]    ));

  dff_s #(18) add_pipe_reg4 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out3[17:0]    ),
                   .q        ( add_pipe_out4[17:0]    ));

  dff_s #(18) add_pipe_reg5 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out4[17:0]    ),
                   .q        ( add_pipe_out5[17:0]    ));

  dff_s #(18) add_pipe_reg6 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out5[17:0]    ),
                   .q        ( add_pipe_out6[17:0]    ));

  dff_s #(18) add_pipe_reg7 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out6[17:0]    ),
                   .q        ( add_pipe_out7[17:0]    ));

  dff_s #(18) add_pipe_reg8 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out7[17:0]    ),
                   .q        ( add_pipe_out8[17:0]    ));

  dff_s #(11) add_pipe_reg9 (
		.se(se), .si(), .so(),
                   .clk      ( rclk                    ),
                   .din      ( add_pipe_out8[10:0]    ),
                   .q        ( add_pipe_out9[10:0]    ));


  assign  l2data_piped_address[17:0]   =   add_pipe_out8[17:0];
  assign  l2tag_piped_address[13:0]    =   add_pipe_out5[13:0];
  assign  l2vuad_piped_address[10:0]   =   add_pipe_out9[10:0];





// /////////////////////////////////////////////////////////////////////////////
// Shared Fail Detection
// /////////////////////////////////////////////////////////////////////////////
// Be careful of array overlap.  Long pipe followed by short could result in
// both active at comparator simultaneously.
// Current test order is data(7), tag(5), vuad(9).  This is OK.
// /////////////////////////////////////////////////////////////////////////////



  // data from retdp is flopped in order to meet timing.
  dff_s #(39) ff_mbist_l2data_data       (
		.se(se), .si(), .so(),
                   .clk      ( rclk                ),
                   .din      ( mbist_l2data_data_in[38:0]   ),
                   .q        ( mbist_l2data_data[38:0]  ));



  // data coming from the data is piped to c9.
  // data from vuad is c8 data
  // data from the tag is c4 data.

  assign    compare_data[38:0]    =    l2data_piped_read   ?     ( mbist_l2data_data[38:0]):
                                       l2tag_piped_read    ?     ({11'h000,  mbist_l2tag_data_in[27:0]}):
                                       l2vuad_piped_read   ?     ({{13'h0000, mbist_l2vuad_data_in[25:0]}}): 
								39'b0;

  assign    mismatch              =    expect_data[38:0]   !=     compare_data[38:0];



  assign    expect_data[38:0]     =    l2data_piped_read   ?     
					{l2data_piped_data[6:0], {4{l2data_piped_data[7:0]}}}:
                                       l2tag_piped_read    ?     
					{11'h000,  l2tag_piped_data[3:0], {3{l2tag_piped_data[7:0]}}}:
                                       l2vuad_piped_read   ?     
					{13'h0000, l2vuad_piped_data[1:0], {3{l2vuad_piped_data[7:0]}}}:
                                                                  39'b0;
  assign    l2data_fail_p           =    l2data_piped_read  &&  mismatch;
  assign    l2tag_fail_p            =    l2tag_piped_read   &&  mismatch;
  assign    l2vuad_fail_p           =    l2vuad_piped_read  &&  mismatch;


  dff_s #(1) ff_l2vuad_fail       (
			.se(se), .si(), .so(),
                   .clk      ( rclk                ),
                   .din      (l2vuad_fail_p),
                   .q        (l2vuad_fail));

  dff_s #(1) ff_l2tag_fail       (
			.se(se), .si(), .so(),
                   .clk      ( rclk                ),
                   .din      (l2tag_fail_p),
                   .q        (l2tag_fail));

  dff_s #(1) ff_l2data_fail       (
			.se(se), .si(), .so(),
                   .clk      ( rclk                ),
                   .din      (l2data_fail_p),
                   .q        (l2data_fail));

  assign    fail_reg_in[2:0]      =    reset_engine      ?    
		3'h0: {qual_l2data_fail, qual_l2tag_fail, qual_l2vuad_fail}  |  fail_reg_out[2:0];

  dff_s #(3) fail_reg       (
		.se(se), .si(), .so(),
                   .clk      ( rclk                ),
                   .din      ( fail_reg_in[2:0]   ),
                   .q        ( fail_reg_out[2:0]  ));


  assign    qual_l2data_fail      =  (!stop_on_next_fail  || (stop_on_next_fail &&  beyond_last_fail_d1))  &&  l2data_fail;
  assign    qual_l2tag_fail       =  (!stop_on_next_fail  || (stop_on_next_fail &&  beyond_last_fail_d1))  &&  l2tag_fail;
  assign    qual_l2vuad_fail      =  (!stop_on_next_fail  || (stop_on_next_fail &&  beyond_last_fail_d1))  &&  l2vuad_fail;
  assign    qual_fail             =    qual_l2data_fail   ||  qual_l2tag_fail   ||  qual_l2vuad_fail;

  assign    mbist_l2data_fail     =    fail_reg_out[2];
  assign    mbist_l2tag_fail      =    fail_reg_out[1];
  assign    mbist_l2vuad_fail     =    fail_reg_out[0];
  assign    fail                  =   |fail_reg_out[2:0];


// /////////////////////////////////////////////////////////////////////////////
// Fail Address and Data Capture and Control Reg Store
// /////////////////////////////////////////////////////////////////////////////
// Consider some bits in control reg get set to b'1 to shorten address space later in sequence.
// How does this affect beyond_last_fail behavior?  Looks OK.
// /////////////////////////////////////////////////////////////////////////////




  dff_s #(18) fail_add_reg(
		.se(se), .si(), .so(),
                   .clk      ( rclk                        ),
                   .din      ( fail_add_reg_in[17:0]   ),
                   .q        ( fail_add_reg_out[17:0]  ));


  assign fail_add_reg_in[17:0]     =  reset_engine              ?    18'h00000:
                                      qual_l2data_fail          ?    l2data_piped_address[17:0]:
                                      qual_l2tag_fail           ?   {4'h0,  l2tag_piped_address[13:0]}:
                                      qual_l2vuad_fail          ?   {7'h00, l2vuad_piped_address[10:0]}:
                                                                     fail_add_reg_out[17:0];


  dff_s #(39) fail_data_reg(
		.se(se), .si(), .so(),
                   .clk      ( rclk                      ),
                   .din      ( fail_data_reg_in[38:0]   ),
                   .q        ( fail_data_reg_out[38:0]  ));


  assign fail_data_reg_in[38:0]     =  reset_engine     ?   39'h0:
                                       qual_fail        ?   compare_data[38:0]:
                                                            fail_data_reg_out[38:0];



  dff_s #(29) fail_control_reg(
		.se(se), .si(), .so(),
                   .clk      ( rclk                         ),
                   .din      ( fail_control_reg_in[28:0]   ),
                   .q        ( fail_control_reg_out[28:0]  ));


  assign fail_control_reg_in[28:0]     = (reset_engine && !mbist_stop_on_next_fail)    ?   29'b0:
                                          qual_fail                                    ?   qual_control_out[28:0]:
                                                                                           fail_control_reg_out[28:0];


  assign  beyond_last_fail  =  ( qual_control_out[28:0]    >=    fail_control_reg_out[28:0]);

  dff_s #(1) ff_beyond_last_fail_d1 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( beyond_last_fail),
                 .q        ( beyond_last_fail_d1));

  



  // --------------\/-----------pipeline mbist done ---------------\/------------------------
  // IN the following description pipe_rd refers to l2vuad_read_pipe_out
  // mbist_done is asserted after the control_out counter increments to 
  // control_out[27:26] = 2'b3.
  // cyc=-1		0		1		....	10
  // 	array_sel=2	array_sel=3	vuad_rd=0
  //			vuad_rd=1	
  //			piped_rd[9]=1	pipe_rd[9]=0		piped_rd[0]=0
  //
  // --------------\/-----------pipeline mbist done ---------------\/---------------------------

  assign  array_sel3_0 =  &array_sel[1:0] ;

  dff_s #(1) ff_array_sel3_1 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_0),
                 .q        ( array_sel3_1));
  
  dff_s #(1) ff_array_sel3_2 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_1),
                 .q        ( array_sel3_2));
  
  dff_s #(1) ff_array_sel3_3 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_2),
                 .q        ( array_sel3_3));
  
  dff_s #(1) ff_array_sel3_4 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_3),
                 .q        ( array_sel3_4));
  
  dff_s #(1) ff_array_sel3_5 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_4),
                 .q        ( array_sel3_5));
  
  dff_s #(1) ff_array_sel3_6 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_5),
                 .q        ( array_sel3_6));
  
  dff_s #(1) ff_array_sel3_7 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_6),
                 .q        ( array_sel3_7));
  
  dff_s #(1) ff_array_sel3_8 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_7),
                 .q        ( array_sel3_8));
  
  dff_s #(1) ff_array_sel3_9 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_8),
                 .q        ( array_sel3_9));
  
  dff_s #(1) ff_array_sel3_10 (
		.se(se), .si(), .so(),
                 .clk      ( rclk                    ),
                 .din      ( array_sel3_9),
                 .q        ( array_sel3_10));
  



// /////////////////////////////////////////////////////////////////////////////
endmodule
// /////////////////////////////////////////////////////////////////////////////
