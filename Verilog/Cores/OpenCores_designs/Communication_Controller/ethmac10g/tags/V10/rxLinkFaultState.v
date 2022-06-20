`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    17:11:43 12/19/05
// Design Name:    
// Module Name:    rxLinkFaultState
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module rxLinkFaultState(rxclk_2x, reset, local_fault, remote_fault, link_fault);
    input rxclk_2x;
    input reset;
    input local_fault;
    input remote_fault;
    output[1:0] link_fault;
	 
	 parameter TP =1;
	 parameter IDLE = 0, LinkFaultDetect = 1, NewFaultType = 2, GetFault = 3; 

	 //------------------------------------------------
	 // Link	Fault Signalling Statemachine
	 //------------------------------------------------
	 wire  fault_type;
	 wire  get_one_fault;
	 wire  no_new_type;

	 reg[2:0] linkstate;
	 reg[7:0] col_cnt;
	 reg[1:0] seq_cnt;
	 reg[1:0] seq_type;
	 reg[1:0] last_seq_type;
	 reg[1:0] link_fault;
	 reg      reset_col_cnt;

	 assign fault_type = {local_fault, remote_fault};
	 assign get_one_fault = local_fault | remote_fault;
	 assign no_new_type = (seq_type == last_seq_type);
	 assign col_cnt_128 = (col_cnt == 127);

	 always@(posedge rxclk_2x or posedge reset)begin
	     if (reset) begin
			   seq_type <=#TP 0;
				seq_cnt <=#TP 0;
				last_seq_type <=#TP 0;
			  	reset_col_cnt<= #TP 1;
				link_fault <=#TP 2'b00;
				linkstate<= #TP IDLE;
	  	  end
		  else begin	 
			   seq_type <= #TP fault_type;	
			   last_seq_type <=#TP seq_type;
			   case (linkstate)
			      IDLE: begin
					     linkstate <=#TP IDLE;
					     reset_col_cnt <= #TP 1;
						  seq_cnt <= #TP 0;
						  link_fault <= #TP 2'b00;	
					     if (get_one_fault)
								linkstate<=#TP LinkFaultDetect;
					end

           	   LinkFaultDetect: begin
					     linkstate <=#TP LinkFaultDetect;
						  reset_col_cnt <=#TP 1;
					     if (get_one_fault & no_new_type)
						     if (seq_cnt < 3) 
						        seq_cnt <=#TP seq_cnt + 1;
							  else linkstate <=#TP GetFault;
						  else if(~get_one_fault) 
						       if(col_cnt_128) begin
						  	  	    linkstate <=#TP IDLE;
									 reset_col_cnt <=#TP 1;
								 end
								 else reset_col_cnt <=#TP 0;
						  else if(get_one_fault & ~no_new_type)
						        linkstate <=#TP NewFaultType;
					end

            	NewFaultType: begin
			      	  seq_cnt <=#TP 0;  
						  linkstate <=#TP LinkFaultDetect;
						  reset_col_cnt<=#TP 1;
            	end

					GetFault: begin
					 	  linkstate <=#TP GetFault;
						  reset_col_cnt <=#TP 1;
                    if (get_one_fault & no_new_type) 
								link_fault <=#TP seq_type;	
				        else if (~get_one_fault)	begin
						         reset_col_cnt<=#TP 0;
									if(col_cnt_128)
							        linkstate <=#TP IDLE;
						  end
                    else if (get_one_fault &	~no_new_type)
						      linkstate <=#TP NewFaultType;
					end 	  	
			   endcase
	    end
  	 end

	 always@(posedge rxclk_2x or posedge reset) begin
	  	    if (reset) 
			    col_cnt <=#TP 0;
          else if (reset_col_cnt) 
			    col_cnt <=#TP 0;
          else
			    col_cnt <=#TP col_cnt + 1;
    end

endmodule
