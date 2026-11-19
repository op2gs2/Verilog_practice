// ============================================================================
// EXAMPLE 10 - Unintentional latch inference
// File: design.v (RTL description)
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
// This example deliberately demonstrates an unsafe incomplete assignment.
module accidental_latch (
    input  wire en, data_in,
    output reg  q
);
    always @(*) begin
        // No else branch exists; q retains its prior value when en is 0.
        if (en)
            q = data_in;
    end
endmodule

// This version provides a value on all control paths.
module safe_comb (
    input  wire en, data_in,
    output reg  q
);
    always @(*) begin
        // A default value eliminates the need to hold the previous value.
        q = 1'b0;
        // When en is 0, the default assignment keeps q at zero.
        if (en)
            q = data_in;
    end
endmodule
