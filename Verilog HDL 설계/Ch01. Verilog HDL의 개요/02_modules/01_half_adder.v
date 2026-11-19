// ============================================================================
// MODULE BASICS 1: HALF ADDER
//
// A module is the primary unit of design reuse and hierarchy in Verilog.
// Ports describe this module's interface, not necessarily chip package pins.
// Inputs a and b produce a 1-bit sum and a 1-bit carry.
//
//   a b | sum carry
//   0 0 |  0    0
//   0 1 |  1    0
//   1 0 |  1    0
//   1 1 |  0    1
//
// A half adder is combinational: it has no clock or stored state.
// ============================================================================

`timescale 1ns/1ps

module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);
    // XOR produces the sum bit without carry-in.
    assign sum   = a ^ b;
    // AND produces carry only when both input bits are 1.
    assign carry = a & b;
endmodule
