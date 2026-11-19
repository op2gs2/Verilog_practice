// ============================================================================
// EXAMPLE 02 - Wire, tri, and shared buses
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. A net is driven by connected sources rather than storing a value itself.
//   2. wire and tri have the same resolution behavior; tri emphasizes three-state intent.
//   3. Driving z means the source does not actively force a 0 or a 1.
//   4. Two equally strong drivers forcing opposite values create an x in simulation.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
// Both sources drive a single resolved net.
module tri_bus_example (
    input  wire en_a,
    input  wire en_b,
    input  wire data_a,
    input  wire data_b,
    // Using wire here would have the same functional behavior.
    output tri  shared_bus
);
    // Source A either drives data_a or disconnects logically with z.
    assign shared_bus = en_a ? data_a : 1'bz;
    // Source B independently drives data_b or z.
    assign shared_bus = en_b ? data_b : 1'bz;

endmodule
