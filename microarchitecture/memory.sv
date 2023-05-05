module memory
#(
  parameter WIDTH = 8,  // width of memory data
  parameter ADD_SIZE = 24  // depth of memory
)
(
  input clk,             // clock signal
  input rst,             // asynchronous active low reset
  input enable,          // write enable signal
  input [4*WIDTH-1:0] data,// data input
  input [ADD_SIZE-1:0] addr,// address input
  output [4*WIDTH-1:0] q   // data output
);

  logic [2**ADD_SIZE-1:0] [WIDTH-1:0] mem ;

  // Asynchronous read operation
  assign q = {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};

  // Synchronous write operation
  always @(negedge clk or posedge rst)
    if (rst)
      mem[2**ADD_SIZE-1:0] <= 0;
    else if (enable)
      {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]} <= data;

endmodule