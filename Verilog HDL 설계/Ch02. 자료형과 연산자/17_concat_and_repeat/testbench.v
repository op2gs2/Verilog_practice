// ============================================================================
// EXAMPLE 17 - Concatenation and replication operators
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. {a,b} forms a vector with a as the high bits and b as the low bits.
//   2. {2{a}} repeats the bit sequence a two times.
//   3. {WIDTH{1'b0}} builds WIDTH zero bits using a constant repetition count.
//   4. Concatenation is useful for packet fields, masks, and data assembly.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [3:0] a,b;
    wire [7:0] concatenated,repeated,zeros;
    concat_example #(.WIDTH(8)) dut (
        .a(a),.b(b),.concatenated(concatenated),
        .repeated(repeated),.zeros(zeros)
    );
    initial begin
        // Use a=0101 and b=0011 to make the concatenation visible.
        a=4'b0101; b=4'b0011; #1;
        // Observe the original order and the repeated pattern.
        $display("{a,b}   = %b",concatenated);
        // Observe the original order and the repeated pattern.
        $display("{2{a}}  = %b",repeated);
        // Observe the original order and the repeated pattern.
        $display("zeros   = %b",zeros);
        $finish;
    end
endmodule
