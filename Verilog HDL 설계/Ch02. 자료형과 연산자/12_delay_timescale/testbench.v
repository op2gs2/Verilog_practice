// ============================================================================
// EXAMPLE 12 - Simulation delay controls and time units
// File: testbench.v (illustrative stimulus and observations)
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
// The testbench uses the same simulation time units.
`timescale 1ns/1ps
module testbench;
    reg a;
    wire y;
    passthrough dut (.a(a), .y(y));
    initial begin
        // Start with a zero input.
        a=0;
        // Wait one nanosecond before the first observation.
        #1;
        // The $time system function reports the current simulation time.
        $display("time=%0d ns, y=%b", $time, y);
        // Advance ten more nanoseconds to 11 ns.
        #10;
        // Change the input to one.
        a=1;
        // Wait one nanosecond before the first observation.
        #1;
        // The $time system function reports the current simulation time.
        $display("time=%0d ns, y=%b", $time, y);
        // Advance five nanoseconds before the next input change.
        #5;
        // Start with a zero input.
        a=0;
        // Wait one nanosecond before the first observation.
        #1;
        // The $time system function reports the current simulation time.
        $display("time=%0d ns, y=%b", $time, y);
        $finish;
    end
endmodule
