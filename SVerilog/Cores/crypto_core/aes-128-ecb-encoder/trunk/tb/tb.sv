/**
 * Testbench for standalone simulation of AES-128-ECB encoder
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
 */
module tb ();
    
    logic clk = 1'b0;
    logic rstn = 1'b0;
    
    logic [127:0] plainTextData = 128'h0;
    logic         plainTextData_valid = 1'b0;
    logic [127:0] key = 128'h0;
    
    logic [127:0] cipherData;
    logic         cipherData_valid;
    

    initial begin
        rstn = 1'b0;
        #(1us) rstn = 1'b1;
        run_test;
        $stop;
    end
    
    always #(4167ps) clk = ~clk;
    
    
    
    
    aes128_enc dut(
                        .clk_i        ( clk                   ),
                        .rstn_i       ( rstn                  ),
                                
                        .data_i       ( plainTextData         ),
                        .key_i        ( key                   ),
                        .valid_i      ( plainTextData_valid   ),
                                
            
                        .data_o       ( cipherData            ),
                        .valid_o      ( cipherData_valid      )
                                
                    );
    
    
    task run_test;
        int fd, fdo;
        logic [7:0] buff;
        static integer byte_cnt = 0;
        static logic [127:0] pt_data = 128'h0;
        static logic [127:0] ciph_data = 128'h0;
        static logic [127:0] k = 128'h00112233445566778899aabbccddeeff;
        
        fd = $fopen(`PLAIN_TEXT_PATH, "r");
        if (!fd) $error("Failed to open file %s", `PLAIN_TEXT_PATH);
        else   $display("Successfully opened file %s", `PLAIN_TEXT_PATH);

        fdo = $fopen(`OUTPUT_ENCR_TEXT_PATH, "wb");
        if (!fdo) $error("Failed to create and open file %s", `OUTPUT_ENCR_TEXT_PATH);
        else   $display("Successfully created and opened file %s", `OUTPUT_ENCR_TEXT_PATH);
        
        repeat (10) @(posedge clk);
        while (!$feof(fd)) begin
            buff = $fgetc(fd);
            if (buff==8'hff) continue;
            pt_data[127:0] = {pt_data[120:0], buff};
            if (byte_cnt==15) begin
                send_data(k, pt_data, ciph_data);
                save_data_to_file(fdo, ciph_data);
                pt_data = 128'h0;
                byte_cnt = 0;
            end else begin
                byte_cnt++;
            end
        end
        
        while (byte_cnt<16) begin
            pt_data[127:0] = {pt_data[120:0], 8'h0};
            byte_cnt++;
        end
        send_data(k, pt_data, ciph_data);
        save_data_to_file(fdo, ciph_data);
        
        $fclose(fd);
        $fclose(fdo);
        
        check_data();
        
        #100ns;
    endtask
    
    task save_data_to_file(int fd, logic [127:0] data);
        for (int i=0; i<16; i++) begin
            $fwrite(fd, "%c", data[127:120]);
            data[127:0] = {data[120:0], 8'h0};
        end
    endtask
    
    task check_data();
        int fdo, fde;
        static int index = 0;
        static int err_cnt = 0;
        
        logic [7:0] buffo;
        logic [7:0] buffe;
        
        
        fdo = $fopen(`OUTPUT_ENCR_TEXT_PATH, "r");
        if (!fdo) $error("Failed to open file %s", `OUTPUT_ENCR_TEXT_PATH);
        else      $display("Successfully opened file %s", `OUTPUT_ENCR_TEXT_PATH);

        fde = $fopen(`EXPECTED_ENCR_TEXT_PATH, "r");
        if (!fde) $error("Failed to open file %s", `EXPECTED_ENCR_TEXT_PATH);
        else      $display("Successfully opened file %s", `EXPECTED_ENCR_TEXT_PATH);
        
        while (!$feof(fde)) begin
            if ($feof(fdo)) begin
                err_cnt++;
                $warning("Encoded file is smaller than expected...");
                break;
            end
            buffe = $fgetc(fde);
            buffo = $fgetc(fdo);
            if (buffe!==buffo) begin
                $warning("%03d: Data compare failed!\nExpected: 0x%02H\nEcncoded: 0x%02H", index, buffe, buffo);
                err_cnt++;
            end
            index++;
        end
        
        if (!$feof(fdo)) begin
            $warning("Encoded file is bigger than expected...");
            err_cnt++;
        end

        $fclose(fdo);
        $fclose(fde);
        
        if (err_cnt==0) $display("Encoded and expected data files are completely match!");
        
    endtask

    
    
    task send_data(input logic[127:0] key_i, input logic [127:0] data_i, output logic[127:0] data_o);
        @(posedge clk)
        key = key_i;
        plainTextData = data_i;
        plainTextData_valid = 1'b1;
        $display("[%t]: Plain text data: %016h", $time, plainTextData);
        @(posedge clk);
        key = 128'h0;
        plainTextData = 128'h0;
        plainTextData_valid = 1'b0;
        wait(cipherData_valid);
        $display("[%t]: Ciphered data: %016h\n", $time, cipherData);
        data_o = cipherData;
    endtask
    
endmodule
