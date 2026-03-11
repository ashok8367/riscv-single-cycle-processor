// c0ontrol unit implimentation uding table 

module controlunit ( instruction  , branch , jal, jalr, Memread , MemtoReg ,ALUOp , MemWrite ,ALUSrc ,Reg_write);

input [6:0] instruction;
output  reg branch , jal, jalr, Memread , MemtoReg , MemWrite ,ALUSrc ,Reg_write ;
output reg [2:0] ALUOp;
always@(*)begin 
 case(instruction)

    7'b0110011 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b00100000_000;  //  ---> R-type
    7'b0010011 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b10100000_000;  // ----> I-type
    7'b0000011 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b11110000_001;  // ----> I-type ----> Load-type
    7'b1100111 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b10100001_010;   // ----> I-type ----> JALR  
    7'b1100011 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b00000100_011;   // ----> Branch-type
    7'b0100011 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b10001000_100;   // ----> Store-type
    7'b0110111 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b10100000_101;   // ----> U-type ----> LUI
    7'b0010111 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b10000000_110;   // ----> U-type ----> AUIPC
    7'b1101111 : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} <= 11'b10000010_111;   // ----> J-type ----> JAL
    
    default : {ALUSrc , MemtoReg , Reg_write ,Memread, MemWrite , branch , jal, jalr, ALUOp} =11'b00000000_00;

endcase

end
endmodule   