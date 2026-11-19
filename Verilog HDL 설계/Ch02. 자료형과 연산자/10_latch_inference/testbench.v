// ============================================================================
// EXAMPLE 10 - Unintentional latch inference
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. A variable in a combinational always block should be assigned on every path.
//   2. If en is 0 and q is not assigned, the old q value must be preserved.
//   3. That hold behavior can infer a level-sensitive latch.
//   4. A default assignment makes the alternate block fully combinational.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg en, data_in;
    wire latch_q, comb_q;
    // Instantiate the deliberately latch-inferring implementation.
    accidental_latch dut_bad (.en(en), .data_in(data_in), .q(latch_q));
    // Instantiate the corrected combinational implementation.
    safe_comb dut_good (.en(en), .data_in(data_in), .q(comb_q));
    initial begin
        // First load a 1 into both outputs.
        en=1; data_in=1; #1;
        $display("en=1 in=1 | latch=%b comb=%b", latch_q, comb_q);
        // Disable input forwarding; the latch retains 1 while combinational q becomes 0.
        en=0; data_in=0; #1;
        $display("en=0 in=0 | latch=%b comb=%b", latch_q, comb_q);
        $finish;
    end
endmodule
