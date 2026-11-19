// ============================================================================
// EXAMPLE 05 - Unpacked arrays: memory[word][bit]
// File: design.v (RTL description)
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
module memory_example (
    input  wire [1:0] addr,
    output wire [7:0] word,
    output wire       selected_bit3
);
    // [7:0] is the width of each word; [0:3] is the word address range.
    reg [7:0] memory [0:3];
    // Provide fixed example contents for demonstration only.
    initial begin
        memory[0] = 8'b1010_1010;
        memory[1] = 8'b1111_0000;
        // Word 2 contains binary 00001111, whose bit 3 is 1.
        memory[2] = 8'b0000_1111;
        memory[3] = 8'b1100_1100;
    end

    // Read the complete eight-bit word selected by addr.
    assign word = memory[addr];
    // Read only bit 3 of the word selected by addr.
    assign selected_bit3 = memory[addr][3];
endmodule
