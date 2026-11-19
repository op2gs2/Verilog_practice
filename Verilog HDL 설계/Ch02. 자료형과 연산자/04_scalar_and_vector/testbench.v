// ============================================================================
// EXAMPLE 04 - Scalar signals, vectors, and bit selection
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. A scalar represents one bit; a vector represents several ordered bits.
//   2. For [7:0], the leftmost bit is bit 7 and the rightmost bit is bit 0.
//   3. data[3] selects one bit; data[7:4] selects a four-bit slice.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg  [7:0] data;
    wire bit7, bit3;
    wire [3:0] upper, lower;
    vector_example dut (
        .data(data), .bit7(bit7), .bit3(bit3),
        .upper(upper), .lower(lower)
    );
    initial begin
        // Underscores improve readability but do not change the binary value.
        data = 8'b1010_1100; #1;
        // Inspect the full vector, two selected bits, and two slices.
        $display("data = %b", data);
        // Inspect the full vector, two selected bits, and two slices.
        $display("data[7]=%b, data[3]=%b", bit7, bit3);
        // Inspect the full vector, two selected bits, and two slices.
        $display("data[7:4]=%b, data[3:0]=%b", upper, lower);
        $finish;
    end
endmodule
