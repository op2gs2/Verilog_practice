// ============================================================================
// EXAMPLE 01 - Four-state equality: == versus ===
// File: testbench.v (illustrative stimulus and observations)
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
`timescale 1ns/1ps
module testbench;
    // A reg can be assigned procedurally inside an initial block.
    reg a;
    wire result_eq, result_case;

    // Instantiate the design and connect it using named ports.
    x_compare dut (
        .a(a), .result_eq(result_eq), .result_case(result_case)
    );

    initial begin
        // First case: both operands are x; only === reports a definite match.
        a = 1'bx; #1;
        $display("a=%b, (a == x)=%b, (a === x)=%b", a, result_eq, result_case);

        // Second case: 0 does not match x under case equality.
        a = 1'b0; #1;
        $display("a=%b, (a == x)=%b, (a === x)=%b", a, result_eq, result_case);

        // Third case: 1 does not match x under case equality.
        a = 1'b1; #1;
        $display("a=%b, (a == x)=%b, (a === x)=%b", a, result_eq, result_case);

        // Fourth case: z and x are distinct four-state values.
        a = 1'bz; #1;
        $display("a=%b, (a == x)=%b, (a === x)=%b", a, result_eq, result_case);
        // Terminate the illustrative simulation sequence.
        $finish;
    end
endmodule
