
module co_sim_bytewrite_tdp_ram_wf;
  parameter NB_COL = 4;                           // Specify number of columns (number of bytes)
  parameter COL_WIDTH = 8;                        // Specify column width (byte width, typically 8 or 9)
  parameter RAM_DEPTH = 1024;                     // Specify RAM depth (number of entries)
  // parameter RAM_PERFORMANCE = "HIGH_PERFORMANCE", // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
  // parameter INIT_FILE = ""                        // Specify name/location of RAM initialization file if using one (leave blank if not)

  reg [9:0] addra;   // Port A address bus, width determined from RAM_DEPTH
  reg [9:0] addrb;   // Port B address bus, width determined from RAM_DEPTH
  reg [(NB_COL*COL_WIDTH)-1:0] dina;   // Port A RAM reg data
  reg [(NB_COL*COL_WIDTH)-1:0] dinb;   // Port B RAM reg data
  reg clka;                            // Port A clock
  reg clkb;                            // Port B clock
  reg [NB_COL-1:0] wea;                // Port A write enable
  reg [NB_COL-1:0] web;                // Port B write enable
  reg ena;                             // Port A RAM Enable, for additional power savings, disable BRAM when not in use
  reg enb;                             // Port B RAM Enable, for additional power savings, disable BRAM when not in use
  reg rsta;                            // Port A output reset (does not affect memory contents)
  reg rstb;                            // Port B output reset (does not affect memory contents)
  reg regcea;                          // Port A output register enable
  reg regceb;                          // Port B output register enable
  wire [(NB_COL*COL_WIDTH)-1:0] douta,douta_net; // Port A RAM output data
  wire [(NB_COL*COL_WIDTH)-1:0] doutb,doutb_net; // Port B RAM output data



    integer mismatch=0;
    integer cycle, i;

    bytewrite_tdp_ram_wf golden (
    .addra(addra),
    .addrb(addrb),
    .dina(dina),
    .dinb(dinb),
    .clka(clka),
    .clkb(clkb),
    .wea(wea),
    .web(web),
    .ena(ena),
    .enb(enb),
    .rsta(rsta),
    .rstb(rstb),
    .regcea(regcea),
    .regceb(regceb),
    .douta(douta),
    .doutb(doutb)
  );
    bytewrite_tdp_ram_wf_post_synth netlist(    .addra(addra),
    .addrb(addrb),
    .dina(dina),
    .dinb(dinb),
    .clka(clka),
    .clkb(clkb),
    .wea(wea),
    .web(web),
    .ena(ena),
    .enb(enb),
    .rsta(rsta),
    .rstb(rstb),
    .regcea(regcea),
    .regceb(regceb), .douta(douta_net), .doutb(doutb_net));



     //clock//
    initial begin
        clka = 1'b0;
        forever #10 clka = ~clka;
    end
    initial begin
        clkb = 1'b0;
        forever #10 clkb = ~clkb;
    end
    initial begin
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.BRAM[i] ='b0;
        end  
    end
    initial begin
    {rsta,rstb} = 2'b11;
    {ena, wea, addra, dina, enb, web, addrb, dinb, cycle, i} = 0;
    {enb,ena} = 2'b11;

    repeat (10) @ (negedge clka);
    {rsta,rstb} = 2'b00;
    for (integer i=0; i<2048; i=i+1)begin
        repeat (1) @ (negedge clka)
        ena = $random; enb = $random; addra <= $urandom_range(0,511); addrb <= $urandom_range(512,1023); wea <=$random; web <=$random; dina<= 36'hfffffffff; dinb<= $random; regcea<=$random; regceb<=$random;
        cycle = cycle +1;
        
        compare(cycle);

    end
    for (integer i=0; i<2048; i=i+1)begin
        repeat (1) @ (negedge clka)
        ena = $random; enb = $random; addrb <= $urandom_range(0,511); addra <= $urandom_range(512,1023); wea <=$random; web <=$random; dina<= $random; dinb<= $random; regcea<=$random; regceb<=$random;
        cycle = cycle +1;
        
        compare(cycle);

    end
//     //reading
//     for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clka)
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=0;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end
// //repeat for ena 0
//     ena = 1'b0;
//     for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clka)
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=4'b1111; din<= $random;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end

   
//     for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clka)
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=0;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end

// //random
//       for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clka)
//         ena = $random;
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=$random; din<= $random;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clka); $finish;
    end

    task compare(input integer cycle);begin
    //$display("\n Comparison at cycle %0d", cycle);
    if(douta !== douta_net) begin
        $display("douta mismatch. Golden: %0h, Netlist: %0h, Time: %0t", douta, douta_net,$time);
        mismatch = mismatch+1;
    end
    if(doutb !== doutb_net) begin
        $display("doutb mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutb, doutb_net,$time);
        mismatch = mismatch+1;
    end
end
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule