//SW[1:0] data inputs
//SW[9] select signal
//LEDR[0] output display

module mux(LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;
	wire c0, c1;
	mux2to1 m1 (
		.x(SW[0]),
		.y(SW[1]),
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
