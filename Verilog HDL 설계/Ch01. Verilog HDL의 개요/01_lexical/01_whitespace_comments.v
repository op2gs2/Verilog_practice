// ============================================================================
// LEXICAL RULES 1: WHITESPACE AND COMMENTS
//
// Tokens include identifiers, keywords, numbers, operators, and punctuation.
// Spaces, tabs, and newlines normally separate tokens without changing logic.
// Examples: "assign y=a&b;" and "assign y = a & b;" have identical meaning.
// However, "endmodule" cannot be divided into "end module".
//
// // begins a comment that ends at the next newline.
// A block comment begins with slash-star and ends with star-slash.
// Block comments cannot be nested.
// Verilog is case-sensitive: Data, data, and DATA are distinct names.
// This file includes stimulus statements solely to illustrate syntax.
// ============================================================================

`timescale 1ns/1ps

module whitespace_comments;
    // reg variables can be assigned by procedural testbench statements.
    reg a;
    reg b;
    // assign drives a wire continuously.
    wire y;

    // Comments have no effect on this AND function.
    assign y = a & b;

    // An initial block is useful for demonstrations and testbenches.
    initial begin
        a=1'b0; b=1'b1;
        // Wait one time unit after the inputs have been assigned.
        #1;
        $display("a=%b b=%b y=%b", a, b, y);

        a = 1'b1;
        #1;
        $display("a=%b b=%b y=%b", a, b, y);
        $finish;
    end
endmodule
