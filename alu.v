/* OP CODES
* Add - 00011
* Sub - 00100
* Shr - 00101 
* Shl - 00110
* RotR- 00111
* RotL- 01000
* AND - 01001
* OR  - 01010
*
* Mul - 01110
* Div - 01111
* Neg - 10000
* NOT - 10001
*
* Nop - 11001
* Halt- 11010
*/

//A is a register Y

module alu(A, B, C, control);
	
	input [31:0] A;
	input [31:0] B;
	input [4:0] control;
	output [63:0] C;
	
	wire [31:0] A; //may need to make this a reg
	wire [31:0] B;
	reg [63:0] C;


	
	wire [63:0] add_out, sub_out, shr_out, shl_out, rotr_out, rotl_out, and_out, or_out, mul_out, div_out, neg_out, not_out, nop_out;
	assign nop_out = 64'h0000;
	
	add32 add_instance (.dataa(A), .datab(B), .overflow(add_out[32]), .result(add_out[31:0]));
	shl32 shl_instance(.input1(A), .input2(B), .out(shl_out));
	sub32a sub_instance (.dataa(A), .datab(B), .overflow(sub_out[32]), .result(sub_out[31:0]));
	shr32 shr_instance(.input1(A), .input2(B), .out(shr_out));
	rotr32 rotr_instance(.input1(A), .input2(B), .out(rotr_out));
	rotl32 rotl_instance(.input1(A), .input2(B), .out(rotl_out));
	and32 and_instance(.input1(A), .input2(B), .out(and_out));	
	or32 or_instance(.input1(A), .input2(B), .out(or_out));	
	div32 div_instance(.input1(A), .input2(B), .out(div_out));
	negate32 negate_instance(.input1(A), .out(neg_out));	
	not32 not_instance(.input1(A), .out(not_out));
	mul32 mul_instance(.input1(A), .input2(B), .out(mul_out));
	
	
	always @ *
	begin : all
		case(control)
			5 'b00011 : begin : add//add

								C <= add_out;
							end
			5 'b00100 : begin : sub //SUBTRACTION

								C <= sub_out;

							end 
			5 'b00101 : begin : shr//Shift right

								C <= shr_out;
							end
			5 'b00110 : begin : shL//shift left
								
								C <= shl_out;							
							end	
			5 'b00111 : begin : rotR //rotate right
	
								C <= rotr_out;
							end
			5 'b01000 : begin : rotL//rotate left

								C <= rotl_out;	
							end 
			5 'b01001 : begin //AND

								C <= and_out;		
							end
			5 'b01010 : begin //OR

								C <= or_out;		
							end
			5 'b01110 : begin //multiply

								C <= mul_out;
							end
			5 'b01111 : begin //divide
	
								C <= div_out;	
							end 
			5 'b10000 : begin //negate

								C <= neg_out;	
								
							end
			5 'b10001 : begin //NOT

								C <= not_out;	
							end
			5 'b11001 : begin //NOP
								C <= nop_out;

							end
			default 		: begin //logic for default
								C <= nop_out;
							end
			endcase
		end

	
endmodule
