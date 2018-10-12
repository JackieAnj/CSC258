module count(
    input [3:0] KEY,
    input [8:0] SW,
    output [6:0] HEX0,
    output [6:0] HEX1);
    wire [7:0] counter_out;
    counter_8bit c81(
        .enable(SW[1]),
        .clk(KEY[0]),
        .clear_b(SW[0]),
        .out(counter_out)
    );
    seven_seg_decoder s1(
        .in(counter_out[3:0]),
        .out(HEX0)
    );
    seven_seg_decoder s2(
        .in(counter_out[7:4]),
        .out(HEX1)
    );
endmodule

module counter_8bit(
    input enable,
    input clk,
    input clear_b,
    output [7:0] out);
    wire [3:0] c4_out1, c4_out2;
    counter_4bit c41(
        .enable(enable),
        .clk(clk),
        .clear_b(clear_b),
        .out(c4_out1)
    );
    counter_4bit c42(
        .enable(enable & c4_out1[3]),
        .clk(clk),
        .clear_b(clear_b),
        .out(c4_out2)
    );
    assign out = {c4_out2, c4_out1};
endmodule

module counter_4bit(
    input enable,
    input clk,
    input clear_b,
    output [3:0] out);
    wire t1_out, t2_out, t3_out, t4_out;
    My_tff t1(
        .clk(clk),
        .reset_n(clear_b),
        .t_signal(enable),
        .out(t1_out)
    );
    My_tff t2(
        .clk(clk),
        .reset_n(clear_b),
        .t_signal(enable & t1_out),
        .out(t2_out)
    );
    My_tff t3(
        .clk(clk),
        .reset_n(clear_b),
        .t_signal(enable & t2_out),
        .out(t3_out)
    );
    My_tff t4(
        .clk(clk),
        .reset_n(clear_b),
        .t_signal(enable & t3_out),
        .out(t4_out)
    );
    assign out = {t4_out, t3_out, t2_out, t1_out};
endmodule


module My_tff(
    input clk,
    input reset_n,
    input t_signal,
    output reg out);
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            out <= 1'b0;
        else if (t_signal)
            out <= ~out;
    end
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
