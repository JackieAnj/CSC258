module slowcounter(
    input [9:0] SW,
    input [3:0] KEY,
    input CLOCK_50,
    output [6:0] HEX0);
    wire [3:0] counter_4bit_out;
    wire [27:0] slowcount_out;
    slowcount sc1(
        .clk(CLOCK_50),
        .control(SW[1:0]),
        .reset_n(KEY[0]),
        .slow_counter(slowcount_out)
    );
    counter_4bit c1(
        .enable(1'b1),
        .clk((~SW[1] & ~SW[0]) ? CLOCK_50 : (slowcount_out == 28'd0 ? 1'b1 : 1'b0)),
        .clear_b(KEY[0]),
        .out(counter_4bit_out)
    );
    seven_seg_decoder s1(
        .in(counter_4bit_out),
        .out(HEX0)
    );
endmodule


module slowcount(
    input clk,
    input [1:0] control,
    input reset_n,
    output reg [27:0] slow_counter);
    initial slow_counter = 28'd0;
    reg [27:0] max_value = 28'd50000000;
    always @(*)
    case (control)
        2'b01: max_value = 28'd50000000;
        2'b10: max_value = 28'd100000000;
        2'b11: max_value = 28'd200000000;
        default: max_value = 28'd50000000;
    endcase
    always @(posedge clk, negedge reset_n)
    begin
        if (reset_n == 1'b0)
            slow_counter <= max_value;
        else if (slow_counter == 28'd0)
            slow_counter <= max_value;
        else
            slow_counter <= slow_counter - 1;
    end
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
