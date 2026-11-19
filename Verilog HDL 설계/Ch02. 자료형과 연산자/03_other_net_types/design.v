// ============================================================================
// EXAMPLE 03 - Additional Verilog net types
// File: design.v (RTL description)
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
module special_net_example (
    output wire and_result,
    output wire or_result,
    output wire weak0_result,
    output wire weak1_result,
    output wire gnd_result,
    output wire vdd_result
);
    // Multiple drivers of this net are combined using AND resolution.
    wand wired_and;
    // Multiple drivers of this net are combined using OR resolution.
    wor  wired_or;
    // If no other source drives the net, its resolved value is 0.
    tri0 default_low;
    // If no other source drives the net, its resolved value is 1.
    tri1 default_high;
    // A supply0 net resolves to logic 0.
    supply0 gnd;
    // A supply1 net resolves to logic 1.
    supply1 vdd;

    // Demonstrate the resolution of competing source values.
    assign wired_and = 1'b1;
    // Demonstrate the resolution of competing source values.
    assign wired_and = 1'b0;
    // Demonstrate the resolution of competing source values.
    assign wired_or  = 1'b1;
    // Demonstrate the resolution of competing source values.
    assign wired_or  = 1'b0;

    assign and_result   = wired_and;
    assign or_result    = wired_or;
    assign weak0_result = default_low;
    assign weak1_result = default_high;
    assign gnd_result   = gnd;
    assign vdd_result   = vdd;
endmodule
