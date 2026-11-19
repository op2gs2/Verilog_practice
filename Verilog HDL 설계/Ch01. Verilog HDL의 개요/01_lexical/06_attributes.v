// ============================================================================
// LEXICAL RULES 6: ATTRIBUTE SYNTAX
//
// Attributes are written as (* attribute = constant_value *).
// They attach metadata to a declaration or other supported construct.
// An EDA tool might recognize hints such as keep or dont_touch.
// Attribute names, supported locations, and effects vary by tool.
// They do not replace the Boolean function specified by the RTL.
// Never assume a given hint has the same effect in every synthesis tool.
// ============================================================================

`timescale 1ns/1ps

module attributes_example (
    input  wire a,
    input  wire b,
    output wire y
);

    // This metadata is a tool hint, not a Boolean operator.
    (* keep = "true", lesson_tag = "attribute_example" *)
    // Intermediate net used to demonstrate an attributed declaration.
    wire and_result;

    assign and_result = a & b;
    assign y = and_result;
endmodule
