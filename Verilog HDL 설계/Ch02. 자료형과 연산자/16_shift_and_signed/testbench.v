// ============================================================================
// EXAMPLE 16 - Logical shifts, arithmetic shifts, and signed values
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. << shifts left and inserts zeros at the right.
//   2. >> shifts right and inserts zeros at the left.
//   3. >>> copies the sign bit on right shifts when its left operand is signed.
//   4. The signedness of the LEFT operand determines sign extension.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [7:0] unsigned_data;
    reg signed [7:0] signed_data;
    wire [7:0] shifted_left, logical_right;
    wire signed [7:0] arithmetic_right;
    shift_example dut (
        .unsigned_data(unsigned_data),.signed_data(signed_data),
        .shifted_left(shifted_left),.logical_right(logical_right),
        .arithmetic_right(arithmetic_right)
    );
    initial begin
        unsigned_data=8'b0000_1111;
        // Negative eight is 11111000 in signed eight-bit two's complement.
        signed_data=-8'sd8; #1;
        // Compare zero-fill and sign-fill results.
        $display("00001111 << 2 = %b",shifted_left);
        // Compare zero-fill and sign-fill results.
        $display("-8 >> 2      = %b (zero fill)",logical_right);
        // Compare zero-fill and sign-fill results.
        $display("-8 >>> 2     = %b (%0d)",arithmetic_right,arithmetic_right);
        $finish;
    end
endmodule
