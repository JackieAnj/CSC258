// SW[7:0] load values
// SW[9] reset
// KEY[0] clock
// KEY[1] load_n
// KEY[2] shift right
// KEY[3] arithmetic shift right
// LEDR[7:0] output
module shiftregister(
	input [9:0] SW,
	input [3:0] KEY,
	output [7:0] LEDR);
	shifter shift1(
		.load_val(SW[7:0]),
		.load_n(KEY[1]),
		.shift_right(KEY[2]),
		.asr(KEY[3]),
		.clk(KEY[0]),
		.reset_n(SW[9]),
		.out(LEDR)
		);
endmodule

module shifter(
	input [7:0] load_val,
	input load_n,
	input shift_right,
	input asr,
	input clk,
	input reset_n,
	output [7:0] out);
	wire [7:0] shifterbit_out;
	shifterbit s7(
		.load_val(load_val[7]),
		.in(asr ? shifterbit_out[7] : 1'b0),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[7])
		);
	shifterbit s6(
		.load_val(load_val[6]),
		.in(shifterbit_out[7]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[6])
		);
	shifterbit s5(
		.load_val(load_val[5]),
		.in(shifterbit_out[6]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[5])
		);
	shifterbit s4(
		.load_val(load_val[4]),
		.in(shifterbit_out[5]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[4])
		);
	shifterbit s3(
		.load_val(load_val[3]),
		.in(shifterbit_out[4]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[3])
		);
	shifterbit s2(
		.load_val(load_val[2]),
		.in(shifterbit_out[3]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[2])
		);
	shifterbit s1(
		.load_val(load_val[1]),
		.in(shifterbit_out[2]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[1])
		);
	shifterbit s0(
		.load_val(load_val[0]),
		.in(shifterbit_out[1]),
		.shift(shift_right),
		.load_n(load_n),
		.clk(clk),
		.reset_n(reset_n),
		.out(shifterbit_out[0])
		);
	assign out = shifterbit_out;
endmodule

module shifterbit(
	input load_val,
	input in,
	input shift,
	input load_n,
	input clk,
	input reset_n,
	output out);
	wire dff_out;
	wire shift_mux_out, load_mux_out;
	mux2to1 m1(
		.X(dff_out),
		.Y(in),
		.S(shift),
		.out(shift_mux_out)
		);
	mux2to1 m2(
		.X(load_val),
		.Y(shift_mux_out),
		.S(load_n),
		.out(load_mux_out)
		);
	dff d1(
		.clk(clk),
		.reset_n(reset_n),
		.in(load_mux_out),
		.out(dff_out)
		);
	assign out = dff_out;
endmodule

module mux2to1(
	output out,
	input X,
	input Y, 
	input S);
	assign out = S ? Y : X;
endmodule

module dff(
	input clk,
	input reset_n,
	input in,
	output reg out);
	always @(posedge clk) begin
		if (reset_n == 1'b0)
			out <= 0;
		else
			out <= in;
	end
endmodule

