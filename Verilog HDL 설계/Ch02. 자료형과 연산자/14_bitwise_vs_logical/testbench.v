// ============================================================================
// EXAMPLE 14 - Bitwise versus logical operators
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. a & b computes AND independently at corresponding bit positions.
//   2. a && b evaluates each entire vector as a Boolean condition.
//   3. ~a inverts each bit; !a produces a single Boolean result.
//   4. These operators also have defined four-state X/Z propagation rules.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [3:0] a,b;
    wire [3:0] bit_and,bit_or,bit_xor,bit_not;
    wire logical_and,logical_or,logical_not;
    logic_ops_example dut (
        .a(a),.b(b),.bit_and(bit_and),.bit_or(bit_or),
        .bit_xor(bit_xor),.bit_not(bit_not),
        .logical_and(logical_and),.logical_or(logical_or),
        .logical_not(logical_not)
    );
    initial begin
        // Compare 0101 against 0011 in both operator families.
        a=4'b0101; b=4'b0011; #1;
        // Contrast vector-wide answers with single-bit Boolean answers.
        $display("a&b=%b, a|b=%b, a^b=%b, ~a=%b",bit_and,bit_or,bit_xor,bit_not);
        // Contrast vector-wide answers with single-bit Boolean answers.
        $display("a&&b=%b, a||b=%b, !a=%b",logical_and,logical_or,logical_not);
        // Now a is false; logical AND becomes zero and logical NOT one.
        a=0; #1;
        // Contrast vector-wide answers with single-bit Boolean answers.
        $display("a=0 -> a&&b=%b, !a=%b",logical_and,logical_not);
        $finish;
    end
endmodule
