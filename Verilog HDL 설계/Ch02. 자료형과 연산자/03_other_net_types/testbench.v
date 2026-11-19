// ============================================================================
// EXAMPLE 03 - Additional Verilog net types
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. wand combines the values of its drivers using wired-AND resolution.
//   2. wor combines driver values using wired-OR resolution.
//   3. tri0 and tri1 provide default pull-down and pull-up values.
//   4. supply0 and supply1 represent strong constant logic supplies.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    wire and_result, or_result, weak0_result, weak1_result, gnd_result, vdd_result;
    // All outputs expose the resolved internal net values.
    special_net_example dut (
        .and_result(and_result), .or_result(or_result),
        .weak0_result(weak0_result), .weak1_result(weak1_result),
        .gnd_result(gnd_result), .vdd_result(vdd_result)
    );
    initial begin
        // Allow continuous assignments to settle before observing them.
        #1;
        // Each display corresponds to one type of net resolution.
        $display("wand 1&0 = %b", and_result);
        // Each display corresponds to one type of net resolution.
        $display("wor  1|0 = %b", or_result);
        // Each display corresponds to one type of net resolution.
        $display("tri0 no driver = %b", weak0_result);
        // Each display corresponds to one type of net resolution.
        $display("tri1 no driver = %b", weak1_result);
        // Each display corresponds to one type of net resolution.
        $display("supply0=%b, supply1=%b", gnd_result, vdd_result);
        $finish;
    end
endmodule
