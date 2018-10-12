//SW[3:0] data inputs
//SW[9:8] select signal
//LEDR[0] output display

module mux(LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;
	wire out_m0, out_m1; // output wires from 2to1 mux
	mux2to1 m0 (
		.x(SW[0]),
		.y(SW[1]),
		.s(SW[8]),
		.m(out_m0)
		);
	mux2to1 m1 (
		.x(SW[2]),
		.y(SW[3]),
		.s(SW[8]),
		.m(out_m1)
		);
	mux2to1 m2 (
		.x(out_m0),
		.y(out_m1),
		.s(SW[9]),
		.m(LEDR[0])
		);
endmodule

module mux2to1(m, x, y, s);
	input x;
	input y;
	input s;
	output m;
	assign m = s ? y : x;
endmodule
