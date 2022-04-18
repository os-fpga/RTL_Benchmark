//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2012-07-27 16:22:05 +0100 (Fri, 27 Jul 2012) $
//
//      Revision            : $Revision: 216698 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     IO Port compliant General Purpose Input/Output Block
//-----------------------------------------------------------------------------

module cm0p_ik_iop_gpio
  (// Inputs
   input wire           FCLK,       // Free-running clock
   input wire           HCLK,       // System clock
   input wire           HRESETn,    // System reset
   input wire           IOSEL,      // Decode for peripheral
   input wire [31:0]    IOADDR,     // I/O transfer address
   input wire           IOWRITE,    // I/O transfer direction
   input wire [1:0]     IOSIZE,     // I/O transfer size
   input wire           IOTRANS,    // I/O transaction
   input wire [31:0]    IOWDATA,    // I/O write data bus
   input wire [31:0]    GPIOIN,     // Input from IO pad
   // Outputs
   output wire [31:0]   IORDATA,    // I/0 read data bus
   output wire [31:0]   GPIOOUT,    // Output to IO pad
   output wire [31:0]   GPIOEN,     // Output enable for IO pad
   output wire          GPIOINT);   // Input change interrupt output

//-----------------------------------------------------------------------------
// Signal declarations
//-----------------------------------------------------------------------------

  reg    [31:0] gpiodata_o;         // GPIO Data Out Register
  reg    [31:0] gpiodata_i;         // GPIO Data In Register
  reg    [31:0] gpiodir;            // GPIO Direction Register
  reg    [31:0] gpiointmask;        // GPIO Interrupt Mask Register
  reg           gpiointerrupt;      // GPIO Interrupt
  reg    [31:0] type_mask2;         // Mask for Data register


//-----------------------------------------------------------------------------
// AHB write byte address control
//-----------------------------------------------------------------------------

  // Decode term for access to least significant byte
  wire          byte0 = ( IOSIZE[1] ) |
                          ( IOSIZE[0] & ~IOADDR[1] ) |
                          ( ~IOSIZE[0] & ~IOADDR[1] & ~IOADDR[0] );

  // Decode term for access to byte 1
  wire          byte1 = ( IOSIZE[1] ) |
                          ( IOSIZE[0] & ~IOADDR[1] ) |
                          ( ~IOSIZE[0] & ~IOADDR[1] &  IOADDR[0] );

  // Decode term for access to byte 2
  wire          byte2 = ( IOSIZE[1] ) |
                          ( IOSIZE[0] &  IOADDR[1] ) |
                          ( ~IOSIZE[0] &  IOADDR[1] & ~IOADDR[0] );

  // Decode term for access to most significant byte
  wire          byte3 = ( IOSIZE[1] ) |
                          ( IOSIZE[0] &  IOADDR[1] ) |
                          ( ~IOSIZE[0] &  IOADDR[1] &  IOADDR[0] );

  // Mask depending on type of access :
  // word, half-word or byte
  wire [31:0] type_mask = { {8{byte3}}, {8{byte2}}, {8{byte1}}, {8{byte0}} };

//-----------------------------------------------------------------------------
// AHB register read/write mask for byte accesses on Data register
//-----------------------------------------------------------------------------

  wire          iosize_zero = (IOSIZE[1:0] == 2'b0);

  // For byte accesses, the mask is in IOADDR[9:2]
  wire [7:0]    mask8 = (iosize_zero)? IOADDR[9:2] : {8{1'b0}};

  always @ (iosize_zero or IOADDR or mask8 or type_mask)
    case({iosize_zero,IOADDR[1:0]})
        3'b100  : type_mask2 = {8'h00, 8'h00, 8'h00, mask8};
        3'b101  : type_mask2 = {8'h00, 8'h00, mask8, 8'h00};
        3'b110  : type_mask2 = {8'h00, mask8, 8'h00, 8'h00};
        3'b111  : type_mask2 = {mask8, 8'h00, 8'h00, 8'h00};
        3'b000,3'b001,3'b010,3'b011:  type_mask2 = type_mask;
        default : type_mask2 = {32{1'bx}};
    endcase

//-----------------------------------------------------------------------------
// AHB write register address control
//-----------------------------------------------------------------------------

  // Detect a valid write to this slave
  wire        write_trans  = IOSEL & IOWRITE & IOTRANS;

  // Qualify with address to determine register write enable
  wire        gpiodata_o_wren   = write_trans & (IOADDR[10   ] ==       1'b0);
  wire        gpiodir_wren      = write_trans & (IOADDR[10: 4] == 7'b1000000);
  wire        gpiointmask_wren  = write_trans & (IOADDR[10: 4] == 7'b1000001);

//-----------------------------------------------------------------------------
// IO Pad registers
//-----------------------------------------------------------------------------

  assign      GPIOEN         = gpiodir;

  assign      GPIOOUT        = gpiodata_o;

  wire [31:0] nxt_gpiodata_i = GPIOIN;

  // Combine bus and register values using mask for next state of Direction Register
  wire [31:0] nxt_gpiodir  = gpiodir_wren  ?
                             ((IOWDATA & type_mask) | (gpiodir & ~type_mask))
                             : gpiodir;

  // Combine bus and register values using mask for next state of Interrupt Mask Register
  wire [31:0] nxt_gpiointmask  = gpiointmask_wren  ?
                                ((IOWDATA & type_mask) | (gpiointmask & ~type_mask))
                                : gpiointmask;

  // Combine bus and register values using mask for next state of Data Out Register
  wire [31:0] nxt_gpiodata_o = gpiodata_o_wren ?
                               ((IOWDATA & type_mask2) | (gpiodata_o & ~type_mask2))
                               : gpiodata_o;

  always @(posedge HCLK or negedge HRESETn)
    if(~HRESETn)
      begin
        gpiodir     <= {32{1'b0}};      // Disable all buffers on reset
        gpiointmask <= {32{1'b0}};
        gpiodata_o  <= {32{1'b0}};
      end
    else
      begin
        gpiodir     <= nxt_gpiodir;     // update direction register
        gpiointmask <= nxt_gpiointmask; // update interrupt mask register
        gpiodata_o  <= nxt_gpiodata_o;  // updata data out register
      end

  always @ (posedge FCLK or negedge HRESETn)
     if(~HRESETn)
       gpiodata_i   <= {32{1'b0}};      // Reset all outputs to zero
     else
       gpiodata_i   <= nxt_gpiodata_i;  // Sample GPIOIN continuously

//-----------------------------------------------------------------------------
// Input change interrupt generator
//-----------------------------------------------------------------------------

  // Interrupt generated if input signals change between samples after masking
  //
  // NOTE: This logic generates an interrupt pulse that is 1 cycle of (GPIO) HCLK.
  //       You must ensure that the interrupt pulse is long enough to be observed
  //       by the processor, i.e. at least one Processor SCLK cycle long.
  wire        nxt_gpiointerrupt = |((gpiodata_i ^ nxt_gpiodata_i) & gpiointmask & ~gpiodir);

  always @(posedge FCLK or negedge HRESETn)
    if(~HRESETn)
        gpiointerrupt <= 1'b0;              // Reset GPIOINT pin output
    else
        gpiointerrupt <= nxt_gpiointerrupt; // Update GPIOINT pin output

  assign      GPIOINT = gpiointerrupt;

//-----------------------------------------------------------------------------
// AHB register read mux
//-----------------------------------------------------------------------------

  // Drive read mux next state from word address when selected
  wire [31:0] rdata   = (IOADDR[10:4] == 7'b1000000)? gpiodir : (           //Offset 0x400 returns Direction Register
                        (IOADDR[10:4] == 7'b1000001)? gpiointmask : (       //Offset 0x410 returns Interrupt Mask Register
                        (IOADDR[10  ] ==       1'b0)? gpiodata_i : 32'b0)); //Offset 0x0 to 0x3ff returns Data Register

  assign      IORDATA =  rdata & type_mask2;

endmodule // cm0p_ik_iop_gpio

