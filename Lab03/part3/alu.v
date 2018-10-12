// SW: input to the alu
// KEY: function selector
// LEDR: output of the alu
// HEX{0-5}: various outputs depending on alu and SW
module simulate(
	input [7:0] SW,
	input [2:0] KEY,
	output [7:0] LEDR,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5);

	wire [7:0] alu_out;
	alu a1(
		.A(SW[7:4]),
		.B(SW[3:0]),
		.K(KEY),
		.out(alu_out)
		);
	assign LEDR[7:0] = alu_out;
	// B
	seven_seg_decoder s1(
		.HEX(HEX0),
		.S(SW[3:0])
		);
	// A
	seven_seg_decoder s2(
		.HEX(HEX2),
		.S(SW[7:4])
		);
	// 0
	seven_seg_decoder s3(
		.HEX(HEX1),
		.S(4'b0000)
		);
	seven_seg_decoder s4(
		.HEX(HEX3),
		.S(4'b0000)
		);
	// ALU[3:0]
	seven_seg_decoder s5(
		.HEX(HEX4),
		.S(alu_out[3:0])
		);
	// ALU[7:4]
	seven_seg_decoder s6(
		.HEX(HEX5),
		.S(alu_out[7:4])
		);
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
		.S(a_plus_1_sum),
		.cout(a_plus_1_cout)
		);
	// Case 2
	wire [3:0] a_plus_b_sum;
	wire a_plus_b_cout;
	ripplecarryadder r2(
		.X(A),
		.Y(B),
		.cin(1'b0),
		.S(a_plus_b_sum),
		.cout(a_plus_b_cout)
		);
	always @(*)
	begin
		case (K)
			3'b111: out = {3'b000, a_plus_1_cout, a_plus_1_sum};
			3'b110: out = {3'b000, a_plus_b_cout, a_plus_b_sum};
			3'b101: out = A + B;
			3'b100: out = {A | B, A ^ B};
			3'b011: out = {7'b0000000, A || B};
			3'b010: out = {A, B};
			default: out = 0;
		endcase
	end
endmodule

module fulladder(
	input A,
	input B,
	input Cin,
	output Sum,
	output Cout);
	assign Sum = A^B^Cin;
	assign Cout = (A&B) | (Cin&(A^B));
endmodule

module ripplecarryadder(
	input [3:0] X,
	input [3:0] Y,
	input cin,
	output [3:0] S,
	output cout);
	wire c1,c2,c3;
	// Fulladder 1
	fulladder a1(
		.A(X[0]),
		.B(Y[0]),
		.Cin(cin),
		.Cout(c1),
		.Sum(S[0])
	);
	// Fulladder 2
	fulladder a2(
		.A(X[1]),
		.B(Y[1]),
		.Cin(c1),
		.Cout(c2),
		.Sum(S[1])
	);
	// Fulladder 3
	fulladder a3(
		.A(X[2]),
		.B(Y[2]),
		.Cin(c2),
		.Cout(c3),
		.Sum(S[2])
	);
	// Fulladder 4
	fulladder a4(
		.A(X[3]),
		.B(Y[3]),
		.Cin(c3),
		.Cout(cout),
		.Sum(S[3])
	);
endmodule

module seven_seg_decoder(HEX, S);
	input [3:0] S;
	output [6:0] HEX;

	assign HEX[0] = (~S[3] & ~S[2] & ~S[1] & S[0]) | (~S[3] & S[2] & ~S[1] & ~S[0]) | (S[3] & S[2] & ~S[1] & S[0]) | (S[3] & ~S[2] & S[1] & S[0]);
	assign HEX[1] = (S[2] & S[1] & ~S[0]) | (S[3] & S[1] & S[0]) | (~S[3] & S[2] & ~S[1] & S[0]) | (S[3] & S[2] & ~S[1] & ~S[0]);
	assign HEX[2] = (~S[3] & ~S[2] & S[1] & ~S[0]) | (S[3] & S[2] & S[1]) | (S[3] & S[2] & ~S[0]);
	assign HEX[3] = (~S[3] & ~S[2] & ~S[1] & S[0]) | (~S[3] & S[2] & ~S[1] & ~S[0]) | (S[3] & ~S[2] & S[1] & ~S[0]) | (S[2] & S[1] & S[0]);
	assign HEX[4] = (~S[3] & S[0]) | (~S[3] & S[2] & ~S[1]) | (~S[2] & ~S[1] & S[0]);
	assign HEX[5] = (~S[3] & ~S[2] & S[0]) | (~S[3] & ~ S[2] & S[1]) | (~S[3] & S[1] & S[0]) | (S[3] & S[2] & ~S[1] & S[0]);
	assign HEX[6] = (~S[3] & ~S[2] & ~S[1]) | (S[3] & S[2] & ~S[1] & ~S[0]) | (~S[3] & S[2] & S[1] & S[0]);
endmodule
