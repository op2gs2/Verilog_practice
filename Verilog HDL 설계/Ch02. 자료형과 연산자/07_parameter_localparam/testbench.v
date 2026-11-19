// ============================================================================
// EXAMPLE 07 - Parameter and localparam constants
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. parameter sets a value for each module instance at elaboration time.
//   2. localparam defines an internal constant that instantiating modules cannot override.
//   3. WIDTH-1:0 declares exactly WIDTH bits when WIDTH is positive.
//   4. {WIDTH{1'b1}} repeats the one-bit value 1 WIDTH times.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg  [7:0]  data8;
    reg  [15:0] data16;
    wire [7:0] out8, max8;
    wire [15:0] out16, max16;

    // The first instance uses an eight-bit data path.
    width_configurable #(.WIDTH(8)) dut8 (
        .data_in(data8), .data_out(out8), .max_value(max8)
    );
    // The second instance uses a sixteen-bit data path.
    width_configurable #(.WIDTH(16)) dut16 (
        .data_in(data16), .data_out(out16), .max_value(max16)
    );

    initial begin
        // Drive different values into the two independent instances.
        data8=8'hAA; data16=16'h1234; #1;
        // Observe that both data width and maximum value follow WIDTH.
        $display("8-bit: data=%h, max=%h", out8, max8);
        // Observe that both data width and maximum value follow WIDTH.
        $display("16-bit: data=%h, max=%h", out16, max16);
        $finish;
    end
endmodule
