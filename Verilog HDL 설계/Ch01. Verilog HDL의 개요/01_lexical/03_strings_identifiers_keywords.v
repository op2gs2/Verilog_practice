// ============================================================================
// LEXICAL RULES 3: STRINGS, IDENTIFIERS, AND RESERVED KEYWORDS
//
// Ordinary identifiers begin with a letter or underscore; later characters
// may include digits, underscores, and dollar signs. Names are case-sensitive.
// Examples: packet_valid, _temporary, count2.
// Reserved keywords such as module, wire, reg, assign, always, begin, end,
// input, and output cannot be ordinary user-defined identifiers.
//
// An escaped identifier begins with a backslash and ends at whitespace.
// Example: \data-out followed by a required separating space.
// Such identifiers are legal but typically avoided for readability.
//
// A quoted string is a sequence of ASCII characters, packed into bits.
// In Verilog, a sufficiently wide reg vector can hold a string literal.
// Useful escapes: \n (newline), \t (tab), \" (quote), \\ (backslash).
// ============================================================================

`timescale 1ns/1ps

module strings_identifiers_keywords;
    // These identifiers differ only by case, which is significant.
    reg Data;
    reg data;
    // The space before ; ends the escaped identifier.
    wire \data-out ;
    // Packed bit storage for up to 32 ASCII bytes.
    reg [8*32-1:0] message;

    // The space after the identifier is mandatory here.
    assign \data-out = Data & data;

    initial begin
        Data = 1'b1;
        data = 1'b0;
        // Verilog string literal stored in a fixed-width bit vector.
        message = "Hello, Verilog!";

        $display("message: %0s", message);
        $display("Data=%b, data=%b, escaped_id=%b", Data, data,
                 \data-out );
        $display("escaped chars: quote=\" tab=\t backslash=\\");
        $display("two lines:\nline two");
        $finish;
    end
endmodule
