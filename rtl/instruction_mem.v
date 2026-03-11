


module instruction_mem(clk,rst,read_addr,instruction_out);

input clk;
input rst;
input [31:0] read_addr;
output reg [31:0] instruction_out;

reg [31:0] memory [0:255];
integer i;

// Combinational read
always @(*) begin
    instruction_out = memory[read_addr >> 2]; // divide by 4 (word aligned)
end

initial begin
    $readmemh("code.hex", memory);
end

endmodule
  