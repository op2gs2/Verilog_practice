// ============================================================================
// EXAMPLE 11 - Flip-flop, nonblocking assignment, and asynchronous reset
// File: testbench.v (illustrative stimulus and observations)
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
`timescale 1ns/1ps
module testbench;
    reg clk, rst_n, d;
    wire q;
    // Connect stimulus signals to the one-bit D flip-flop.
    one_bit_dff dut (.clk(clk), .rst_n(rst_n), .d(d), .q(q));
    initial begin
        // Assert reset before clocking the design.
        clk=0; rst_n=0; d=0; #1;
        $display("reset active -> q=%b", q);
        // Release reset and change d without causing a clock edge.
        rst_n=1; d=1; #1;
        $display("before clock -> q=%b", q);
        // Rising edges cause q to sample d.
        clk=1; #1;
        $display("after rising edge -> q=%b", q);
        // A falling edge and data change do not capture a new value.
        clk=0; d=0; #1;
        $display("d changed, clock low -> q=%b", q);
        // Rising edges cause q to sample d.
        clk=1; #1;
        $display("next rising edge -> q=%b", q);
        $finish;
    end
endmodule
