// Here is the testbench for test
// Code your testbench here
// or browse Examples
module testbench;
  reg clk, rst;
  reg [1:0]in;
  
  wire out;
  wire [1:0]change;
  
  vending_machine DUT(.in(in), .clk(clk), .rst(rst), .out(out), .change(change) );
  
  initial
    begin
      $dumpfile("vending_machine.vcd");
      $dumpvars(0, testbench);
      clk = 1'b0;
      rst = 1'b1;
      #15 rst = 1'b0;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      #2 in = 2'b01;
      #10 in = 2'b01;  #10 in = 2'b01;  #10 in = 2'b01;
      #10 in = 2'b10;  #10 in = 2'b10;
      #10 in = 2'b10;
      #10 in = 2'b10;  #10 in = 2'b01;
      #200 $finish;
    end
  
endmodule
