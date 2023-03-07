// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module spi_flash (  SCLK,
                    CS,
                    SI,
                    SO,
                    WP,
                    RESET,
                    SIO3 );

input       SCLK;
input       CS;
input       RESET;

inout       SI;
inout       SO;
inout       WP;
inout       SIO3;

parameter       MANUFACTURER_ID     = 8'hc2,
                MEMROY_TYPE         = 8'h20,
                MEMROY_DENSITY      = 8'h1b;
parameter       TOP_Add             = 27'h7ffffff;
parameter       BUSY_TIME           = 32'd100;

`define         file_name   "none"
parameter       init_file   = `file_name;
`undef		file_name
localparam      PAGE_SIZE   = 256;
localparam      WREN        = 8'h06,
                WRDI        = 8'h04,
                RDSR        = 8'h05,
                WRSR        = 8'h01,
                READ1X      = 8'h03,
                READ4B      = 8'h13,
                FASTREAD1X  = 8'h0b,
                READ2X      = 8'hbb,
                READ4X      = 8'heb,
                PP          = 8'h02,
                PP4B        = 8'h12,
                PP4X        = 8'h38,
                SE          = 8'h20,
                BE          = 8'hd8,
                EN4B        = 8'hb7,
                RDID        = 8'h9F;

localparam      ST_IDLE     = 3'd0,
                ST_CMD      = 3'd1,
                ST_DUM      = 3'd2,
                ST_ADDR     = 3'd3,
                ST_DATA     = 3'd4;

wire        spi_clk         = SCLK;
wire        spi_csn         = CS;
wire        spi_reset       = RESET;
wire        spi_si_in       = SI;
wire        spi_wp_in       = WP;
wire        spi_sio3_in     = SIO3;
wire        spi_so_in       = SO;
wire        spi_so_out;
wire        spi_si_out;
wire        spi_wp_out;
wire        spi_sio3_out;
wire        cmd_reset       = RESET && CS;
assign      SO              = spi_so_out;
assign      SI              = spi_si_out;
assign      WP              = spi_wp_out;
assign      SIO3            = spi_sio3_out;

reg         so_out_en;
wire        so_out_en_set;
reg [2:0]   spi_cs;
reg [2:0]   spi_ns;
wire        spi_st_en;
wire        state_cmd;
wire        state_dum;
wire        state_addr;
wire        state_data;

reg  [7:0]  cmd;
reg  [31:0] addr;
reg  [7:0]  data_in;
wire [7:0]  cmd_nx;
wire [31:0] addr_nx;
wire [7:0]  data_in_nx;

reg  [3:0]  cmd_cnt;
wire [3:0]  cmd_cnt_nx;
reg  [3:0]  dum_cnt;
wire [3:0]  dum_cnt_nx;
reg  [5:0]  addr_cnt;
wire [5:0]  addr_cnt_nx;
reg  [3:0]  data_cnt;
wire        data_cnt_en;
wire [3:0]  data_cnt_nx;

wire        cmd_ready;
wire        addr_ready;
wire        dum_done;
wire        addr_4b_mode;
wire        data_out_valid;

wire        quad_in_mode;
wire        doub_in_mode;

wire        cmd_en;
wire        addr_en;

reg         pf_enhance_mode;
wire        pf_enhance_mode_set;
wire        cmd_support_pf_mode;
wire        pf_enhance_mode_nx;

wire        set_flash_writable;
wire        set_flash_4baddr;
wire        set_flash_status_reg;
wire        set_flash_config_reg;

wire [7:0]  status_reg;
reg         status_wip;
reg         status_wel;
reg  [3:0]  status_bp;
reg         status_qe;
reg         status_srwd;
wire        status_wel_nx;

wire [7:0]  config_reg;
reg  [2:0]  config_ods;
reg         config_tb;
reg         config_pbe;
reg         config_4baddr;
reg  [1:0 ] config_dc;
wire        config_4baddr_nx;


wire        flash_protect;

assign      state_cmd  = (spi_cs == ST_CMD);
assign      state_dum  = (spi_cs == ST_DUM);
assign      state_addr = (spi_cs == ST_ADDR);
assign      state_data = (spi_cs == ST_DATA);



localparam  CMD_BIT             = 4'd8;
localparam  DUM_CYCLE           = 4'd8;
localparam  LAST_CMD_BIT        = CMD_BIT - 4'd1;
localparam  LAST_DATA_BIT       = CMD_BIT - 4'd1;
localparam  LAST_DUM_CYCLE      = DUM_CYCLE - 4'd1;
localparam  ADDR_BIT_24         = 6'd24;
localparam  DOUB_ADDR_BIT_24    = ADDR_BIT_24 >> 1;
localparam  QUAD_ADDR_BIT_24    = ADDR_BIT_24 >> 2;
localparam  ADDR_BIT_32         = 6'd32;
localparam  DOUB_ADDR_BIT_32    = ADDR_BIT_32 >> 1;
localparam  QUAD_ADDR_BIT_32    = ADDR_BIT_32 >> 2;

localparam  ST_REG_BIT_CNT      = 9'h08;
localparam  CFG_REG_BIT_CNT     = 9'h10;


wire [5:0]  addr_bitwidth;
assign      addr_bitwidth       = addr_4b_mode ? (quad_in_mode ? QUAD_ADDR_BIT_32 : (doub_in_mode ? DOUB_ADDR_BIT_32 : ADDR_BIT_32)) :
                                                 (quad_in_mode ? QUAD_ADDR_BIT_24 : (doub_in_mode ? DOUB_ADDR_BIT_24 : ADDR_BIT_24)) ;

reg  [31:0] reg_si;
wire [31:0] reg_si_nx;
reg  [8:0]  si_cnt;
wire [8:0]  si_cnt_nx;
reg  [2047:0] so_data;

assign      si_cnt_nx = (cmd_ready || addr_ready) ? 9'd1 : si_cnt + 9'd1;
assign      reg_si_nx = quad_in_mode ? {reg_si[27:0], spi_sio3_in, spi_wp_in, spi_so_in, spi_si_in} :
                       (doub_in_mode ? {reg_si[29:0], spi_so_in, spi_si_in}                   :
                       {reg_si[30:0], spi_si_in});


wire        so_data_update;
reg  [7:0]  index;
wire [7:0]  index_nx;
reg  [7:0]  page_buf_index;
wire [7:0]  page_buf_index_nx;
wire        page_buf_index_en;
wire        page_buf_en;
wire        read_next_page;
wire [18:0] read_page_num_nx;
reg  [18:0] read_page_num;
reg  [3:0]  sing_dum_end;
reg  [3:0]  doub_dum_end;
reg  [3:0]  quad_dum_end;
// synthesis translate_off
reg [7:0]   page_buf[0:PAGE_SIZE-1];
reg /* sparse */ [7:0]  Mem[0:TOP_Add];
// synthesis translate_on
wire        read_cmd;
wire        trig_status_task;
wire        trig_read_addr_task;
wire        trig_wrong_cmd;

event   event_pp;
event   event_be;
event   event_se;

assign status_wel_nx = set_flash_status_reg ? reg_si_nx[1] : set_flash_writable ? (reg_si_nx[7:0] == WREN) : status_wel;
assign config_4baddr_nx = set_flash_config_reg ? reg_si_nx[5] : set_flash_4baddr ?  1'b1 : config_4baddr;


assign status_reg           =  {status_srwd, status_qe, status_bp, status_wel, status_wip};
assign config_reg           =  {config_dc, config_4baddr, config_pbe, config_tb, config_ods};
assign flash_protect        =  (status_bp == 4'd0) ?                                               1'b0  :
                                                     (config_tb ? (addr[31:16] < (16'b1 << (status_bp - 4'd1))) :
                                                          (addr[31:16] > (16'h2048 - (16'b1 << (status_bp - 4'd1)))));
assign so_data_update       =  (read_next_page || dum_done || addr_ready || cmd_ready) && (so_out_en || so_out_en_set) && (spi_ns == ST_DATA);
assign data_cnt_en          =  (cmd_ready  && ((cmd == RDSR)       || (cmd == RDID)))   ||
                               (addr_ready &&  (cmd == READ1X))                         ||
                               (dum_done   && ((cmd == FASTREAD1X) || (cmd == READ2X)   || (cmd == READ4X))) ||
                                state_data;
assign data_cnt_nx          =  data_cnt_en ? ((data_cnt == (quad_in_mode ? 4'd2 : (doub_in_mode ? 4'd4 : 4'd8))) ? 4'd1 : (data_cnt + 4'd1)) : 4'd0;
assign addr_4b_mode         =  (cmd_nx  == PP4B) ||
                             (((cmd_nx == PP) || (cmd_nx == PP4X) || (cmd_nx == FASTREAD1X) ||
                               (cmd_nx == READ1X) || (cmd_nx == READ2X) || (cmd_nx == READ4X)) && config_4baddr);
assign cmd_nx               =  cmd_en ? reg_si_nx[7:0] : (cmd_cnt == 4'd7) ? {reg_si[6:0], spi_si_in} : cmd;
assign cmd_en               =  (!pf_enhance_mode) && (cmd_cnt == (LAST_CMD_BIT)) && state_cmd && (!status_wip);
assign pf_enhance_mode_set  =  (dum_cnt == 4'd1) && state_dum && cmd_support_pf_mode;
assign cmd_support_pf_mode  =  (cmd == READ4X);
assign cmd_ready            =  (cmd_cnt == CMD_BIT);
assign so_out_en_set        = (((cmd == RDID)       || (cmd == RDSR)) && cmd_ready) ||
                              (((cmd == READ1X)     &&  addr_ready))                ||
                              (((cmd == FASTREAD1X) || (cmd == READ2X) || (cmd == READ4X)) && dum_done);
assign data_out_valid       = ((cmd == RDID) || (cmd == RDSR) || (cmd == READ1X) || (cmd == FASTREAD1X) || (cmd == READ2X)) && state_data;
assign set_flash_status_reg =  (cmd == WRSR) && (si_cnt_nx ==  ST_REG_BIT_CNT) && state_data && (!status_wip) && status_wel;
assign set_flash_config_reg =  (cmd == WRSR) && (si_cnt_nx == CFG_REG_BIT_CNT) && state_data;
assign quad_in_mode         =(((cmd == PP4X) && (!state_cmd || cmd_ready)) || ((cmd == READ4X) && (!state_cmd)) || ((cmd_nx == READ4X) && cmd_ready)) && status_qe;
assign doub_in_mode         = ((cmd == READ2X) && (!state_cmd)) || ((cmd_nx == READ2X) && cmd_ready);
assign read_next_page       =  (read_cmd        && (page_buf_index == 8'hff) && (data_cnt    == 4'h8)) ||
                               ((cmd == READ2X) && (page_buf_index == 8'hff) && (data_cnt[2] == 1'b1)) ||
                               ((cmd == READ4X) && (page_buf_index == 8'h00) && (data_cnt[1] == 1'b1));
assign read_page_num_nx     = (( read_cmd       && (page_buf_index == 8'hff) && (data_cnt == 4'h7)) ||
                               ((cmd == READ2X) && (page_buf_index == 8'hff) && (data_cnt == 4'h3)) ||
                               ((cmd == READ4X) && (page_buf_index == 8'hff) && (data_cnt == 4'h1)) ) ? (read_page_num + 19'h1)
                                                                                                      :  read_page_num;
assign page_buf_en          = ((cmd == PP) && state_data && (data_cnt_nx == 4'd7))  ||
                              ((cmd == PP4X) && state_data && (data_cnt_nx[0] == 1'b1));
assign spi_so_out           =  (so_out_en ? (quad_in_mode ? so_data[2045] : so_data[2047]) : 1'bz);
assign spi_si_out           =  (so_out_en && (doub_in_mode || quad_in_mode)) ? (quad_in_mode ? so_data[2044] : so_data[2046]) : 1'bz;
assign spi_wp_out           =  (so_out_en &&  quad_in_mode) ? so_data[2046] : 1'bz;
assign spi_sio3_out         =  (so_out_en &&  quad_in_mode) ? so_data[2047] : 1'bz;
assign addr_en              =  (si_cnt_nx == {3'h0, addr_bitwidth}) && state_addr;
assign set_flash_writable   =  (reg_si_nx[7:0] == WREN) || (reg_si_nx[7:0] == WRDI) && (cmd_cnt == (LAST_CMD_BIT)) ;
assign set_flash_4baddr     =  (reg_si_nx[7:0] == EN4B) && (cmd_cnt == (LAST_CMD_BIT)) ;
assign page_buf_index_nx    =  (addr_ready && ((cmd == PP) || (cmd == PP4B) || (cmd == PP4X))) ?
                                                                                     addr[7:0] :
                                 ((page_buf_index_en) ? page_buf_index + 8'd1 : page_buf_index);
assign page_buf_index_en    =  (quad_in_mode ? (data_cnt[0] == 1'b1) : (doub_in_mode ? (data_cnt[2] == 1'b1) : (data_cnt == 4'd8)));
assign addr_ready           =  (addr_cnt == addr_bitwidth);
assign spi_st_en            = ((spi_cs == ST_CMD) && cmd_ready) || ((spi_cs == ST_ADDR) && addr_ready) || ((spi_cs == ST_DUM) && dum_done);
assign dum_done             =   quad_in_mode ? (dum_cnt == (quad_dum_end - 4'd1)) :
                                doub_in_mode ? (dum_cnt == (doub_dum_end - 4'd1)) :
                                               (dum_cnt == (sing_dum_end - 4'd1)) ;
assign pf_enhance_mode_nx   = pf_enhance_mode_set ? (reg_si[4] !== reg_si[0]) : pf_enhance_mode;
assign index_nx             = so_data_update ? (index + 8'd1) : index;
assign addr_nx              = addr_en ? (addr_4b_mode ? reg_si_nx[31:0] : {8'd0, reg_si_nx[23:0]}) : addr;
assign cmd_cnt_nx           = state_cmd ? (cmd_cnt + 4'd1) : 4'd0;
assign dum_cnt_nx           = state_dum ? (dum_cnt + 4'd1) : 4'd0;
assign addr_cnt_nx          = (state_addr && !addr_ready) ? (addr_cnt + 6'd1) : 6'd1;
assign data_in_nx           = state_data ? reg_si_nx[7:0] : data_in;
assign read_cmd             =  (cmd == READ1X) || (cmd == READ2X) || (cmd == READ4X) || (cmd == FASTREAD1X);
assign trig_status_task     = ((cmd_nx == RDID) || (cmd_nx == RDSR)) && (cmd_cnt == 4'd7);
assign trig_read_addr_task  = ((cmd == READ1X) || (cmd == READ2X) || (cmd == READ4X) || (cmd == FASTREAD1X)) && (addr_ready);
assign trig_wrong_cmd       = !((cmd == WREN) || (cmd == WRDI) || (cmd == EN4B)  || (cmd == WRSR)   ||
                                (cmd == RDID) || (cmd == RDSR) || (cmd == PP)    || (cmd == BE)     ||
                                (cmd == SE)   || (cmd == PP4X) || (cmd == READ1X)|| (cmd == READ2X) || (cmd == READ4X) || (cmd == FASTREAD1X));

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        reg_si <= 32'd0;
    else
        reg_si <= reg_si_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        si_cnt <= 9'd0;
    else
        si_cnt <= si_cnt_nx;
end

always @(negedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset) begin
        so_out_en <= 1'b0;
    end
    else begin
        if (so_out_en_set)
            so_out_en <= 1'b1;
    end
end

always @(negedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        read_page_num <= 19'h0;
    else
        read_page_num <= read_page_num_nx;
end

function [7:0] init_unknown;
input [7:0] data;
begin
	init_unknown = (data === 8'hxx) ? 8'hff : data;
end
endfunction

// synthesis translate_off
integer i;
// synthesis translate_on
always @(negedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset) begin
        so_data <= 2048'd0;
    end
    else begin
        if (so_data_update) begin
            if (cmd_nx == RDID) begin
                so_data[2047:2024] <= {MANUFACTURER_ID, MEMROY_TYPE, MEMROY_DENSITY};
            end
            else if (cmd_nx == RDSR) begin
                so_data[2047:2032] <= {status_reg, config_reg};
            end
            else if (read_cmd) begin
                // synthesis translate_off
                for (i = 0; i < PAGE_SIZE; i = i + 1) begin
                    so_data[(2047-i*8)-:8] <= init_unknown(Mem[addr+i+(read_page_num << 8)]);
                end
                // synthesis translate_on
            end
        end
        else begin
            so_data <= (so_data << (quad_in_mode ? 4 : (doub_in_mode ? 2 : 1)));
        end
    end
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset)
        pf_enhance_mode <= 1'b0;
    else
        pf_enhance_mode <= pf_enhance_mode_nx;
end

always @* begin
    case (config_dc)
        2'b00: sing_dum_end = 4'd8;
        2'b01: sing_dum_end = 4'd6;
        2'b10: sing_dum_end = 4'd8;
        2'b11: sing_dum_end = 4'd10;
    endcase
end

always @* begin
    case (config_dc)
        2'b00: doub_dum_end = 4'd4;
        2'b01: doub_dum_end = 4'd6;
        2'b10: doub_dum_end = 4'd8;
        2'b11: doub_dum_end = 4'd10;
    endcase
end

always @* begin
    case (config_dc)
        2'b00: quad_dum_end = 4'd6;
        2'b01: quad_dum_end = 4'd4;
        2'b10: quad_dum_end = 4'd8;
        2'b11: quad_dum_end = 4'd10;
    endcase
end

always @(posedge trig_wrong_cmd) begin
    not_supported_cmd(cmd);
end

always @(negedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        index <= 8'd0;
    else
        index <= index_nx;
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset)
        cmd <= 8'd0;
    else
        cmd <= cmd_nx;
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset)
        addr <= 32'd0;
    else
        addr <= addr_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        cmd_cnt <= 4'd0;
    else
        cmd_cnt <= cmd_cnt_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        dum_cnt <= 4'd0;
    else
        dum_cnt <= dum_cnt_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        addr_cnt <= 6'd0;
    else
        addr_cnt <= addr_cnt_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        data_in <= 8'd0;
    else
        data_in <= data_in_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        data_cnt <= 4'd0;
    else
        data_cnt <= data_cnt_nx;
end

always @(posedge spi_clk or posedge cmd_reset) begin
	if (cmd_reset)
		spi_cs <= pf_enhance_mode ? ST_ADDR : ST_CMD;
	else if (spi_st_en)
		spi_cs <= spi_ns;
end

always @* begin
	spi_ns = spi_cs;
	case (spi_cs)
		ST_CMD: begin
           case (cmd_nx)
               WREN,
               WRDI,
               EN4B      : spi_ns = ST_CMD;
		       WRSR,
		       RDID,
		       RDSR	     : spi_ns = ST_DATA;
		       PP,
               BE,
               SE,
		       PP4X,
               READ1X,
               READ2X,
               READ4X,
               FASTREAD1X: spi_ns = ST_ADDR;
		   endcase
		end
		ST_ADDR: begin
            case (cmd)
                FASTREAD1X,
                READ2X,
                READ4X   : spi_ns = ST_DUM ;
                default  : spi_ns = ST_DATA;
            endcase
		end
        ST_DUM: begin
            case (cmd)
                FASTREAD1X,
                READ2X,
                READ4X   : spi_ns = ST_DATA;
                default  : spi_ns = ST_DUM;
            endcase
        end
	endcase
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset)
        status_wel <= 1'b0;
    else
        status_wel <= status_wel_nx;
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset)
        config_4baddr <= 1'b0;
    else
        config_4baddr <= config_4baddr_nx;
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset) begin
        status_srwd <= 1'b0;
        status_qe   <= 1'b0;
        status_bp   <= 4'd0;
        status_wip  <= 1'b0;
    end
    else if (set_flash_status_reg) begin
        status_srwd <= reg_si_nx[7];
        status_qe   <= reg_si_nx[6];
        status_bp   <= reg_si_nx[5:2];
        status_wip  <= reg_si_nx[0];
    end
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset) begin
        config_dc     <= 2'd0;
        config_pbe    <= 1'b0;
        config_tb     <= 1'b0;
        config_ods    <= 3'd0;
    end
    else if (set_flash_config_reg) begin
        config_dc     <= reg_si_nx[7:6];
        config_pbe    <= reg_si_nx[4];
        config_tb     <= reg_si_nx[3];
        config_ods    <= reg_si_nx[2:0];
    end
end

always @(posedge spi_clk or negedge spi_reset) begin
    if (!spi_reset) begin
        // synthesis translate_off
        for (i = 0; i < PAGE_SIZE; i = i + 1) begin
            page_buf[i] <= 8'b0;
        end
        // synthesis translate_on
    end
    else begin
        // synthesis translate_off
        if (page_buf_en)
            page_buf[page_buf_index] <= reg_si_nx[7:0];
        // synthesis translate_on
    end
end

always @(posedge spi_clk or posedge cmd_reset) begin
    if (cmd_reset)
        page_buf_index <= 8'b0;
    else
        page_buf_index <= page_buf_index_nx;
end

always @(posedge spi_csn) begin
    if (spi_csn) begin
        case (cmd)
            PP:   ->event_pp;
            PP4X: ->event_pp;
            BE:   ->event_be;
            SE:   ->event_se;
        endcase
    end
end

always @(event_pp) begin:page_program_mode
    if (status_wel && (!flash_protect) && (!status_wip))
        page_program(addr);
end

always @(event_be) begin:block_erase_mode
    if (status_wel && (!flash_protect) && (!status_wip))
        block_erase(addr);
end

always @(event_se) begin:sector_erase_mode
    if (status_wel && (!flash_protect) && (!status_wip))
        sector_erase(addr);
end

// synthesis translate_off
initial begin
        if ( init_file != "none" )
            $readmemh(init_file,Mem) ;
end
// synthesis translate_on

task page_program;
input  [31:0]   addr_i;
reg    [31:0]   addr_o;
// synthesis translate_off
integer i;
// synthesis translate_on
begin
    status_wip = 1'b1;
    addr_o = {addr_i[31:8], 8'd0};
    // synthesis translate_off
    for (i = 0; i < PAGE_SIZE; i = i + 1) begin
        Mem[addr_o + i] = page_buf[i];
    end
    // synthesis translate_on
    status_wel = 1'b0;
    # BUSY_TIME;
    status_wip = 1'b0;
end
endtask

task block_erase;
input  [31:0]   addr_i;
reg    [31:0]   addr_o;
// synthesis translate_off
integer i;
// synthesis translate_on
begin
    addr_o = {addr_i[31:16], 16'd0};
    // synthesis translate_off
    for (i = 0; i < 65535; i = i + 1) begin
        Mem[addr_o + i] = 8'hff;
    end
    // synthesis translate_on
    status_wel = 1'b0;
end
endtask

task sector_erase;
input  [31:0]   addr_i;
reg    [31:0]   addr_o;
// synthesis translate_off
integer i;
// synthesis translate_on
begin
    addr_o = {addr_i[31:12], 12'd0};
    // synthesis translate_off
    for (i = 0; i < 4096; i = i + 1) begin
        Mem[addr_o + i] = 8'hff;
    end
    // synthesis translate_on
    status_wel = 1'b0;
end
endtask

task not_supported_cmd;
input   [7:0]   cmd;
begin
    if (cmd_ready) begin
        $display("%0t:spi_flash:ERROR: SPI command 0x%h isn't supported", $realtime, cmd);
        # 100;
        $finish;
    end
end
endtask

// synthesis translate_off



`ifdef DUMP_ENABLE
wire [7:0]   page_buf_tmp_0   = page_buf[0];
wire [7:0]   page_buf_tmp_1   = page_buf[1];
wire [7:0]   page_buf_tmp_2   = page_buf[2];
wire [7:0]   page_buf_tmp_3   = page_buf[3];
wire [7:0]   page_buf_tmp_4   = page_buf[4];
wire [7:0]   page_buf_tmp_5   = page_buf[5];
wire [7:0]   page_buf_tmp_6   = page_buf[6];
wire [7:0]   page_buf_tmp_7   = page_buf[7];
wire [7:0]   page_buf_tmp_8   = page_buf[8];
wire [7:0]   page_buf_tmp_9   = page_buf[9];
wire [7:0]   page_buf_tmp_10   = page_buf[10];
wire [7:0]   page_buf_tmp_11   = page_buf[11];
wire [7:0]   page_buf_tmp_12   = page_buf[12];
wire [7:0]   page_buf_tmp_13   = page_buf[13];
wire [7:0]   page_buf_tmp_14   = page_buf[14];
wire [7:0]   page_buf_tmp_15   = page_buf[15];
wire [7:0]   page_buf_tmp_16   = page_buf[16];
wire [7:0]   page_buf_tmp_17   = page_buf[17];
wire [7:0]   page_buf_tmp_18   = page_buf[18];
wire [7:0]   page_buf_tmp_19   = page_buf[19];
wire [7:0]   page_buf_tmp_20   = page_buf[20];
wire [7:0]   page_buf_tmp_21   = page_buf[21];
wire [7:0]   page_buf_tmp_22   = page_buf[22];
wire [7:0]   page_buf_tmp_23   = page_buf[23];
wire [7:0]   page_buf_tmp_24   = page_buf[24];
wire [7:0]   page_buf_tmp_25   = page_buf[25];
wire [7:0]   page_buf_tmp_26   = page_buf[26];
wire [7:0]   page_buf_tmp_27   = page_buf[27];
wire [7:0]   page_buf_tmp_28   = page_buf[28];
wire [7:0]   page_buf_tmp_29   = page_buf[29];
wire [7:0]   page_buf_tmp_30   = page_buf[30];
wire [7:0]   page_buf_tmp_31   = page_buf[31];
wire [7:0]   page_buf_tmp_32   = page_buf[32];
wire [7:0]   page_buf_tmp_33   = page_buf[33];
wire [7:0]   page_buf_tmp_34   = page_buf[34];
wire [7:0]   page_buf_tmp_35   = page_buf[35];
wire [7:0]   page_buf_tmp_36   = page_buf[36];
wire [7:0]   page_buf_tmp_37   = page_buf[37];
wire [7:0]   page_buf_tmp_38   = page_buf[38];
wire [7:0]   page_buf_tmp_39   = page_buf[39];
wire [7:0]   page_buf_tmp_40   = page_buf[40];
wire [7:0]   page_buf_tmp_41   = page_buf[41];
wire [7:0]   page_buf_tmp_42   = page_buf[42];
wire [7:0]   page_buf_tmp_43   = page_buf[43];
wire [7:0]   page_buf_tmp_44   = page_buf[44];
wire [7:0]   page_buf_tmp_45   = page_buf[45];
wire [7:0]   page_buf_tmp_46   = page_buf[46];
wire [7:0]   page_buf_tmp_47   = page_buf[47];
wire [7:0]   page_buf_tmp_48   = page_buf[48];
wire [7:0]   page_buf_tmp_49   = page_buf[49];
wire [7:0]   page_buf_tmp_50   = page_buf[50];
wire [7:0]   page_buf_tmp_51   = page_buf[51];
wire [7:0]   page_buf_tmp_52   = page_buf[52];
wire [7:0]   page_buf_tmp_53   = page_buf[53];
wire [7:0]   page_buf_tmp_54   = page_buf[54];
wire [7:0]   page_buf_tmp_55   = page_buf[55];
wire [7:0]   page_buf_tmp_56   = page_buf[56];
wire [7:0]   page_buf_tmp_57   = page_buf[57];
wire [7:0]   page_buf_tmp_58   = page_buf[58];
wire [7:0]   page_buf_tmp_59   = page_buf[59];
wire [7:0]   page_buf_tmp_60   = page_buf[60];
wire [7:0]   page_buf_tmp_61   = page_buf[61];
wire [7:0]   page_buf_tmp_62   = page_buf[62];
wire [7:0]   page_buf_tmp_63   = page_buf[63];
wire [7:0]   page_buf_tmp_64   = page_buf[64];
wire [7:0]   page_buf_tmp_65   = page_buf[65];
wire [7:0]   page_buf_tmp_66   = page_buf[66];
wire [7:0]   page_buf_tmp_67   = page_buf[67];
wire [7:0]   page_buf_tmp_68   = page_buf[68];
wire [7:0]   page_buf_tmp_69   = page_buf[69];
wire [7:0]   page_buf_tmp_70   = page_buf[70];
wire [7:0]   page_buf_tmp_71   = page_buf[71];
wire [7:0]   page_buf_tmp_72   = page_buf[72];
wire [7:0]   page_buf_tmp_73   = page_buf[73];
wire [7:0]   page_buf_tmp_74   = page_buf[74];
wire [7:0]   page_buf_tmp_75   = page_buf[75];
wire [7:0]   page_buf_tmp_76   = page_buf[76];
wire [7:0]   page_buf_tmp_77   = page_buf[77];
wire [7:0]   page_buf_tmp_78   = page_buf[78];
wire [7:0]   page_buf_tmp_79   = page_buf[79];
wire [7:0]   page_buf_tmp_80   = page_buf[80];
wire [7:0]   page_buf_tmp_81   = page_buf[81];
wire [7:0]   page_buf_tmp_82   = page_buf[82];
wire [7:0]   page_buf_tmp_83   = page_buf[83];
wire [7:0]   page_buf_tmp_84   = page_buf[84];
wire [7:0]   page_buf_tmp_85   = page_buf[85];
wire [7:0]   page_buf_tmp_86   = page_buf[86];
wire [7:0]   page_buf_tmp_87   = page_buf[87];
wire [7:0]   page_buf_tmp_88   = page_buf[88];
wire [7:0]   page_buf_tmp_89   = page_buf[89];
wire [7:0]   page_buf_tmp_90   = page_buf[90];
wire [7:0]   page_buf_tmp_91   = page_buf[91];
wire [7:0]   page_buf_tmp_92   = page_buf[92];
wire [7:0]   page_buf_tmp_93   = page_buf[93];
wire [7:0]   page_buf_tmp_94   = page_buf[94];
wire [7:0]   page_buf_tmp_95   = page_buf[95];
wire [7:0]   page_buf_tmp_96   = page_buf[96];
wire [7:0]   page_buf_tmp_97   = page_buf[97];
wire [7:0]   page_buf_tmp_98   = page_buf[98];
wire [7:0]   page_buf_tmp_99   = page_buf[99];
wire [7:0]   page_buf_tmp_100   = page_buf[100];
wire [7:0]   page_buf_tmp_101   = page_buf[101];
wire [7:0]   page_buf_tmp_102   = page_buf[102];
wire [7:0]   page_buf_tmp_103   = page_buf[103];
wire [7:0]   page_buf_tmp_104   = page_buf[104];
wire [7:0]   page_buf_tmp_105   = page_buf[105];
wire [7:0]   page_buf_tmp_106   = page_buf[106];
wire [7:0]   page_buf_tmp_107   = page_buf[107];
wire [7:0]   page_buf_tmp_108   = page_buf[108];
wire [7:0]   page_buf_tmp_109   = page_buf[109];
wire [7:0]   page_buf_tmp_110   = page_buf[110];
wire [7:0]   page_buf_tmp_111   = page_buf[111];
wire [7:0]   page_buf_tmp_112   = page_buf[112];
wire [7:0]   page_buf_tmp_113   = page_buf[113];
wire [7:0]   page_buf_tmp_114   = page_buf[114];
wire [7:0]   page_buf_tmp_115   = page_buf[115];
wire [7:0]   page_buf_tmp_116   = page_buf[116];
wire [7:0]   page_buf_tmp_117   = page_buf[117];
wire [7:0]   page_buf_tmp_118   = page_buf[118];
wire [7:0]   page_buf_tmp_119   = page_buf[119];
wire [7:0]   page_buf_tmp_120   = page_buf[120];
wire [7:0]   page_buf_tmp_121   = page_buf[121];
wire [7:0]   page_buf_tmp_122   = page_buf[122];
wire [7:0]   page_buf_tmp_123   = page_buf[123];
wire [7:0]   page_buf_tmp_124   = page_buf[124];
wire [7:0]   page_buf_tmp_125   = page_buf[125];
wire [7:0]   page_buf_tmp_126   = page_buf[126];
wire [7:0]   page_buf_tmp_127   = page_buf[127];
wire [7:0]   page_buf_tmp_128   = page_buf[128];
wire [7:0]   page_buf_tmp_129   = page_buf[129];
wire [7:0]   page_buf_tmp_130   = page_buf[130];
wire [7:0]   page_buf_tmp_131   = page_buf[131];
wire [7:0]   page_buf_tmp_132   = page_buf[132];
wire [7:0]   page_buf_tmp_133   = page_buf[133];
wire [7:0]   page_buf_tmp_134   = page_buf[134];
wire [7:0]   page_buf_tmp_135   = page_buf[135];
wire [7:0]   page_buf_tmp_136   = page_buf[136];
wire [7:0]   page_buf_tmp_137   = page_buf[137];
wire [7:0]   page_buf_tmp_138   = page_buf[138];
wire [7:0]   page_buf_tmp_139   = page_buf[139];
wire [7:0]   page_buf_tmp_140   = page_buf[140];
wire [7:0]   page_buf_tmp_141   = page_buf[141];
wire [7:0]   page_buf_tmp_142   = page_buf[142];
wire [7:0]   page_buf_tmp_143   = page_buf[143];
wire [7:0]   page_buf_tmp_144   = page_buf[144];
wire [7:0]   page_buf_tmp_145   = page_buf[145];
wire [7:0]   page_buf_tmp_146   = page_buf[146];
wire [7:0]   page_buf_tmp_147   = page_buf[147];
wire [7:0]   page_buf_tmp_148   = page_buf[148];
wire [7:0]   page_buf_tmp_149   = page_buf[149];
wire [7:0]   page_buf_tmp_150   = page_buf[150];
wire [7:0]   page_buf_tmp_151   = page_buf[151];
wire [7:0]   page_buf_tmp_152   = page_buf[152];
wire [7:0]   page_buf_tmp_153   = page_buf[153];
wire [7:0]   page_buf_tmp_154   = page_buf[154];
wire [7:0]   page_buf_tmp_155   = page_buf[155];
wire [7:0]   page_buf_tmp_156   = page_buf[156];
wire [7:0]   page_buf_tmp_157   = page_buf[157];
wire [7:0]   page_buf_tmp_158   = page_buf[158];
wire [7:0]   page_buf_tmp_159   = page_buf[159];
wire [7:0]   page_buf_tmp_160   = page_buf[160];
wire [7:0]   page_buf_tmp_161   = page_buf[161];
wire [7:0]   page_buf_tmp_162   = page_buf[162];
wire [7:0]   page_buf_tmp_163   = page_buf[163];
wire [7:0]   page_buf_tmp_164   = page_buf[164];
wire [7:0]   page_buf_tmp_165   = page_buf[165];
wire [7:0]   page_buf_tmp_166   = page_buf[166];
wire [7:0]   page_buf_tmp_167   = page_buf[167];
wire [7:0]   page_buf_tmp_168   = page_buf[168];
wire [7:0]   page_buf_tmp_169   = page_buf[169];
wire [7:0]   page_buf_tmp_170   = page_buf[170];
wire [7:0]   page_buf_tmp_171   = page_buf[171];
wire [7:0]   page_buf_tmp_172   = page_buf[172];
wire [7:0]   page_buf_tmp_173   = page_buf[173];
wire [7:0]   page_buf_tmp_174   = page_buf[174];
wire [7:0]   page_buf_tmp_175   = page_buf[175];
wire [7:0]   page_buf_tmp_176   = page_buf[176];
wire [7:0]   page_buf_tmp_177   = page_buf[177];
wire [7:0]   page_buf_tmp_178   = page_buf[178];
wire [7:0]   page_buf_tmp_179   = page_buf[179];
wire [7:0]   page_buf_tmp_180   = page_buf[180];
wire [7:0]   page_buf_tmp_181   = page_buf[181];
wire [7:0]   page_buf_tmp_182   = page_buf[182];
wire [7:0]   page_buf_tmp_183   = page_buf[183];
wire [7:0]   page_buf_tmp_184   = page_buf[184];
wire [7:0]   page_buf_tmp_185   = page_buf[185];
wire [7:0]   page_buf_tmp_186   = page_buf[186];
wire [7:0]   page_buf_tmp_187   = page_buf[187];
wire [7:0]   page_buf_tmp_188   = page_buf[188];
wire [7:0]   page_buf_tmp_189   = page_buf[189];
wire [7:0]   page_buf_tmp_190   = page_buf[190];
wire [7:0]   page_buf_tmp_191   = page_buf[191];
wire [7:0]   page_buf_tmp_192   = page_buf[192];
wire [7:0]   page_buf_tmp_193   = page_buf[193];
wire [7:0]   page_buf_tmp_194   = page_buf[194];
wire [7:0]   page_buf_tmp_195   = page_buf[195];
wire [7:0]   page_buf_tmp_196   = page_buf[196];
wire [7:0]   page_buf_tmp_197   = page_buf[197];
wire [7:0]   page_buf_tmp_198   = page_buf[198];
wire [7:0]   page_buf_tmp_199   = page_buf[199];
wire [7:0]   page_buf_tmp_200   = page_buf[200];
wire [7:0]   page_buf_tmp_201   = page_buf[201];
wire [7:0]   page_buf_tmp_202   = page_buf[202];
wire [7:0]   page_buf_tmp_203   = page_buf[203];
wire [7:0]   page_buf_tmp_204   = page_buf[204];
wire [7:0]   page_buf_tmp_205   = page_buf[205];
wire [7:0]   page_buf_tmp_206   = page_buf[206];
wire [7:0]   page_buf_tmp_207   = page_buf[207];
wire [7:0]   page_buf_tmp_208   = page_buf[208];
wire [7:0]   page_buf_tmp_209   = page_buf[209];
wire [7:0]   page_buf_tmp_210   = page_buf[210];
wire [7:0]   page_buf_tmp_211   = page_buf[211];
wire [7:0]   page_buf_tmp_212   = page_buf[212];
wire [7:0]   page_buf_tmp_213   = page_buf[213];
wire [7:0]   page_buf_tmp_214   = page_buf[214];
wire [7:0]   page_buf_tmp_215   = page_buf[215];
wire [7:0]   page_buf_tmp_216   = page_buf[216];
wire [7:0]   page_buf_tmp_217   = page_buf[217];
wire [7:0]   page_buf_tmp_218   = page_buf[218];
wire [7:0]   page_buf_tmp_219   = page_buf[219];
wire [7:0]   page_buf_tmp_220   = page_buf[220];
wire [7:0]   page_buf_tmp_221   = page_buf[221];
wire [7:0]   page_buf_tmp_222   = page_buf[222];
wire [7:0]   page_buf_tmp_223   = page_buf[223];
wire [7:0]   page_buf_tmp_224   = page_buf[224];
wire [7:0]   page_buf_tmp_225   = page_buf[225];
wire [7:0]   page_buf_tmp_226   = page_buf[226];
wire [7:0]   page_buf_tmp_227   = page_buf[227];
wire [7:0]   page_buf_tmp_228   = page_buf[228];
wire [7:0]   page_buf_tmp_229   = page_buf[229];
wire [7:0]   page_buf_tmp_230   = page_buf[230];
wire [7:0]   page_buf_tmp_231   = page_buf[231];
wire [7:0]   page_buf_tmp_232   = page_buf[232];
wire [7:0]   page_buf_tmp_233   = page_buf[233];
wire [7:0]   page_buf_tmp_234   = page_buf[234];
wire [7:0]   page_buf_tmp_235   = page_buf[235];
wire [7:0]   page_buf_tmp_236   = page_buf[236];
wire [7:0]   page_buf_tmp_237   = page_buf[237];
wire [7:0]   page_buf_tmp_238   = page_buf[238];
wire [7:0]   page_buf_tmp_239   = page_buf[239];
wire [7:0]   page_buf_tmp_240   = page_buf[240];
wire [7:0]   page_buf_tmp_241   = page_buf[241];
wire [7:0]   page_buf_tmp_242   = page_buf[242];
wire [7:0]   page_buf_tmp_243   = page_buf[243];
wire [7:0]   page_buf_tmp_244   = page_buf[244];
wire [7:0]   page_buf_tmp_245   = page_buf[245];
wire [7:0]   page_buf_tmp_246   = page_buf[246];
wire [7:0]   page_buf_tmp_247   = page_buf[247];
wire [7:0]   page_buf_tmp_248   = page_buf[248];
wire [7:0]   page_buf_tmp_249   = page_buf[249];
wire [7:0]   page_buf_tmp_250   = page_buf[250];
wire [7:0]   page_buf_tmp_251   = page_buf[251];
wire [7:0]   page_buf_tmp_252   = page_buf[252];
wire [7:0]   page_buf_tmp_253   = page_buf[253];
wire [7:0]   page_buf_tmp_254   = page_buf[254];
wire [7:0]   page_buf_tmp_255   = page_buf[255];
`endif

// synthesis translate_on

endmodule
