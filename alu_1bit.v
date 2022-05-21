`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);
/* Write your code HERE */
    wire M1out, M2out, andOut, orOut, plusOut, res; 
    
    MUX2to1 M1(src1, ~src1, Ainvert, M1out);
    MUX2to1 M2(src2, ~src2, Binvert, M2out);
    and G1(andOut, M1out, M2out);
    or G2(orOut, M1out, M2out);
    
    wire s1, c1, c2, c;
    xor(s1, M1out, M2out);
    and(c1, M1out, M2out);
    xor(plusOut, s1, cin);
    and(c2, s1, cin);
    xor(c, c2, c1);

    MUX4to1 M3(andOut, orOut, plusOut, less, operation, res);
    always @(*) begin
        cout = c;
        result = res; 
    end
endmodule