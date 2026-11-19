// ============================================================================
// EXAMPLE 08 - A constant lookup table built from one vector
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Classic Verilog parameters can hold multi-bit constant vectors.
//   2. Four 8-bit constants can be concatenated into one 32-bit parameter.
//   3. Bit slicing selects an individual eight-bit entry.
//   4. This is a vector-based lookup, not an unpacked parameter array.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    wire [7:0] item0, item2;
    wire item2_bit0;
    // The testbench reads three predefined constant slices.
    constant_vector_table dut (
        .item0(item0), .item2(item2), .item2_bit0(item2_bit0)
    );
    initial begin
        #1;
        // Compare the selected table entries with their expected hex values.
        $display("TABLE item0=%h, item2=%h, item2[0]=%b",
                 item0, item2, item2_bit0);
        $finish;
    end
endmodule
