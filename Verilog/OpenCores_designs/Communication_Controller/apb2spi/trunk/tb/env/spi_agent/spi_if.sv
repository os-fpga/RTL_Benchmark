interface spi_if;

 logic                         SCLK;
 logic                         MISO;
 logic                         MOSI;
 logic                         SS;

 // SPI INTERFACE
 //if Master/Slave Mode
/*modport master_slave_mode(
 inout                         SCLK,
 inout                         MISO,
 inout                         MOSI,
 output                        SS
);*/

 //if only Master Mode
modport master_mode(
 output                        SCLK,
 input                         MISO,
 output                        MOSI,
 output                        SS
);

 //if only Slave Mode
modport slave_mode(
 input                         SCLK,
 output                        MISO,
 input                         MOSI,
 input                         SS
);
 
endinterface
