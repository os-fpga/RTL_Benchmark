`include "../rtl/nlprg13.v"

module prng13_tb ();

parameter N = 13;

reg ck;
reg rst;
 

wire [N-1:0] o ;


nlprg13 nlprg13_u (
  .ck(ck),
  .rst(rst),
  .o(o)
);

// dump variables

initial begin 

        $dumpfile( "./wave/prng13_tb.vcd");
        $dumpvars( 0, prng13_tb );

end


integer f = -1 ; // file handler

// generate clocks and reset

initial begin

        f = $fopen("./log/prng13_tb.log","w+");

        rst = 1'b1     ;
        #5 rst = ~ rst ;
		#5 rst = ~ rst ;
		#5 rst = ~ rst ;
        ck  = 1'b1     ;
forever #5 ck  = ~ ck  ;

end

// generate counter

reg [N-1:0] cnt;

always@ ( posedge ck or posedge rst ) begin : cnt_process
 
  if ( rst ) cnt <= {N{1'b0}}  ;
  else       cnt <= cnt + 1'b1 ;
  
end

// delay reset

reg rst_d0;
reg rst_d1;

always@ ( posedge ck or posedge rst ) begin : reset_delay_process
 
  if ( rst ) begin
  
    rst_d0 <= 1'b1   ;
    rst_d1 <= 1'b1   ;

  end else begin

    rst_d0 <= 1'b0   ;
    rst_d1 <= rst_d0 ;

  end
  
end

// generate endsim

reg endsim;
reg pass;

wire prng_start_state = ( o   == {N{1'b0}});
wire cnt_start_state  = ( cnt == {N{1'b0}});


always@ ( posedge ck or posedge rst ) begin : lock_process
 
  if      ( rst                                                   ) begin
    endsim <= 1'b0 ;
    pass   <= 1'b0 ;
  end else if ( prng_start_state & ( ! rst_d1 )                   ) begin
    endsim <= 1'b1 ;
    pass   <= 1'b0 ;
  end else if ( cnt_start_state  & prng_start_state & ( ! rst_d1 ) ) begin
    endsim <= 1'b1 ;
    pass   <= 1'b1 ;
  end else if ( cnt_start_state  & ( ! rst_d1 )                   ) begin
    endsim <= 1'b1 ;
    pass   <= 1'b0 ;
  end

end


// display and finish

always@ ( posedge ck or posedge rst ) begin : display_process
 
  if          (( ! endsim ) && ( ! rst ))  begin
    $fdisplay(f,"%10d %10b", cnt , o) ;
  end else if ( endsim                  )  begin
    $fclose(f);
    $finish ;
  end
  
end

endmodule
