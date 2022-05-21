module MUX4to1(
	input			src1,
	input			src2,
	input			src3,
	input			src4,
	input   [2-1:0] select,
	output reg		result
	);
/* Write your code HERE */
always @(src1 or src2 or src3 or src4 or select) begin
	if(select == 2'b00)begin
        result <= src1;
    end
    else if(select == 2'b01)begin
        result <= src2;
    end
    else if(select == 2'b10)begin
        result <= src3;
    end
    else begin
        result <= src4;
    end
end
endmodule
