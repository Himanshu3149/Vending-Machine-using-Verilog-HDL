// Here is the verilog code
// Code your design here
module vending_machine(clk, rst, in, out, change);
  input clk,rst;
  input [1:0]in; // 01 = 5cents    10 = 10cents
  
  output reg out;
  output reg [1:0]change;     // 01 = 5cents    10 = 10cents
  reg [1:0]state;
  
  parameter s0 = 2'b00; 
  parameter s1 = 2'b01;
  parameter s2 = 2'b10;
  
  always @(posedge clk or posedge rst)
   begin
     if(rst == 1) begin
        state <= s0;
        out <= 0;
        change <= 2'b00;
      end
     else
       case(state)
          s0: begin // initially when you go to the machine
            if(in == 2'b00) begin // enter no money
              state <= s0;
              out <= 0;
              change <= 2'b00;
            end
            else if(in == 2'b01) begin // enter 5cents
              state <= s1;
              out <= 0;
              change <= 2'b00;
            end
            else if(in == 2'b10) begin // enter 10cents
              state <= s2;
              out <= 0;
              change <= 2'b00;
            end
          end
          
           s1: begin  // you've already submitted 5cents
             if(in == 2'b00) begin  // cancel transaction 
              state <= s0;
              out <= 0;
              change <= 2'b01; // return 5cents back
            end
             else if(in == 2'b01) begin // enter another 5cents
              state <= s2;
              out <= 0;
              change <= 2'b00;
            end
             else if(in == 2'b10) begin // enter another 10cents
              state <= s0;
              out <= 1;  // you get the cold-drink can
              change <= 2'b00;
            end
           end
         
          s2: begin // you've already submitted 10cents
            if(in == 2'b00) begin // cancel transaction
              state <= s0;
              out <= 0;
              change <= 2'b10; // return 10cents back
            end
            else if(in == 2'b01) begin // amount adds upto 15cents
              state <= s0;
              out <= 1; // you get the cold-drink can
              change <= 2'b00;
            end
            else if(in == 2'b10) begin // amount adds upto 20cents
              state <= s0;
              out <= 1; // you get the cold-drink can
              change <= 2'b01; // you get the extra 5cents back
            end
          end
       endcase
      end
  // end
endmodule
         
