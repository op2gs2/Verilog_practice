// ============================================================================
// EXAMPLE 09 - Continuous assignment versus procedural combinational assignment
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. wire is a net typically driven by an assign statement.
//   2. reg is a procedural variable; it does not automatically imply a flip-flop.
//   3. Both styles below describe the same combinational AND operation.
//   4. always @(*) automatically infers the signal sensitivity list.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg a, b;
    wire y_continuous, y_procedural;
    // Use a loop index to enumerate all two-input truth-table rows.
    integer i;
    and_two_ways dut (
        .a(a), .b(b),
        .y_continuous(y_continuous), .y_procedural(y_procedural)
    );
    initial begin
        // There are four possible pairs of binary inputs.
        for (i=0; i<4; i=i+1) begin
            // Split the two-bit loop value into a and b.
            {a,b} = i; #1;
            // Both output styles should match for every input combination.
            $display("a=%b b=%b | assign=%b always=%b",
                     a,b,y_continuous,y_procedural);
        end
        $finish;
    end
endmodule
