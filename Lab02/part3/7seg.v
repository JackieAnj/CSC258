//SW[0:3] data inputs
//HES[0][6:0] output 7 segment display

module decoder(HES[0], SW);
	input [0:3] SW;
	output [6:0] HES[0];

	seven_seg_decoder s(
		.HEX(HES[0]),
		.S(SW)
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
