// ============================================================================
// EXAMPLE 02 - Wire, tri, and shared buses
// File: testbench.v (illustrative stimulus and observations)
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
`timescale 1ns/1ps
module testbench;
    reg en_a, en_b, data_a, data_b;
    // This wire receives the resolved value of the DUT output.
    wire bus_value;
    tri_bus_example dut (
        .en_a(en_a), .en_b(en_b),
        .data_a(data_a), .data_b(data_b), .shared_bus(bus_value)
    );
    initial begin
        // Choose opposing source values to demonstrate bus contention.
        data_a=1'b1; data_b=1'b0;
        // Neither source drives the bus: the net resolves to z.
        en_a=0; en_b=0; #1;
        $display("A=OFF B=OFF -> bus=%b (expect z)", bus_value);
        // Only source A drives: expect 1.
        en_a=1; en_b=0; #1;
        $display("A=ON  B=OFF -> bus=%b (expect 1)", bus_value);
        // Only source B drives: expect 0.
        en_a=0; en_b=1; #1;
        $display("A=OFF B=ON  -> bus=%b (expect 0)", bus_value);
        // Both actively drive opposing values: expect x.
        en_a=1; en_b=1; #1;
        $display("A=ON  B=ON  -> bus=%b (expect x: contention)", bus_value);
        $finish;
    end
endmodule
