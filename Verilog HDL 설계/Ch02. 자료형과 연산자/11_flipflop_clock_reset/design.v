// ============================================================================
// EXAMPLE 11 - Flip-flop, nonblocking assignment, and asynchronous reset
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. posedge clk triggers a state update on each rising clock edge.
//   2. negedge rst_n provides an asynchronous active-low reset.
//   3. Nonblocking <= schedules the registered update for the NBA region.
//   4. Changing d without a rising edge does not update q.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module one_bit_dff (
    input wire clk,
    // The suffix _n conventionally marks an active-low signal.
    input wire rst_n,
    input wire d,
    // q must remember state between clock edges.
    output reg q
);
    // Respond to a rising clock or falling reset.
    always @(posedge clk or negedge rst_n) begin
        // A low reset forces q to zero, regardless of d.
        if (!rst_n)
            q <= 1'b0;
        else
            // Sample d on the clock edge using nonblocking assignment.
            q <= d;
    end
endmodule
