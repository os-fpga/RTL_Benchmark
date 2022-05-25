
interface apb_if;
 // APB SLAVE PORT INTERFACE 
 logic                         PCLK;
 logic                         PRESETn;
 logic [`APB_ADDR_WIDTH-1:0 ]  PADDR;
 logic                         PWRITE;
 logic [`NUM_SLV-1:0]          PSEL;
 logic                         PENABLE;
 logic [`APB_DATA_WIDTH-1:0 ]  PWDATA;
 logic [`APB_DATA_WIDTH-1:0 ]  PRDATA;
 logic                         PREADY;
 logic 			       TrFr;
endinterface
