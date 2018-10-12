module morse(
    input [9:0] SW,
    input [3:0] KEY,
    input CLOCK_50,
    output [9:0] LEDR);
    wire [13:0] morse_code;
    wire [24:0] slowcount_out;
    wire [13:0] shift_register;
    morse_lookup m1(
        .control(SW[2:0]),
        .out(morse_code)
    );
    slowcount sc1(
        .clk(CLOCK_50),
        .reset_n(KEY[0]),
        .slow_counter(slowcount_out)
    );
    shiftregister s1(
        .load_val(morse_code),
        .load_n(KEY[1]),
        .shift_left(1'b1),
        .clk(SW[9] ? CLOCK_50 : ((slowcount_out == 25'd0) ? 1'b1 : 1'b0)),
        .reset_n(KEY[0]),
        .out(shift_register)
    );
    assign LEDR[0] = shift_register[13];
endmodule

module shiftregister(
    input [13:0] load_val,
    input load_n,
    input shift_left,
    input clk,
    input reset_n,
    output reg [13:0] out);
    initial out = 14'b0;
    always @(posedge clk, negedge reset_n)
    begin
        if (reset_n == 1'b0)
            out <= 14'b0;
        else if (load_n == 1'b1)
            out <= load_val;
        else if (shift_left == 1'b1)
            out <= out << 1'b1;
    end
endmodule

module morse_lookup(
    input [2:0] control,
    output reg [13:0] out);
    always @(*)
    begin
        case (control)
            3'b000: out = 14'b10101000000000;
            3'b001: out = 14'b11100000000000;
            3'b010: out = 14'b10101110000000;
            3'b011: out = 14'b10101011100000;
            3'b100: out = 14'b10111011100000;
            3'b101: out = 14'b11101010111000;
            3'b110: out = 14'b11101011101110;
            3'b111: out = 14'b11101110101000;
            default: out = 14'b0;
        endcase
    end
endmodule

module slowcount(
    input clk,
    input reset_n,
    output reg [24:0] slow_counter);
    initial slow_counter = 25'd0;
    always @(posedge clk, negedge reset_n)
    begin
        if (reset_n == 1'b0)
            slow_counter <= 25'd25000000;
        else if (slow_counter == 25'd0)
            slow_counter <= 25'd25000000;
        else
            slow_counter <= slow_counter - 1;
    end
endmodule
