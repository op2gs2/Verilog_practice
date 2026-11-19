// ============================================================================
// EXAMPLE 19 - Truncation and explicit overflow detection
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Copying 16 bits into eight bits discards the upper eight bits.
//   2. Selecting [7:0] documents intentional use of the low byte.
//   3. Reduction OR over [15:8] detects whether any discarded bit was 1.
//   4. Explicit slicing does not prove the discarded bits were safe to ignore.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [15:0] packet_length;
    wire [7:0] length_low;
    wire overflow;
    length_guard dut (
        .packet_length(packet_length),.length_low(length_low),.overflow(overflow)
    );
    initial begin
        // 100 fits in 8 bits; overflow must be 0.
        packet_length=16'd100; #1;
        $display("length=%0d -> low=%0d, overflow=%b",packet_length,length_low,overflow);
        // 1024 equals 0x0400; its low byte becomes zero.
        packet_length=16'd1024; #1;
        $display("length=%0d -> low=%0d, overflow=%b",packet_length,length_low,overflow);
        // A design must use this flag before trusting the truncated value.
        if (overflow) $display("Detected: cannot fit in 8 bits!");
        $finish;
    end
endmodule
