// ============================================================================
// EXAMPLE 18 - Conditional operator and 2-to-1 multiplexer
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. condition ? true_value : false_value selects between two expressions.
//   2. A one-bit select of 1 chooses a; a select of 0 chooses b.
//   3. This is commonly synthesized as a 2-to-1 multiplexer.
//   4. When select is x/z, Verilog may merge corresponding data bits.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg select;
    reg [7:0] a,b;
    wire [7:0] y;
    mux_example dut (.select(select),.a(a),.b(b),.y(y));
    initial begin
        // Choose distinct byte patterns to see which path is selected.
        a=8'hAA; b=8'h55;
        // False selects b, which is 0x55.
        select=0; #1;
        // False selects b, which is 0x55.
        $display("select=0 -> y=%h (b=55)",y);
        // True selects a, which is 0xAA.
        select=1; #1;
        // True selects a, which is 0xAA.
        $display("select=1 -> y=%h (a=AA)",y);
        $finish;
    end
endmodule
