// ============================================================================
// EXAMPLE 21 - Width mismatch: deliberately bad versus explicit slicing
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. This design intentionally contains one implicit 16-to-8-bit assignment.
//   2. A lint checker can warn about potential truncation.
//   3. An explicit slice can document the choice but does not ensure correctness.
//   4. The high-bits flag makes the information loss visible.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [15:0] wide_data;
    wire [7:0] bad_result,intended_low;
    wire high_bits_nonzero;
    width_lint_example dut (
        .wide_data(wide_data),.bad_result(bad_result),
        .intended_low(intended_low),.high_bits_nonzero(high_bits_nonzero)
    );
    initial begin
        // 0x1234 becomes 0x34 when assigned to eight bits.
        wide_data=16'h1234; #1;
        // Compare the implicit result with the deliberate low-byte slice.
        $display("wide=%h, bad=%h, low=%h, overflow=%b",
                 wide_data,bad_result,intended_low,high_bits_nonzero);
        $finish;
    end
endmodule
