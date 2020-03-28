module bus(
	encoder_in, //32 bit input via registers and other signals
	bus_out,
	r0_in,
	r1_in,
	r2_in,
	r3_in,
	r4_in,
	r5_in,
	r6_in,
	r7_in,
	r8_in,
	r9_in,
	r10_in,
	r11_in,
	r12_in,
	r13_in,
	r14_in,
	r15_in,
	hi_in,
	lo_in,
	zhi_in,
	zlo_in,
	pc_in,
	mdr_in,
	port_in,
	c_sign_extended_in
	);
	input wire [31:0] encoder_in;
	output [31:0] bus_out;
	
	input [31:0] r0_in;
	input [31:0] r1_in;
	input [31:0] r2_in;
	input [31:0] r3_in;
	input [31:0] r4_in;
	input [31:0] r5_in;
	input [31:0] r6_in;
	input [31:0] r7_in;
	input [31:0] r8_in;
	input [31:0] r9_in;
	input [31:0] r10_in;
	input [31:0] r11_in;
	input [31:0] r12_in;
	input [31:0] r13_in;
	input [31:0] r14_in;
	input [31:0] r15_in;
	input [31:0] hi_in;
	input [31:0] lo_in;
	input [31:0] zhi_in;
	input [31:0] zlo_in;
	input [31:0] pc_in;
	input [31:0] mdr_in;
	input [31:0] port_in;
	input [31:0] c_sign_extended_in;
	
	
	
	reg [31:0] bus_out; 

	always @ (encoder_in)
	begin

		case(encoder_in)
			32 'h0000001 : bus_out = r0_in;
			32 'h0000002 : bus_out = r1_in;
			32 'h0000004 : bus_out = r2_in;
			32 'h0000008 : bus_out = r3_in;
			32 'h0000010 : bus_out = r4_in;
			32 'h0000020 : bus_out = r5_in;
			32 'h0000040 : bus_out = r6_in;
			32 'h0000080 : bus_out = r7_in;
			32 'h0000100 : bus_out = r8_in;
			32 'h0000200 : bus_out = r9_in; //512
			32 'h0000400 : bus_out = r10_in;
			32 'h0000800 : bus_out = r11_in;
			32 'h0001000 : bus_out = r12_in;
			32 'h0002000 : bus_out = r13_in;
			32 'h0004000 : bus_out = r14_in;
			32 'h0008000 : bus_out = r15_in;
			32 'h0010000 : bus_out = hi_in; //Hi
			32 'h0020000 : bus_out = lo_in; //LO
			32 'h0040000 : bus_out = zhi_in; //ZHI
			32 'h0080000 : bus_out = zlo_in; //ZLO
			32 'h0100000 : bus_out = pc_in; //PC
			32 'h0200000 : bus_out = mdr_in; //MDR
			32 'h0400000 : bus_out = port_in; //in.port
			32 'h0800000 : bus_out = c_sign_extended_in; //cout

			default : bus_out = r0_in;
		endcase
	end
endmodule