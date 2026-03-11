module data_memory (
    input clk,
    input rst,
    input Mem_Write,
    input Mem_Read,
    input [2:0] funct3,     
    input [31:0] Read_addr,
    input [31:0] Write_Data,
    output reg [31:0] Mem_data_out
);

reg [7:0] D_Memory [0:255];   // byte addressable memory
integer i;

//------------------------------------------------
// INITIALIZATION
//------------------------------------------------
initial begin
    for(i=0;i<256;i=i+1)
        D_Memory[i] = 8'b0;

    D_Memory[15] = 8'd65;
    D_Memory[17] = 8'd56;
    D_Memory[28] = 8'd88;
end

//------------------------------------------------
// READ (LOAD)
//------------------------------------------------
always @(*) begin
    if(Mem_Read) begin
        case(funct3)

        3'b000: // LB
            Mem_data_out = {{24{D_Memory[Read_addr][7]}}, D_Memory[Read_addr]};

        3'b001: // LH
            Mem_data_out = {{16{D_Memory[Read_addr+1][7]}},
                            D_Memory[Read_addr+1],
                            D_Memory[Read_addr]};

        3'b010: // LW
            Mem_data_out = {D_Memory[Read_addr+3],
                            D_Memory[Read_addr+2],
                            D_Memory[Read_addr+1],
                            D_Memory[Read_addr]};

        3'b100: // LBU
            Mem_data_out = {24'b0, D_Memory[Read_addr]};

        3'b101: // LHU
            Mem_data_out = {16'b0,
                            D_Memory[Read_addr+1],
                            D_Memory[Read_addr]};

        default:
            Mem_data_out = 32'b0;

        endcase
    end
    else
        Mem_data_out = 32'b0;
end

//------------------------------------------------
// WRITE (STORE)
//------------------------------------------------
always @(posedge clk) begin
    if(Mem_Write) begin
        case(funct3)

        3'b000: // SB
            D_Memory[Read_addr] <= Write_Data[7:0];

        3'b001: begin // SH
            D_Memory[Read_addr]   <= Write_Data[7:0];
            D_Memory[Read_addr+1] <= Write_Data[15:8];
        end

        3'b010: begin // SW
            D_Memory[Read_addr]   <= Write_Data[7:0];
            D_Memory[Read_addr+1] <= Write_Data[15:8];
            D_Memory[Read_addr+2] <= Write_Data[23:16];
            D_Memory[Read_addr+3] <= Write_Data[31:24];
        end

        endcase
    end
end

endmodule