// ============================================================================
// EXAMPLE 01 - Four-state equality: == versus ===
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Verilog models four logic values: 0, 1, x (unknown), and z (high impedance).
//   2. Logical equality (==) can produce x when an operand contains an unknown bit.
//   3. Case equality (===) compares x and z literally and always returns 0 or 1.
//   4. This is a simulation/verification illustration, not a physical X sensor.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
// The DUT provides two views of the same input bit.
module x_compare (
    input  wire a,
    output wire result_eq,
    output wire result_case
);
    // An unknown operand makes the result of logical equality unknown.
    assign result_eq   = (a ==  1'bx);

    // Case equality reports 1 exactly when the input is x.
    assign result_case = (a === 1'bx);
endmodule
