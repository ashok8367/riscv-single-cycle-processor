module Branch_Adder(PC,offset,jal,jalr,branch,rs1,branch_target);
    input [31:0] PC;  
    input [31:0] rs1;
    input branch,jal,jalr;                 
    input [31:0] offset;                
    output reg [31:0] branch_target;  

    always @(*) begin
        if(branch)
        branch_target = PC + (offset);  
        else if(jal)
        branch_target = PC + (offset );
        else if(jalr)
        branch_target = rs1 + (offset );
        else
        branch_target = 0;
    end

endmodule