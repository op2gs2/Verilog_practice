// ============================================================================
// EXAMPLE 05 - Unpacked arrays: memory[word][bit]
// File: testbench.v (illustrative stimulus and observations)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. reg [7:0] memory [0:3] declares four words of eight bits each.
//   2. memory[2] chooses word number 2 (the third word).
//   3. memory[2][3] chooses bit number 3 inside that word.
//   4. Bit indices follow [7:0], so bit 3 is the fourth bit from the right.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
`timescale 1ns/1ps
module testbench;
    reg  [1:0] addr;
    wire [7:0] word;
    wire selected_bit3;
    integer i;
    // The testbench chooses an array word using addr.
    memory_example dut (
        .addr(addr), .word(word), .selected_bit3(selected_bit3)
    );
    initial begin
        for (i=0; i<4; i=i+1) begin
            addr=i; #1;
            // Show the full word and one bit from that same word.
            $display("memory[%0d]=%b, memory[%0d][3]=%b",
                     i, word, i, selected_bit3);
        end
        $finish;
    end
endmodule
