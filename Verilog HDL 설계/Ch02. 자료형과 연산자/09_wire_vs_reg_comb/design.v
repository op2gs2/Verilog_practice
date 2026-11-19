// ============================================================================
// EXAMPLE 09 - Continuous assignment versus procedural combinational assignment
// File: design.v (RTL description)
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
module and_two_ways (
    input wire a, b,
    output wire y_continuous,
    // Procedural assignment requires a variable output in classic Verilog.
    output reg  y_procedural
);
    // Continuously evaluate a AND b and drive the net.
    assign y_continuous = a & b;

    // Re-evaluate this block when a referenced input changes.
    always @(*) begin
        // Blocking assignment is common in combinational always blocks.
        y_procedural = a & b;
    end
endmodule
