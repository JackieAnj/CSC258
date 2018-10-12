// SW[3:0]: input A
// SW[7:5]: alu function
// SW[9]: reset_n
// KEY[0]: clock input
// HEX0: display A
// HEX{1-3}: off
// HEX4: least sig 4 bit of alu_out
// HEX5: most sig 4 bit of alu_ou
module simulate(
	input [9:0] SW,
	input [3:0] KEY,
	output [7:0] LEDR,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5);
	wire [7:0] reg_out;
	wire [7:0] alu_out;
	alu a1(
		.A(SW[3:0]),
		.B(reg_out[3:0]),
		.K(SW[7:5]),
		.out(alu_out)
		);
	dff d1(
		.clk(KEY[0]),
		.reset_n(SW[9]),
		.in(alu_out),
		.out(reg_out)
		);
	assign LEDR = alu_out;
	seven_seg_decoder s1(
		.in(SW[3:0]),
		.out(HEX0)
		);
	// Off
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	seven_seg_decoder s2(
		.in(reg_out[3:0]),
		.out(HEX4)
		);
	seven_seg_decoder s3(
		.in(reg_out[7:4]),
		.out(HEX5)
		);
endmodule
		
module dff(
	input clk,
	input reset_n,
	input [7:0] in,
	output reg [7:0] out);
	always @(posedge clk) begin
		if (reset_n == 1'b0)
			out <= 0;
		else
			out <= in;
	end
endmodule
	
module alu(
	input [3:0] A,
	input [3:0] B,
	input [2:0] K,
	output reg [7:0] out
	);

	// Case 1
	wire [3:0] a_plus_1_sum;
	wire a_plus_1_cout;
	ripplecarryadder r1(
		.X(A),
		.Y(4'b001),
		.cin(1'b0),
		.in(a_plus_1_sum),
		.cout(a_plus_1_cout)
		);
	// Case 2
	wire [3:0] a_plus_b_sum;
	wire a_plus_b_cout;
	ripplecarryadder r2(
		.X(A),
		.Y(B),
		.cin(1'b0),
		.in(a_plus_b_sum),
		.cout(a_plus_b_cout)
		);
	always @(*)
	begin
		case (K)
			3'b000: out = {3'b000, a_plus_1_cout, a_plus_1_sum};
			3'b001: out = {3'b000, a_plus_b_cout, a_plus_b_sum};
			3'b010: out = A + B;
			3'b011: out = {A | B, A ^ B};
			3'b100: out = {7'b0000000, A || B};
			3'b101: out = B << A;
			3'b110: out = B >>> A;
			3'b111: out = A * B;
		endcase
	end
endmodule

module fulladder(
	input A,
	input B,
	input Cin,
	output inum,
	output Cout);
	assign inum = A ^ B ^ Cin;
	assign Cout = (A & B) | (Cin & (A ^ B));
endmodule

module ripplecarryadder(
	input [3:0] X,
	input [3:0] Y,
	input cin,
	output [3:0] in,
	output cout);
	wire c1,c2,c3;
	// Fulladder 1
	fulladder a1(
		.A(X[0]),
		.B(Y[0]),
		.Cin(cin),
		.Cout(c1),
		.inum(in[0])
	);
	// Fulladder 2
	fulladder a2(
		.A(X[1]),
		.B(Y[1]),
		.Cin(c1),
		.Cout(c2),
		.inum(in[1])
	);
	// Fulladder 3
	fulladder a3(
		.A(X[2]),
		.B(Y[2]),
		.Cin(c2),
		.Cout(c3),
		.inum(in[2])
	);
	// Fulladder 4
	fulladder a4(
		.A(X[3]),
		.B(Y[3]),
		.Cin(c3),
		.Cout(cout),
		.inum(in[3])
	);
endmodule

module seven_seg_decoder(
	output [6:0] out,
	input [3:0] in);

	assign out[0] = (~in[3] & ~in[2] & ~in[1] & in[0]) | (~in[3] & in[2] & ~in[1] & ~in[0]) | (in[3] & in[2] & ~in[1] & in[0]) | (in[3] & ~in[2] & in[1] & in[0]);
	assign out[1] = (in[2] & in[1] & ~in[0]) | (in[3] & in[1] & in[0]) | (~in[3] & in[2] & ~in[1] & in[0]) | (in[3] & in[2] & ~in[1] & ~in[0]);
	assign out[2] = (~in[3] & ~in[2] & in[1] & ~in[0]) | (in[3] & in[2] & in[1]) | (in[3] & in[2] & ~in[0]);
	assign out[3] = (~in[3] & ~in[2] & ~in[1] & in[0]) | (~in[3] & in[2] & ~in[1] & ~in[0]) | (in[3] & ~in[2] & in[1] & ~in[0]) | (in[2] & in[1] & in[0]);
	assign out[4] = (~in[3] & in[0]) | (~in[3] & in[2] & ~in[1]) | (~in[2] & ~in[1] & in[0]);
	assign out[5] = (~in[3] & ~in[2] & in[0]) | (~in[3] & ~ in[2] & in[1]) | (~in[3] & in[1] & in[0]) | (in[3] & in[2] & ~in[1] & in[0]);
	assign out[6] = (~in[3] & ~in[2] & ~in[1]) | (in[3] & in[2] & ~in[1] & ~in[0]) | (~in[3] & in[2] & in[1] & in[0]);
endmodule

