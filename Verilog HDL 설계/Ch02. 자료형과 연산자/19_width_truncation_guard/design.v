// ============================================================================
// EXAMPLE 19 - Truncation and explicit overflow detection
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Copying 16 bits into eight bits discards the upper eight bits.
//   2. Selecting [7:0] documents intentional use of the low byte.
//   3. Reduction OR over [15:8] detects whether any discarded bit was 1.
//   4. Explicit slicing does not prove the discarded bits were safe to ignore.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module length_guard (
    input  wire [15:0] packet_length,
    output wire [7:0] length_low,
    output wire overflow
);
    // Only the lower eight bits are forwarded.
    assign length_low = packet_length[7:0];
    // Any high-order one-bit means the value does not fit in 8 bits.
    assign overflow = |packet_length[15:8];
endmodule
