`timescale 1ns / 1ps
/* Control Unit
 */
module Control (
    input   clock,
    input   reset,
    input   enable,
    output  control_error,
    
    // To UART interface
    input       [15:0]  rx_word,
    input               rx_word_valid,
    output  reg [15:0]  tx_word,
    output  reg         tx_word_valid,
    input               tx_ack,
    
    // To simulator interface
    output              sim_reset,
    output              sim_enable,
    input               sim_error,
    output              stop_injection,
    output              measure,
    
    input       [9:0]   sim_time,
    input               sim_time_tick,
    input               sim_quiescent,
    
    output  reg [15:0]  config_word,
    output  reg         config_valid,
    output  reg         stats_shift,
    input       [15:0]  stats_word
);

    // Control bits
    `define C_OFFSET    15:12
    
    localparam [3:0] O_RESET = 0,
                     O_COMMON = 1,
                     O_TIMER_VALUE = 2,
                     O_TIMER_VALUE_HI = 3,
                     O_CONFIG_ENABLE = 4,
                     O_DATA_REQUEST = 5,
                     O_STATES_REQUEST = 6;
               
    localparam C_SIM_ENABLE = 0,
               C_MEASURE = 1,
               C_STOP_INJECTION = 2,
               C_TIMER_ENABLE = 3,
               C_NUM_BITS = 4;
    
    localparam DECODE = 0,
               RESET_SIM = 1,
               LOAD_CONFIG_LENGTH = 2,
               CONFIG = 3,
               LOAD_DATA_LENGTH = 4,
               BLOCK_SEND_STATES = 5;

    localparam TX_IDLE = 0,
               TX_SHIFT_DATA = 1,
               TX_SEND_STATE = 2,
               TX_SEND_STATE_2 = 3,
               TX_SEND_STATE_3 = 4,
               TX_SEND_STATE_4 = 5;
               
    // Internal states
    reg     [C_NUM_BITS-1:0]    r_control;
    reg                         r_sim_reset;
    reg     [2:0]               r_state;
    reg     [2:0]               r_tx_state;
    
    reg     [3:0]               r_counter;          // Reset counter
    reg     [23:0]              r_timer_counter;
    reg     [15:0]              r_config_counter;
    reg     [15:0]              r_data_counter;
    
    // Wires
    reg     [2:0]               next_state;
    reg                         next_sim_reset;
    reg     [C_NUM_BITS-1:0]    next_control;
    reg     [2:0]               next_tx_state;
    reg     [15:0]              next_config_word;
    reg                         next_config_valid;
    
    reg                         reset_counter;
    reg                         shift_timer_counter;
    reg                         load_config_counter;
    reg                         load_data_counter;
    reg                         start_send_state;
    
    
    // Output
    assign control_error = 1'b0;
    assign sim_reset = r_sim_reset;
    assign sim_enable = (r_tx_state == TX_IDLE) ? r_control[C_SIM_ENABLE] : 1'b0;
    assign stop_injection = r_control[C_STOP_INJECTION];
    assign measure = r_control[C_MEASURE];
    
    
    //
    // Control FSM
    //
    always @(posedge clock)
    begin
        if (reset)
        begin
            r_state <= DECODE;
            r_sim_reset <= 1'b0;
            r_control <= 0;
            config_word <= 0;
            config_valid <= 0;
        end
        else if (enable)
        begin
            r_state <= next_state;
            r_sim_reset <= next_sim_reset;
            r_control <= next_control;
            config_word <= next_config_word;
            config_valid <= next_config_valid;
        end
    end
    
    always @(*)
    begin
        next_state = r_state;
        next_sim_reset = r_sim_reset;
        next_control = r_control;
        
        reset_counter = 1'b0;
        shift_timer_counter = 1'b0;
        load_config_counter = 1'b0;
        load_data_counter = 1'b0;
        start_send_state = 1'b0;
        
        next_config_word = 0;
        next_config_valid = 1'b0;
        
        case (r_state)
            DECODE:
            begin
                if (rx_word_valid)
                begin
                    case (rx_word[`C_OFFSET])
                        O_RESET:
                        begin
                            next_sim_reset = 1'b1;
                            next_state = RESET_SIM;
                            reset_counter = 1'b1;
                        end
                        
                        O_COMMON:           // Load the command bits
                        begin
                            next_control = rx_word[C_NUM_BITS-1:0];
                        end
                        
                        O_TIMER_VALUE:      // Timer value is encoded in this command
                        begin
                            shift_timer_counter = 1'b1;
                        end
                        
                        O_TIMER_VALUE_HI:
                        begin
                            shift_timer_counter = 1'b1;
                        end
                        
                        O_CONFIG_ENABLE:    // Counter value is in the next command
                        begin
                            next_state = LOAD_CONFIG_LENGTH;
                        end
                        
                        O_DATA_REQUEST:     // Counter value is in the next command
                        begin
                            next_state = LOAD_DATA_LENGTH;
                        end
                        
                        O_STATES_REQUEST:
                        begin
                            if (r_control[C_TIMER_ENABLE] & rx_word[0])
                            begin           // When timer-enable is set, block and send states after sim stops
                                next_state = BLOCK_SEND_STATES;
                            end
                            else            // Non-blocking
                                start_send_state = 1'b1;
                        end                    
                    endcase
                end
            end
            
            RESET_SIM:  // Hold reset for 16 cycles
            begin
                if (r_counter == 0)
                begin
                    next_sim_reset = 1'b0;
                    next_state = DECODE;
                end
            end
            
            LOAD_CONFIG_LENGTH:         // Load the # of config words to receive (N <= 64K)
            begin
                if (rx_word_valid)
                begin
                    load_config_counter = 1'b1;
                    next_state = CONFIG;
                end
            end
            
            CONFIG:                     // Receive words and send to config_word port
            begin
                if (rx_word_valid)
                begin
                    next_config_valid = 1'b1;
                    next_config_word = rx_word;
                    
                    if (r_config_counter == 1)
                        next_state = DECODE;
                end
            end
            
            LOAD_DATA_LENGTH:           // Load the # of data words to send back (N <= 64K)
            begin
                if (rx_word_valid)
                begin
                    load_data_counter = 1'b1;
                    next_state = DECODE;
                end
            end
            
            BLOCK_SEND_STATES:          // Wait until sim_enable is low and initiate send states
            begin
                if (~r_control[C_SIM_ENABLE])
                begin
                    start_send_state = 1'b1;
                    next_state = DECODE;
                end
            end
        endcase
        
        // Timer controlled simulation
        if (r_control[C_TIMER_ENABLE] == 1'b1 && r_timer_counter == 0)
            next_control[C_SIM_ENABLE] = 1'b0;
    end
    
    // Reset counter
    always @(posedge clock)
    begin
        if (reset)
            r_counter <= 4'hF;
        else if (enable)
        begin
            if (reset_counter)
                r_counter <= 4'hF;
            else if (r_state == RESET_SIM)
                r_counter <= r_counter - 1;
        end
        /* // This causes non-deterministic behaviours
        if (reset_counter)
            r_counter <= 4'hF;
        else if (enable)
            r_counter <= r_counter - 1;*/
    end
    
    // Timer counter
    always @(posedge clock)
    begin
        if (reset)
            r_timer_counter <= 0;
        else if (enable)
        begin
            if (shift_timer_counter)
                r_timer_counter <= {rx_word[11:0], r_timer_counter[23:12]}; // load low 12 bits first
            else if (r_control[C_TIMER_ENABLE] & sim_time_tick)
                r_timer_counter <= r_timer_counter - 1;
        end
    end
    
    // Config word counter
    always @(posedge clock)
    begin
        if (reset)
            r_config_counter <= 0;
        else if (enable)
        begin
            if (load_config_counter)
                r_config_counter <= rx_word;
            else if (rx_word_valid)
                r_config_counter <= r_config_counter - 1;
        end
    end
    
    // Data counter
    always @(posedge clock)
    begin
        if (reset)
            r_data_counter <= 0;
        else if (enable)
        begin
            if (load_data_counter)
                r_data_counter <= rx_word;
            else if (tx_ack)
                r_data_counter <= r_data_counter - 1;
        end
    end
    
    //
    // TX State Machine
    //
    always @(posedge clock)
    begin
        if (reset)
            r_tx_state <= TX_IDLE;
        else if (enable)
            r_tx_state <= next_tx_state;
    end
    
    always @(*)
    begin
        next_tx_state = r_tx_state;
        stats_shift = 1'b0;
        tx_word = 0;
        tx_word_valid = 1'b0;
        
        case (r_tx_state)
            TX_IDLE:
            begin
                if (load_data_counter)      // Start sending data words
                    next_tx_state = TX_SHIFT_DATA;
                else if (start_send_state)
                    next_tx_state = TX_SEND_STATE;
            end
            
            TX_SHIFT_DATA:
            begin
                tx_word = stats_word;
                tx_word_valid = 1'b1;
                
                if (tx_ack)
                begin
                    stats_shift = 1'b1;
                    
                    if (r_data_counter == 1)
                        next_tx_state = TX_IDLE;
                end
            end
            
            TX_SEND_STATE:
            begin
                tx_word = {control_error, sim_error, r_control, sim_quiescent, r_state, r_tx_state, 3'h0};
                tx_word_valid = 1'b1;
                
                if (tx_ack)
                    next_tx_state = TX_SEND_STATE_2;
            end
            
            TX_SEND_STATE_2:
            begin
                tx_word = {6'h00, sim_time};
                tx_word_valid = 1'b1;
                
                if (tx_ack)
                    next_tx_state = TX_SEND_STATE_3;
            end
            
            TX_SEND_STATE_3:
            begin
                tx_word = r_timer_counter[15:0];
                tx_word_valid = 1'b1;
                
                if (tx_ack)
                    next_tx_state = TX_SEND_STATE_4;
            end
            
            TX_SEND_STATE_4:
            begin
                tx_word = {8'h00, r_timer_counter[23:16]};
                tx_word_valid = 1'b1;
                
                if (tx_ack)
                    next_tx_state = TX_IDLE;
            end
        endcase
    end

endmodule

