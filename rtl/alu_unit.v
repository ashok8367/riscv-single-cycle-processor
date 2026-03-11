// ALU unit based on 5-bit control signal from alu_control
module alu_unit (A , B , PC, control_in , zero , ALU_out);

input [31:0] A;
input [31:0] B;
input [4:0] control_in;   // must be 5 bits now
input [31:0] PC;
output reg zero;
output reg [31:0] ALU_out;

always @(*) begin
    case (control_in)

    // Arithmetic
    5'b00000: ALU_out = A + B;                          // ADD / ADDI
    5'b00001: ALU_out = A - B;                          // SUB
    5'b00010: ALU_out = A ^ B;                          // XOR / XORI
    5'b00011: ALU_out = A | B;                          // OR / ORI
    5'b00100: ALU_out = A & B;                          // AND / ANDI

    // Shifts
    5'b00101: ALU_out = A << B[4:0];                    // SLL / SLLI
    5'b00110: ALU_out = A >> B[4:0];                    // SRL / SRLI
    5'b00111: ALU_out = $signed(A) >>> B[4:0];          // SRA / SRAI

    // Comparisons
    5'b01000: ALU_out = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0; // SLT
    5'b01001: ALU_out = (A < B) ? 32'd1 : 32'd0;                   // SLTU

    // Load / Store address calculation
    5'b01111: ALU_out = A + B;                          // address calc

    // Branch comparisons
    5'b10010: ALU_out = (A == B)? 32'd1 : 32'd0;                       // BEQ
    5'b10011: ALU_out = (A != B)? 32'd1 : 32'd0;                       // BNE
    5'b10100: ALU_out = ($signed(A) < $signed(B))? 32'd1 : 32'd0;      // BLT
    5'b10101: ALU_out = ($signed(A) >= $signed(B))? 32'd1 : 32'd0;     // BGE
    5'b10110: ALU_out = (A < B)? 32'd1 : 32'd0;                        // BLTU
    5'b10111: ALU_out = (A >= B)? 32'd1 : 32'd0;                       // BGEU

    // Jump operations
    5'b11000: ALU_out = PC + 4;                          // JALR address
    5'b11001: ALU_out = PC + 4;                          // JAL (PC + 4)

    // U-type
    5'b11010: ALU_out = B;                              // LUI
    5'b11011: ALU_out = PC + B;                          // AUIPC

    default: ALU_out = 32'b0;

    endcase

    zero = ALU_out[0];

    

end

endmodule