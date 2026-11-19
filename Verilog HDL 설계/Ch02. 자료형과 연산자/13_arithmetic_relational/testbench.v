// ============================================================================
// EXAMPLE 13 - Arithmetic, relational, and equality operators
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Addition can require one extra bit for a carry-out.
//   2. Two 8-bit unsigned operands may produce a 16-bit multiplication result.
//   3. Integer division truncates the fractional part; % returns the remainder.
//   4. Comparison operators return a one-bit truth value for known inputs.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [7:0] a,b;
    wire [8:0] sum9;
    wire [7:0] subtract,quotient,remainder;
    wire [15:0] product;
    wire greater,equals;
    arithmetic_example dut (
        .a(a),.b(b),.sum9(sum9),.subtract(subtract),
        .product(product),.quotient(quotient),.remainder(remainder),
        .greater(greater),.equals(equals)
    );
    initial begin
        // Use decimal literals: ten and three.
        a=8'd10; b=8'd3; #1;
        // Display the arithmetic values and comparison flags.
        $display("10+3=%0d, 10-3=%0d, 10*3=%0d",sum9,subtract,product);
        // Inside a display format string, %% prints a literal percent sign.
        $display("10/3=%0d, 10%%3=%0d",quotient,remainder);
        // Display the arithmetic values and comparison flags.
        $display("a>b=%b, a==b=%b",greater,equals);
        $finish;
    end
endmodule
