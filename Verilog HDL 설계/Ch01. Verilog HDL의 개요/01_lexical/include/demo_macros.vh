// ============================================================================
// PREPROCESSOR HEADER: included as text by a source file
//
// A header guard reduces repeated macro definitions if this file is included
// multiple times in one preprocessing context.
// `define performs text substitution; it does not create a hardware register.
// Parenthesize every use of a macro argument to preserve operator precedence.
// ============================================================================

// Header guard begins.
`ifndef DEMO_MACROS_VH
`define DEMO_MACROS_VH

// A simple replacement of a name with a numeric token.
`define SCALE_VALUE 3

// Parenthesize both the argument and the entire expression.
`define SQUARE(x) ((x) * (x))

`endif
