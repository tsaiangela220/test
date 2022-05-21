module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
/* Write your code HERE */
always @(src1 or src2 or select) begin
    if(select == 1'b0) begin
        result = src1;
    end
    else begin
        result = src2;
    end        
end

endmodule
