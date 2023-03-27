localparam [1:0] AHB_TRANS_IDLE   = 2'b00;
localparam [1:0] AHB_TRANS_NONSEQ = 2'b10;
localparam [1:0] AHB_TRANS_SEQ    = 2'b11;

localparam [1:0] AHB_STS_OK = 2'b00;

typedef enum logic [4:0] { AHB_IDLE      = 5'b00001,
                           AHB_REQ_ADDR  = 5'b00010,
                           AHB_REQ_WDAT  = 5'b00100,
                           AHB_RESP_ADDR = 5'b01000,
                           AHB_RESP_RDAT = 5'b10000
                         } ahb_state_t;
