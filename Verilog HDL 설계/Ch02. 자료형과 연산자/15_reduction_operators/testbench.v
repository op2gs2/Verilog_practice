// ============================================================================
// EXAMPLE 15 - Reduction operators
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. A unary reduction operator processes every bit of a single vector.
//   2. &data is 1 only if all bits are 1.
//   3. |data is 1 if at least one bit is 1.
//   4. ^data is odd parity: 1 if the number of one-bits is odd.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg [3:0] data;
    wire all_ones,any_one,odd_parity,nand_all,nor_all;
    reduction_example dut (
        .data(data),.all_ones(all_ones),.any_one(any_one),
        .odd_parity(odd_parity),.nand_all(nand_all),.nor_all(nor_all)
    );
    initial begin
        // Three one-bits produce odd parity = 1.
        data=4'b1011; #1;
        // Review one-bit results for each reduction operation.
        $display("data=%b, &=%b, |=%b, ^=%b, ~&=%b, ~|=%b",
                 data,all_ones,any_one,odd_parity,nand_all,nor_all);
        // All-zero data makes Reduction OR = 0.
        data=4'b0000; #1;
        // Review one-bit results for each reduction operation.
        $display("data=%b, &=%b, |=%b, ^=%b",data,all_ones,any_one,odd_parity);
        $finish;
    end
endmodule
