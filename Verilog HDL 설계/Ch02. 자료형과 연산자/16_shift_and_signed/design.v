// ============================================================================
// EXAMPLE 16 - Logical shifts, arithmetic shifts, and signed values
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. << shifts left and inserts zeros at the right.
//   2. >> shifts right and inserts zeros at the left.
//   3. >>> copies the sign bit on right shifts when its left operand is signed.
//   4. The signedness of the LEFT operand determines sign extension.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module shift_example (
    input  wire [7:0] unsigned_data,
    // Declare a signed value so >>> can copy the sign bit.
    input  wire signed [7:0] signed_data,
    output wire [7:0] shifted_left,
    output wire [7:0] logical_right,
    output wire signed [7:0] arithmetic_right
);
    // 00001111 << 2 becomes 00111100 in eight bits.
    assign shifted_left   = unsigned_data << 2;
    // Logical right shift fills the upper bits with zeros.
    assign logical_right  = signed_data >> 2;
    // Arithmetic right shift preserves the sign of negative values.
    assign arithmetic_right = signed_data >>> 2;
endmodule
