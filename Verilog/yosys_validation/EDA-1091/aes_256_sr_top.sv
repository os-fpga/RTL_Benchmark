/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module aes_256_sr_top (clk, state, key, out);
    input          clk;
    input          state;
    input          key;
    output         out;

    reg  [127:0] state_reg;
    reg  [255:0] key_reg;

    reg [127:0] out_reg;
    wire [127:0] out_wire;
    
    reg [6:0] cnt;


  always @(posedge clk) begin
    state_reg <= {state_reg[126:0], state};
    key_reg <= {key_reg[254:0], key};
  end
  
  always @(posedge clk)
    cnt <= cnt + 1;
  
  always @(posedge clk)
    if (cnt == 127)
      out_reg <= out_wire;
    else
      out_reg <= {out_reg[126:0], 1'b0};
      
  assign out = out_reg[127];


   aes_256 U1 (
     .clk(clk), 
     .state(state_reg), 
     .key(key_reg), 
     .out(out_wire)
   );


endmodule

