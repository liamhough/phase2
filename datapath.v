module datapath(
	clk,
	clr,

	// Control Signals
	
	R0out, R0in,
	R1out, R1in,
	R2out, R2in,
	R3out, R3in,
	R4out, R4in,
	R5out, R5in,
	R6out, R6in,
	R7out, R7in,
	R8out, R8in,
	R9out, R9in,
	R10out, R10in,
	R11out, R11in,
	R12out, R12in,
	R13out, R13in,
	R14out, R14in,
	R15out, R15in,
	HIout, HIin,
	LOout, LOin,
	IRout, IRin,
	PCout, PCin,
	Yin,		
	PCval, // for testbenches
	Zhighout, Zlowout, Zin,
	MARin,
	MDRin, MDRout,
	MDR_read,
	Mdatain,
	
	//For ALU OP code:
	control,
	
	//extra inputs
	port_in, port_out,
	c_sign_extended_in, c_sign_extended_out,
	
	// Outputs for testing
	
	R0,
	R1,
	R2,
//	R3,
	R4,
	R5,
//	R6,
//	R7,
//	R8,
//	R9,
//	R10,
//	R11,
//	R12,
//	R13,
//	R14,
//	R15,
	HI,
	LO,
//	//IR,
	//PC,
	ZLO,
	ZHI,
	//Z,
//	BusMuxOut_external,
//	MDR,
//	BusSelect

	);
	
	//define inputs
	input wire clk, clr,
	R0out, R0in,
	R1out, R1in,
	R2out, R2in,
	R3out, R3in,
	R4out, R4in,
	R5out, R5in,
	R6out, R6in,
	R7out, R7in,
	R8out, R8in,
	R9out, R9in,
	R10out, R10in,
	R11out, R11in,
	R12out, R12in,
	R13out, R13in,
	R14out, R14in,
	R15out, R15in,
	HIout, HIin,
	LOout, LOin,
	IRout, IRin,
	PCout, PCin,
	Yin,		// for ALU
	PCval, // for testbenches
	Zhighout, Zlowout, Zin, 
	MARin,
	MDRin, MDRout, //MDRin is like write/enable, while MDR_read is the mux selecting from bus or mdatain
	MDR_read; //for MDR
	input wire [31:0] Mdatain;
	input wire [4:0] control;
	input wire port_in, port_out,
	c_sign_extended_in, c_sign_extended_out;
	
	//define outputs
	
	output wire [31:0]  R0;
	output wire [31:0]  R1;
	output wire [31:0]  R2;
//	output wire [31:0]  R3;
	output wire [31:0]  R4;
	output wire [31:0]  R5;
//	output [31:0]  R6;
//	output [31:0]  R7;
//	output [31:0]  R8;
//	output [31:0]  R9;
//	output [31:0]  R10;
//	output [31:0]  R11;
//	output [31:0]  R12;
//	output [31:0]  R13;
//	output [31:0]  R14;
//	output [31:0]  R15;
	output wire [31:0]  HI;
	output wire [31:0]  LO;
	//output wire [31:0]  PC;
	//output [31:0]  IR;
	output wire [31:0]  ZLO;
	output wire [31:0]  ZHI;
	//output [63:0]  Z;
//	output wire [31:0]  MDR;
//	
//	
//	output [31:0]  BusMuxOut_external;
//	output [31:0] BusSelect;
	
	
	
	
	//define internal wires/signals used by components
	
	wire [31:0] BusMuxIn_R0;
	wire [31:0] BusMuxIn_R1;
	wire [31:0] BusMuxIn_R2;
	wire [31:0] BusMuxIn_R3;
	wire [31:0] BusMuxIn_R4;
	wire [31:0] BusMuxIn_R5;
	wire [31:0] BusMuxIn_R6;
	wire [31:0] BusMuxIn_R7;
	wire [31:0] BusMuxIn_R8;
	wire [31:0] BusMuxIn_R9;
	wire [31:0] BusMuxIn_R10;
	wire [31:0] BusMuxIn_R11;
	wire [31:0] BusMuxIn_R12;
	wire [31:0] BusMuxIn_R13;
	wire [31:0] BusMuxIn_R14;
	wire [31:0] BusMuxIn_R15;
	wire [31:0] BusMuxIn_HI;
	wire [31:0] BusMuxIn_LO;
	wire [31:0] BusMuxIn_ZHI;
	wire [31:0] BusMuxIn_ZLO;
	wire [31:0] BusMuxIn_PC;
	wire [31:0] BusMuxIn_MDR;
	wire [31:0] BusMuxIn_PORT_IN;
	wire [31:0] BusMuxIn_C_SIGN_EXTENDED;
	
	wire [31:0] BusMuxSelector;
									
	assign BusMuxSelector = {8'b00000000,
									c_sign_extended_out,
									port_out,
									MDRout,
									PCout,
									Zlowout,
									Zhighout,
									LOout,
									HIout,
									R15out,
									R14out,
									R13out,
									R12out,
									R11out,
									R10out,
									R9out,
									R8out,
									R7out,
									R6out,
									R5out,
									R4out,
									R3out,
									R2out,
									R1out,
									R0out};
									
									
	
	wire [31:0] BusMuxOut;
	
	wire [63:0] ALU_Out;
	wire [31:0] ALU_In;	//"A" input. "B" input given by Bus.
	
	
	//copy for all 16 registers
	register R0_instance(.clk(clk), .clr(clr), .write(R0in), .D(BusMuxOut), .Q(BusMuxIn_R0));
	register R1_instance(.clk(clk), .clr(clr), .write(R1in), .D(BusMuxOut), .Q(BusMuxIn_R1));
	register R2_instance(.clk(clk), .clr(clr), .write(R2in), .D(BusMuxOut), .Q(BusMuxIn_R2));
	register R3_instance(.clk(clk), .clr(clr), .write(R3in), .D(BusMuxOut), .Q(BusMuxIn_R3));
	register R4_instance(.clk(clk), .clr(clr), .write(R4in), .D(BusMuxOut), .Q(BusMuxIn_R4));
	register R5_instance(.clk(clk), .clr(clr), .write(R5in), .D(BusMuxOut), .Q(BusMuxIn_R5));
	register R6_instance(.clk(clk), .clr(clr), .write(R6in), .D(BusMuxOut), .Q(BusMuxIn_R6));
	register R7_instance(.clk(clk), .clr(clr), .write(R7in), .D(BusMuxOut), .Q(BusMuxIn_R7));
	register R8_instance(.clk(clk), .clr(clr), .write(R8in), .D(BusMuxOut), .Q(BusMuxIn_R8));
	register R9_instance(.clk(clk), .clr(clr), .write(R9in), .D(BusMuxOut), .Q(BusMuxIn_R9));
	register R10_instance(.clk(clk), .clr(clr), .write(R10in), .D(BusMuxOut), .Q(BusMuxIn_R10));
	register R11_instance(.clk(clk), .clr(clr), .write(R11in), .D(BusMuxOut), .Q(BusMuxIn_R11));
	register R12_instance(.clk(clk), .clr(clr), .write(R12in), .D(BusMuxOut), .Q(BusMuxIn_R12));
	register R13_instance(.clk(clk), .clr(clr), .write(R13in), .D(BusMuxOut), .Q(BusMuxIn_R13));
	register R14_instance(.clk(clk), .clr(clr), .write(R14in), .D(BusMuxOut), .Q(BusMuxIn_R14));
	register R15_instance(.clk(clk), .clr(clr), .write(R15in), .D(BusMuxOut), .Q(BusMuxIn_R15));
	
	register HI_instance(.clk(clk), .clr(clr), .write(HIin), .D(BusMuxOut), .Q(BusMuxIn_HI));
	register LO_instance(.clk(clk), .clr(clr), .write(LOin), .D(BusMuxOut), .Q(BusMuxIn_LO));
	register PC_instance(.clk(clk), .clr(clr), .write(PCin), .D(BusMuxOut), .Q(BusMuxIn_PC));
	
	mdr mdr_instance(.busMuxOut(BusMuxOut), .Mdatain(Mdatain), .read(MDR_read), .Q(BusMuxIn_MDR), .clr(clr), .clk(clk), .write(MDRin));
	
	register PORT_instance(.clk(clk), .clr(clr), .write(port_in), .D(BusMuxOut), .Q(BusMuxIn_PORT_IN));
	register C_sign_extended_instance(.clk(clk), .clr(clr), .write(c_sign_extended_in), .D(BusMuxOut), .Q(BusMuxIn_C_SIGN_EXTENDED));
	
	bus bus_instance( //POSSIBLY define input/output before module
	.encoder_in(BusMuxSelector), //32 bit input via registers and other signals
	.bus_out(BusMuxOut),
	.r0_in(BusMuxIn_R0),
	.r1_in(BusMuxIn_R1),
	.r2_in(BusMuxIn_R2),
	.r3_in(BusMuxIn_R3),
	.r4_in(BusMuxIn_R4),
	.r5_in(BusMuxIn_R5),
	.r6_in(BusMuxIn_R6),
	.r7_in(BusMuxIn_R7),
	.r8_in(BusMuxIn_R8),
	.r9_in(BusMuxIn_R9),
	.r10_in(BusMuxIn_R10),
	.r11_in(BusMuxIn_R11),
	.r12_in(BusMuxIn_R12),
	.r13_in(BusMuxIn_R13),
	.r14_in(BusMuxIn_R14),
	.r15_in(BusMuxIn_R15),
	.hi_in(BusMuxIn_HI),
	.lo_in(BusMuxIn_LO),
	.zhi_in(BusMuxIn_ZHI),
	.zlo_in(BusMuxIn_ZLO),
	.pc_in(BusMuxIn_PC),
	.mdr_in(BusMuxIn_MDR),
	.port_in(BusMuxIn_PORT_IN),
	.c_sign_extended_in(BusMuxIn_C_SIGN_EXTENDED)
	);

	register Y_instance(.clk(clk), .clr(clr), .write(Yin), .D(BusMuxOut), .Q(ALU_In));
	register64 Z_instance(.clk(clk), .clr(clr), .write(Zin), .D(ALU_Out), .Qhi(BusMuxIn_ZHI), .Qlo(BusMuxIn_ZLO));
	alu alu_instance(.A(ALU_In), .B(BusMuxOut), .C(ALU_Out), .control(control));
	

//	
	assign R0 = BusMuxIn_R0;
	assign R1 = BusMuxIn_R1;
	assign R2 = BusMuxIn_R2;
//	assign R3 = BusMuxIn_R3;
	assign R4 = BusMuxIn_R4;
	assign R5 = BusMuxIn_R5;
//	assign R6 = BusMuxIn_R6;
//	assign R7 = BusMuxIn_R7;
//	assign R8 = BusMuxIn_R8;
//	assign R9 = BusMuxIn_R9;
//	assign R10 = BusMuxIn_R10;
//	assign R11 = BusMuxIn_R11;
//	assign R12 = BusMuxIn_R12;
//	assign R13 = BusMuxIn_R13;
//	assign R14 = BusMuxIn_R14;
//	assign R15 = BusMuxIn_R15;
	assign HI = BusMuxIn_HI;
	assign LO = BusMuxIn_LO;
	assign ZHI = BusMuxIn_ZHI;
	assign ZLO = BusMuxIn_ZLO;
	//assign PC = BusMuxIn_PC;
	//assign Z = {BusMuxIn_ZHI, BusMuxIn_ZLO}; //might not work
	//assign IR = BusMuxIn_IR;
//	assign MDR = BusMuxIn_MDR;
//	assign BusMuxOut_external = BusMuxOut;
//	assign BusSelect = BusMuxSelector;
	
	
endmodule
	