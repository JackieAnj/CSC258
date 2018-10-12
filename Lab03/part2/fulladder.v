// SW: Input values to the ripplecarry adder
// LEDR: Output of the ripplecarry adder
module add(
	input [8:0] SW,
	output [4:0] LEDR);
	ripplecarryadder r1(
		.S(LEDR[3:0]),
		.cout(LEDR[4]),
		.cin(SW[8]),
		.X(SW[3:0]),
		.Y(SW[7:4])
	);
endmodule

module fulladder(
	input A,
	input B,
	input Cin,
	output Sum,
	output Cout);
	assign Sum = A ^ B ^ Cin;
	assign Cout = (A & B) | (Cin & (A ^ B));
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
