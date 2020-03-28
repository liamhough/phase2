module conFF(CONin, C2, D, Q)

	input wire [1:0] C2; //[20:19] of IR
	input wire CONin;
	input wire [31:0] D; //input from bus
	output reg Q;
	
	always @ *
	begin	
	case (C2)
	2'b00 :  
	2'b01 :
	2'b10 :
	2'b11 :