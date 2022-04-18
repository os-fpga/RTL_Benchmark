module prng8_tb ();

reg ck;
reg rst;
wire o0;
wire o1;
wire o2;
wire o3;
wire o4;
wire o5;
wire o6;
wire o7;

 
nlprg8 nlprg8_u (
  .ck(ck),
  .rst(rst),
  .o0(o0),
  .o1(o1),
  .o2(o2),
  .o3(o3),
  .o4(o4),
  .o5(o5),
  .o6(o6),
  .o7(o7)
);

// dump variables

initial begin 

        $dumpfile( "./wave/prng8_tb.vcd");
        $dumpvars( 0, prng8_tb );

end

parameter N = 8;

wire [N-1:0] o = {o0,o1,o2,o3,o4,o5,o6,o7};

integer f = -1 ; // file handler

// generate clocks and reset

initial begin

        f = $fopen("./log/nlprg8_tb.log","w+");

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


always@ ( posedge ck or posedge rst ) begin : end_sim_process
 
  if      ( rst                                                   ) begin
    endsim <= 1'b0 ;
    pass   <= 1'b0 ;

  end else if ( prng_start_state & ( ! rst_d1 )                   ) begin
    endsim <= 1'b1 ;
    pass   <= 1'b0 ;

  end else if ( cnt_start_state  & prng_start_state & ( ! rst_d1 ) ) begin
    endsim <= 1'b1 ;
    pass   <= 1'b1 ;

  end else if ( cnt_start_state  & ( ! rst_d1 )                    ) begin
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

