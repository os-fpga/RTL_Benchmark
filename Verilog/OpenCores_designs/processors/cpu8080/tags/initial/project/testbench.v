`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:25:07 09/20/2006 
// Design Name: 
// Module Name:    testbench 
// Project Name:                            
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:                                             
//
//////////////////////////////////////////////////////////////////////////////////

module testbench(addr,     // Address out
                 data,     // Data bus
                 readmem,  // Memory read
                 writemem, // Memory write
                 readio,   // Read I/O space
                 writeio,  // Write I/O space
                 intr,     // Interrupt request 
                 inta,     // Interrupt request 
                 waitr,    // Wait request
                 reset,    // Reset
                 clock);   // System clock

   output [15:0] addr;
   inout  [7:0] data;
   output readmem;
   output writemem;
   output readio;
   output writeio;
   input  intr;
   output inta;
   input  waitr;
   input  reset;
   input  clock;

   // selector block, we only use select 1 and 2
   select select1(addr, data, readio, writeio, romsel, ramsel, select3, 
                  select4, bootstrap, clock, reset);

   cpu8080 cpu(addr, data, readmem, writemem, readio, writeio, intr, inta, waitr,
               reset, clock);
   rom rom(addr[9:0], data, romsel&readmem);
   ram ram(addr[9:0], data, ramsel, readmem, writemem, bootstrap, ~clock);

   // fake input device, always returns $42
   assign data = readio ? 8'h42: 8'bz;

endmodule

////////////////////////////////////////////////////////////////////////////////
//
// Peripheral select unit
//
// This block implements a general purpose select generator. It has 4 select
// units, each capable of matching up to 6 bits of address, or 1kb of address
// resolution. The length and base address of each generated select can be
// specified, and each select can be mapped either to memory or I/O. In the case
// of I/O, the match for the select takes place on the lower 8 bits of the
// address, corresponding to the 0-255 addresses in the I/O space.
// Note that the selects must still be qualified with readmem, writemem,
// readio and writeio signals at the selected peripheral.
//
// The selector itself has an I/O address of 0, but this can be moved as well.
// However, the selector must remain in I/O space.
//
// A special "bootstrap" mode is implemented. After power on, and until the
// selector is configured by the processor, both select1 and select2 will be
// active, along with the output signal bootstrap. These should be connected as
// follows:
//
// select1:   Connect to bootstrap ROM
// select2:   Connect to RAM
// bootstrap: Connect to RAM output buffers to disable them when true
//
// In bootstrap mode, ROM and RAM selects are on until the bootstrap mode is
// turned off by a CPU I/O operation. The bootstrap signal indicates that 
// bootstrap mode is active, and should be used to disable the RAM output 
// buffers.
//
// Because the ROM does not perform writes, and the RAM is disabled from reads,
// the RAM will overlay the ROM in memory, with the ROM providing read data,
// and the RAM accepting write data. This is sometimes called "shadow mode".
// What it does is allow the CPU to copy the ROM to RAM by performing a block
// read and write to the same address, ie., it picks up the content at each
// address, then writes it back, effectively copying the ROM contents to the
// RAM. The CPU can then program the selects, exit bootstrap mode, and then
// execute entirely from the RAM copy of the bootstrap ROM.
//
// Bootstrapping this way accomplishes a few ends. First, because memory
// is limited on a 64kb machine, it allows RAM to occupy all of memory, without
// having to reserve a block of space permanently for the boostrap ROM. Second,
// ROM is usually a lot slower than RAM nowdays, so it is common to want to
// run from RAM instead of trying to execute directly from ROM.
//
// The reason that we gate the RAM output buffers with the bootstrap signal,
// instead of trying to gate the select signal with readmem, is that the latter
// would generate glitches, since the readmem signal is enveloped by the 
// address, instead of vice versa. It also gives the RAM logic a chance to cut
// down on the delay of readmem to output drive enable.
//
// The Format of the registers in the select unit are:
//
//    7 6 5 4 3 2 1 0
// 0: C C C C X X X B - Main control register
// 1: X X X X X X X X - Unused
// 2: M M M M M M I E - Select 1 mask
// 3: C C C C C C X X - Select 1 compare
// 4: M M M M M M I E - Select 2 mask
// 5: C C C C C C X X - Select 2 compare
// 6: M M M M M M I E - Select 3 mask
// 7: C C C C C C X X - Select 3 compare
// 8: M M M M M M I E - Select 4 mask
// A: C C C C C C X X - Select 4 compare
//
// The main control bits 7:4 contain the one of 16 base addresses for the
// select controller. It occupies 16 locations in the address space, of
// which only 9 are actually used. The compare bits reset to 0, so that the
// select unit occupies the I/O addresses $00-$0A on power up. The base address
// can be changed by writing the main control register, and the new address will
// take place on the next access. The select unit can only be addressed in the
// I/O space.
//
// The bootstrap bit is reset to 1, and can be written to 0 to turn off 
// bootstrap mode.
//

module select(addr, data, readio, writeio, select1, select2, select3, select4,
              bootstrap, clock, reset);

   input [15:0] addr;      // CPU address
   inout [7:0]  data;      // CPU data bus
   input        readio;    // I/O read
   input        writeio;   // I/O write
   output       select1;   // select 1
   output       select2;   // select 1
   output       select3;   // select 1
   output       select4;   // select 1
   output       bootstrap; // bootstrap status
   input        clock;     // CPU clock
   input        reset;     // reset
   reg          bootstrap; // bootstrap mode

   reg [7:4]    seladr; // base I/O address of selector
   reg [7:0]    datai; // internal data

   assign selacc = seladr == addr[7:4]; // form selector access
   assign accmain = selacc && (addr[3:1] == 3'b000); // select main
   assign acca = selacc && (addr[3:1] == 3'b001); // select 1
   assign accb = selacc && (addr[3:1] == 3'b010); // select 2
   assign accc = selacc && (addr[3:1] == 3'b011); // select 3
   assign accd = selacc && (addr[3:1] == 3'b100); // select 4

   // Control access to main select unit address. This has to be clocked to
   // activate the address only after the cycle is over.
   always @(posedge clock)
      if (reset) begin

         seladr <= 4'b0; // clear master select
         bootstrap <= 1; // enable bootstrap mode

      end else if (writeio&accmain) begin

         seladr <= data[7:4]; // write master select
         bootstrap <= data[0]; // write bootstrap mode bit

      end else if (readio&accmain) 
         datai <= {seladr, 4'b0}; // read master select
   
   selectone selecta(addr, data, writeio, readio, acca, select1i, reset);
   selectone selectb(addr, data, writeio, readio, accb, select2i, reset);
   selectone selectc(addr, data, writeio, readio, accc, select3, reset);
   selectone selectd(addr, data, writeio, readio, accd, select4, reset);

   assign data = readio&accmain ? datai: 8'bz; // enable output data

   assign select1 = select1i | bootstrap; // enable select 1 via bootstrap
   assign select2 = select2i | bootstrap; // enable select 2 via bootstrap

endmodule

//
// Individual select cell.
//
// This cell contains the mask and compare registers for each address. It
// handles the write and read of these registers, and forms a select signal
// based on them.
//
// Each register pair has the appearance:
//
//    7 6 5 4 3 2 1 0 
//   ================
// 0: M M M M M M I E - Mask register.
// 1: C C C C C C X X - Compare register.
//
// The mask register selects which bits will be used to form the compare
// value. This can be used to select any size from the combinations:
//
// 1 1 1 1 1 1 - Any 1kb block of memory, or 4 I/O address bits.
// 1 1 1 1 1 0 - Any 2kb block of memory, or 8 I/O address bits.
// 1 1 1 1 0 0 - Any 4kb block of memory, or 16 I/O address bits.
// 1 1 1 0 0 0 - Any 8kb block of memory, or 32 I/O address bits.
// 1 1 0 0 0 0 - Any 16kb block of memory, or 64 I/O address bits.
// 1 0 0 0 0 0 - Any 32kb block of memory, or 128 I/O address bits.
// 0 0 0 0 0 0 - All 64kb of memory, or all 256 I/O addresses
//
// Each block must be on its size, so for example, a 16kb block can only
// be on one of 4 positions in memory. If you use a pattern that isn't
// listed above, you are on your own to figure out the consequences.
// The selector does not weed out bad combinations, and you can select
// multiple blocks at once.
//
// Each of the mask and compare bytes can be both read and written.
//
// Note that the lower bits of the compare register aren't used, and always
// return zero.
//
// On reset, the mask and compare registers are both set to zero, which leaves
// the select block disabled.
//

module selectone(addr, data, write, read, selectin, selectout, reset);

   input [15:0] addr;     // address to match, 6 bits
   inout [7:0] data;      // CPU data
   input       write;     // CPU write
   input       read;      // CPU read
   input       selectin;  // select for read/write
   output      selectout; // resulting select
   input       reset;     // reset

   reg  [7:0] mask;  // mask/control, 7:2 is mask, 1: I/O or /mem, 0: on/off
   reg  [7:2] comp;  // Compare value
   wire [5:0] iaddr; // multiplexed address
   reg  [7:0] datai; // data from output selector

   // select what part of address, upper or lower byte, we compare, based on
   // I/O or memory address
   assign iaddr = mask[1] ? addr[7:2]: addr[15:10];

   // Form select based on match
   assign selectout = ((iaddr & mask[7:2]) == comp) & mask[0];

   always @(addr, write, read)
      if (reset) begin

      comp <= 6'b0; // clear registers
      mask <= 8'b0;

   end else if (write&selectin) begin

      if (addr[0]) comp <= data[7:2]; // write comparitor data
      else mask <= data; // write mask data

   end else begin

      if (addr[0]) datai <= {comp, 2'b0}; // read comparitor data
      else datai <= mask; // read mask data

   end

   assign data = read&selectin ? datai: 8'bz; // enable output data

endmodule

module rom(addr, data, dataeno);

   input [9:0] addr;
   inout [7:0] data;
   input dataeno;

   reg [7:0] datao;
   
   always @(addr) case (addr)

      //
      // Elementary program to start up system. Initalizes the select unit to
      // have the rom followed by the ram, 1kb each. Then we perform a test
      // that checks the CPU and the RAM are working, then halt.
      //
      0:  datao = 8'h3e; // mvi a,$fd    ! enable select 1 to $0000, 1kb
      1:  datao = 8'hfd;
      2:  datao = 8'hd3; // out $02      ! select 1 mask register
      3:  datao = 8'h02;
      4:  datao = 8'h3e; // mvi a,$04    ! enable select 2 to $0400, 1kb
      5:  datao = 8'h04;
      6:  datao = 8'hd3; // out $05      ! select 2 compare register
      7:  datao = 8'h05;
      8:  datao = 8'h3e; // mvi a,$fd
      9:  datao = 8'hfd;
      10: datao = 8'hd3; // out $04
      11: datao = 8'h04;
      12: datao = 8'h3e; // mvi a,$00    ! exit bootstrap mode 
      13: datao = 8'h00;
      14: datao = 8'hd3; // out $00
      15: datao = 8'h00;
      16: datao = 8'h31; // lxi sp,$0800 ! place stack at top of ram
      17: datao = 8'h00;
      18: datao = 8'h08;
      19: datao = 8'h01; // lxi b,$1234  ! load test value
      20: datao = 8'h34;
      21: datao = 8'h12;
      22: datao = 8'hc5; // push b       ! save on stack
      23: datao = 8'he1; // pop h        ! place in hl
     
      default datao = 8'h76; // hlt
   
   endcase

   // Enable drive for data output
   assign data = dataeno ? datao: 8'bz;
   
endmodule

module ram(addr, data, select, read, write, bootstrap, clock);

   input [9:0] addr;
   inout [7:0] data;
   input select;
   input read;
   input write;
   input clock;
   input bootstrap;

   reg [7:0] ramcore [1023:0]; // The ram store
   reg [7:0] datao;
   
   always @(posedge clock) 
      if (select) begin

         if (write) ramcore[addr] <= data;
         datao <= ramcore[addr];

      end

   // Enable drive for data output
   assign data = (select&read&~bootstrap) ? datao: 8'bz;
   
endmodule
