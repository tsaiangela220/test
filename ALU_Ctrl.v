`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
always @(*) begin
	if(instr[3]==0 && instr[2:0]==3'b000)begin
		ALU_Ctrl_o = 4'b0010;//add
	end
	else if(instr[3]==1 && instr[2:0]==3'b000)begin
		ALU_Ctrl_o <= 4'b0110;//sub
	end
	else if(instr[3]==0 && instr[2:0]==3'b111)begin
		ALU_Ctrl_o = 4'b0000;//and
	end
	else if(instr[3]==0 && instr[2:0]==3'b110)begin
		ALU_Ctrl_o = 4'b0001;//or
	end
	else if(instr[3]==0 && instr[2:0]==3'b100)begin
		ALU_Ctrl_o = 4'b0011;//xor
	end
	else if(instr[3]==0 && instr[2:0]==3'b010)begin
		ALU_Ctrl_o = 4'b0111;//slt
	end
	else if(instr[3]==0 && instr[2:0]==3'b001)begin
		ALU_Ctrl_o = 4'b0100;//sll
	end
	else if(instr[3]==1 && instr[2:0]==3'b101)begin
		ALU_Ctrl_o = 4'b0101;//sra
	end
end

endmodule
