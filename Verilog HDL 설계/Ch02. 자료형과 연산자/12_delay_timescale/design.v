// ============================================================================
// EXAMPLE 12 - Simulation delay controls and time units
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. `timescale 1ns/1ps sets a 1-nanosecond time unit and 1-picosecond precision.
//   2. #10 suspends the current procedural thread for ten time units.
//   3. A delay is for simulation timing; it is not a general synthesizable delay circuit.
//   4. Time advances cumulatively: a #10 after #1 reaches 11 ns.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
// Set the time scale explicitly for this illustrative design.
`timescale 1ns/1ps
// The output simply follows the input through a continuous assignment.
module passthrough (
    input wire a,
    output wire y
);
    // No explicit propagation delay is added by this assignment.
    assign y = a;
endmodule
