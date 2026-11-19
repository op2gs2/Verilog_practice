// ============================================================================
// EXAMPLE 20 - Detecting unknown/high-impedance bits in classic Verilog
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Reduction XOR (^data) is x if any bit of data is x or z.
//   2. Case equality ((^data) === 1'bx) maps that condition to 1 or 0.
//   3. Use this for simulation assertions and debugging, not synthesizable hardware.
//   4. A real gate cannot physically distinguish a symbolic simulation x.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [7:0] data;
    wire has_x_or_z;
    xz_detector dut (.data(data),.has_x_or_z(has_x_or_z));
    initial begin
        // Only known bits: expect no unknown detected.
        data=8'b1010_0101; #1;
        $display("data=%b -> unknown=%b",data,has_x_or_z);
        // One x bit causes Reduction XOR to become x.
        data=8'b1010_x010; #1;
        $display("data=%b -> unknown=%b",data,has_x_or_z);
        // One z bit also makes Reduction XOR unknown.
        data=8'b1010_z010; #1;
        $display("data=%b -> unknown=%b",data,has_x_or_z);
        $finish;
    end
endmodule
