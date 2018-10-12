module fpga_top(
    input [9:0] SW,
    input [3:0] KEY,
    input CLOCK_50,
    output [9:0] LEDR,
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    wire reset_n;
    wire go;
    wire [8:0] data_result;
    assign go = ~KEY[1];
    assign reset_n = KEY[0];

    wire [4:0] divisor;
    wire [3:0] dividend;

    dividing d1(
        .clk(CLOCK_50),
        .reset_n(reset_n),
        .go(go),
        .data_in(SW[4:0]),
        .data_result(data_result),
        .divisor(divisor),
        .dividend(dividend)
    );

    assign quotient = data_result[3:0];
    assign remainder = data_result[8:4];

    assign LEDR[9:0] = {6'b000000, quotient};

    hexdecoder H0 (
        .hex_digit(divisor),
        .segments(HEX0)
    );

    hexdecoder H1 (
        .hex_digit(4'b0000),
        .segments(HEX1)
    );

    hexdecoder H2(
        .hex_digit(dividend),
        .segments(HEX2)
    );
    hexdecoder H3 (
        .hex_digit(4'b0000),
        .segments(HEX3)
    );

    hexdecoder H4(
        .hex_digit(quotient),
        .segments(HEX4)
    );

    hexdecoder H5(
        .hex_digit(remainder),
        .segments(HEX5)
    );

endmodule

module dividing(
    input clk,
    input reset_n,
    input go,
    input [4:0] data_in,
    output [9:0] data_result,
    output reg [4:0] divisor,
    output reg [3:0] dividend);

    reg [4:0] a;

    reg q;

    initial a = 5'd0;

    reg [3:0] current_state, next_state;

    localparam S_LOAD_DIVISOR = 4'd0,
        S_LOAD_DIVISOR_WAIT = 4'd1,
        S_LOAD_DIVIDEND = 4'd2,
        S_LOAD_DIVIDEND_WAIT = 4'd3,
        S_CYCLE_0 = 4'd4,
        S_CYCLE_1 = 4'd5,
        S_CYCLE_2 = 4'd6,
        S_CYCLE_3 = 5'd7;

    always @(*)
    begin
        case (current_state)
            S_LOAD_DIVIDEND: next_state =  go ? S_LOAD_DIVIDEND_WAIT : S_LOAD_DIVIDEND;
            S_LOAD_DIVIDEND_WAIT: next_state = go ? S_LOAD_DIVIDEND_WAIT : S_LOAD_DIVISOR;
            S_LOAD_DIVISOR: next_state = go ? S_LOAD_DIVISOR_WAIT : S_LOAD_DIVIDEND;
            S_LOAD_DIVISOR_WAIT: next_state = go ? S_LOAD_DIVISOR_WAIT : S_CYCLE_0;
            S_CYCLE_0: next_state = S_CYCLE_1;
            S_CYCLE_1: next_state = S_CYCLE_2;
            S_CYCLE_2: next_state = S_CYCLE_3;
            S_CYCLE_3: next_state = S_LOAD_DIVIDEND;
            default: next_state = S_LOAD_DIVIDEND;
        endcase
    end

    always @(*)
    begin
        case (current_state)
            S_LOAD_DIVISOR:
                begin
                    divisor <= data_in;
                end
            S_LOAD_DIVIDEND:
                begin
                    dividend <= data_in;
                end
            S_CYCLE_0:
                begin
                    {a, dividend} <= ({a, dividend} << 1'b1);
                    a <= a - divisor;
                    q <= a[4];
                    if (q) a <= a + divisor;
                    dividend[0] <= ~q;
                end
            S_CYCLE_1:
                begin
                    {a, dividend} <= ({a, dividend} << 1'b1);
                    a <= a - divisor;
                    q <= a[4];
                    if (q) a <= a + divisor;
                    dividend[0] <= ~q;
                end
            S_CYCLE_2:
                begin
                    {a, dividend} <= ({a, dividend} << 1'b1);
                    a <= a - divisor;
                    q <= a[4];
                    if (q) a <= a + divisor;
                    dividend[0] <= ~q;
                end
            S_CYCLE_3:
                begin
                    {a, dividend} <= ({a, dividend} << 1'b1);
                    a <= a - divisor;
                    q <= a[4];
                    if (q) a <= a + divisor;
                    dividend[0] <= ~q;
                end
        endcase
    end

    always @(posedge clk)
    begin
        if (!reset_n)
            begin
            	current_state <= S_LOAD_DIVISOR;
            	a <= 5'd0;
            	divisor <= 5'd0;
            	dividend <= 4'd0;
	    end
        else
            current_state <= next_state;
    end

    assign data_result = {a, dividend};
endmodule

module hexdecoder(
    input [3:0] hex_digit,
    output reg [6:0] segments);

    always @(*)
    begin
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;
            default: segments = 7'h7f;
        endcase
    end
endmodule
