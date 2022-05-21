
module alu(
	input                   rst_n,         // negative reset            (input)
	input signed [32-1:0]   src1,          // 32 bits source 1          (input)
	input signed [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
reg cin, Ainvert, Binvert;
    reg [1:0] opCode;
    wire [31:0] res;
	reg [31:0] res2;
    wire [32:0] cot;
    always @(*) begin
        if(ALU_control == 4'b0000)begin //and
            Ainvert = 1'b0;
            Binvert = 1'b0;
            cin = 1'b0;
            opCode = 2'b00; 
        end
        else if(ALU_control == 4'b0001)begin //or
            Ainvert = 1'b0;
            Binvert = 1'b0;
            cin = 1'b0;
            opCode = 2'b01; 
        end  
        else if(ALU_control == 4'b0010)begin //add
            Ainvert = 1'b0;
            Binvert = 1'b0;
            cin = 1'b0;
            opCode = 2'b10; 
        end
        else if(ALU_control == 4'b0110)begin //sub: a-b=a+(!b+1)
            Ainvert = 1'b0;
            Binvert = 1'b1;
            cin = 1'b1;
            opCode = 2'b10; 
        end
        else if(ALU_control == 4'b0111)begin //slt:a-b<0
            Ainvert = 1'b0;
            Binvert = 1'b1;
            cin = 1'b1;
            opCode = 2'b10; 
        end
        else if(ALU_control == 4'b1100)begin //nor=(!a)&(!b)
            Ainvert = 1'b1;
            Binvert = 1'b1;
            cin = 1'b0;
            opCode = 2'b00; 
        end
        else if(ALU_control == 4'b1101)begin //nand=(!a)|(!b)
            Ainvert = 1'b1;
            Binvert = 1'b1;
            cin = 1'b0;
            opCode = 2'b01; 
        end
		else if(ALU_control == 4'b0011)begin//xor
			res2 = src1 ^ src2;
			cout = 0;
			overflow = 0;
		end
		else if(ALU_control == 4'b0100)begin//sll
			res2 = src1 << src2;
			cout = 0;
			overflow = 0;
		end
		else if(ALU_control == 4'b0101)begin//sra
			res2 = src1 >>> src2;
			cout = 0;
			overflow = 0;
		end
		else begin
            Ainvert = 1'b0;
            Binvert = 1'b0;
            cin = 1'b0;
            opCode = 2'b00; 
        end

        if(ALU_control == 4'b0111) begin
            if(src1[31] == src2[31]) begin //同號
                if(res[31] == 1) begin
                    result = {31'b0, 1'b1};
                end else begin
                    result = 32'b0;
                end
            end else begin//異號
                if(src1[31] == 1) begin
                    result = {31'b0, 1'b1};
                end else begin
                    result = 32'b0;
                end
            end
        end
		else if(ALU_control == 4'b0011 || ALU_control == 4'b0100
		        || ALU_control == 4'b0101)begin
			result = res2;
		end
		else begin
            result = res;
        end

        if(result == 0) begin
            zero = 1'b1;
        end else begin
            zero = 1'b0;
        end     
        
        if(ALU_control==4'b0010 || ALU_control==4'b0110)begin
            cout = cot[32];
        end else begin
            cout = 1'b0;
        end
        
        if(ALU_control==4'b0010 || ALU_control==4'b0110)begin
            if(cot[31] != cot[32]) begin
                overflow = 1;
            end else begin
                overflow = 0;
            end
        end else begin
            overflow = 0;
        end
    end

    alu_1bit oneBit(src1[0], src2[0], less, Ainvert, Binvert,  
                    cin, opCode, res[0], cot[1]);
    genvar i;
    generate
        for(i=1; i<32; i=i+1) begin: aaa
            alu_1bit oneBit(src1[i], src2[i], 1'b0, Ainvert, Binvert,  
                            cot[i], opCode, res[i], cot[i+1]);
        end
    endgenerate

endmodule

