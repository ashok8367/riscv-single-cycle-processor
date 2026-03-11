module alu_control ( ALUOp , fun7 , fun3 , Control_out );

input [6:0] fun7;
input [2:0] fun3;
input [2:0] ALUOp;
output reg [4:0] Control_out;

always @(*) begin

case(ALUOp)

3'b000: begin // R-type & I-type
    case({fun7,fun3})
        10'b0000000_000: Control_out = 5'b00000; // ADD / ADDI      
        10'b0100000_000: Control_out = 5'b00001; // SUB
        10'b0000000_100: Control_out = 5'b00010; // XOR
        10'b0000000_110: Control_out = 5'b00011; // OR
        10'b0000000_111: Control_out = 5'b00100; // AND
        10'b0000000_001: Control_out = 5'b00101; // SLL
        10'b0000000_101: Control_out = 5'b00110; // SRL
        10'b0100000_101: Control_out = 5'b00111; // SRA
        10'b0000000_010: Control_out = 5'b01000; // SLT
        10'b0000000_011: Control_out = 5'b01001; // SLTU
        default: Control_out = 5'b00000;
    endcase
end



3'b010: begin // JALR
    Control_out = 5'b11000;
end



3'b011: begin // BRANCH
    case(fun3)
        3'b000: Control_out = 5'b10010; // BEQ
        3'b001: Control_out = 5'b10011; // BNE
        3'b100: Control_out = 5'b10100; // BLT
        3'b101: Control_out = 5'b10101; // BGE
        3'b110: Control_out = 5'b10110; // BLTU
        3'b111: Control_out = 5'b10111; // BGEU
        default: Control_out = 5'b00000;
    endcase
end



3'b101: Control_out = 5'b11010; // LUI

3'b110: Control_out = 5'b11011; // AUIPC

3'b111: Control_out=5'b11001; // JAL

default: Control_out = 5'b00000;

endcase

end

endmodule