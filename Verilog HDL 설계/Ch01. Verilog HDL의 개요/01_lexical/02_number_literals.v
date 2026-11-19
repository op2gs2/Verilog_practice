// ============================================================================
// LEXICAL RULES 2: NUMBER LITERALS
//
// General syntax: <width>'[s]<base><digits>
//   8'b1010_0011 : 8-bit binary number
//   8'o17        : 8-bit octal number (decimal 15)
//   8'd15        : 8-bit decimal number
//   8'hAF        : 8-bit hexadecimal number (decimal 175)
//   8'sd15       : signed 8-bit decimal number
//   15           : unsized decimal constant; mind implicit width/sign
// Underscores are digit separators and do not affect numeric values.
//
// Verilog uses four logic states: 0, 1, x (unknown), and z (high impedance).
// The == operator can yield x; the === operator performs exact 4-state matching.
// Width truncation can silently discard the most significant bits.
// For portable RTL, explicitly size important numeric constants.
// ============================================================================

`timescale 1ns/1ps

module number_literals;
    // [7:0] denotes an eight-bit vector (MSB 7, LSB 0).
    reg [7:0] value;
    // signed changes how arithmetic interprets this vector.
    reg signed [7:0] s_val;
    reg [7:0] with_unknown;

    initial begin
        // 8-bit binary A3 = 163 in decimal.
        value = 8'b1010_0011;
        $display("binary : %b = %0d", value, value);
        // 8-bit octal 17 = 15 in decimal.
        value = 8'o17;
        $display("octal  : %b = %0d", value, value);
        // Explicitly sized eight-bit decimal 15.
        value = 8'd15;
        $display("decimal: %b = %0d", value, value);
        // One hexadecimal digit represents four bits.
        value = 8'hAF;
        $display("hex    : %h = %0d", value, value);

        // 300 exceeds 255, so only the low eight bits remain (44).
        value = 8'd300;
        $display("8'd300 truncated: %0d", value);

        // Unary minus produces the two's-complement representation of -5.
        s_val = -8'sd5;
        $display("signed -5: %0d, bits=%b", s_val, s_val);

        // x means unknown; z means high impedance in four-state logic.
        with_unknown = 8'b10x1_zz00;
        $display("4-state number: %b", with_unknown);
        $display("x compare == : %b", 1'bx == 1'bx);
        $display("x compare ===: %b", 1'bx === 1'bx);

        $finish;
    end
endmodule
