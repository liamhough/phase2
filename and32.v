module and32(input1, input2, out);
	input [31:0] input1;
	input [31:0] input2;
	output [63:0] out;
		
	wire [31:0] input1;
	wire [31:0] input2;
	reg [63:0] out;
	always @ *	
	begin
		out = input1 & input2;
	
	end
endmodule