// ============================================================================
// EXAMPLE 06 - Sized constants, zero extension, truncation, and sign extension
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. The syntax 4'b1010 means a four-bit binary value equal to decimal 10.
//   2. Assigning a smaller unsigned value to a wider destination zero-extends it.
//   3. Assigning a wider value to a narrower destination discards high bits.
//   4. Extending a signed negative value copies its sign bit.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    wire [3:0] four_bit, truncated;
    wire [7:0] eight_bit;
    wire signed [7:0] sign_extended;
    // No changing inputs are needed because all results are constant.
    constant_width_example dut (
        .four_bit(four_bit), .eight_bit(eight_bit),
        .truncated(truncated), .sign_extended(sign_extended)
    );
    initial begin
        // Allow the continuous assignments to settle.
        #1;
        // Compare zero extension, truncation, and sign extension.
        $display("4'b1010 into 4 bits = %b", four_bit);
        // Compare zero extension, truncation, and sign extension.
        $display("4'b1010 into 8 bits = %b", eight_bit);
        // Compare zero extension, truncation, and sign extension.
        $display("8'b11110000 into 4 bits = %b", truncated);
        // Compare zero extension, truncation, and sign extension.
        $display("signed sign extension = %b (%0d)", sign_extended, sign_extended);
        $finish;
    end
endmodule
