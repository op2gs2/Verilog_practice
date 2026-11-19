// ============================================================================
// LEXICAL RULES 5: COMPILER DIRECTIVES
//
// A backtick (`) introduces a directive; it is not a single quote (').
// Directives are applied during preprocessing, before normal compilation.
//   `timescale            : simulation time unit and precision
//   `include             : insert source text from a header file
//   `define / `undef     : define or remove a text macro
//   `ifdef / `ifndef     : conditional preprocessing
//   `else / `elsif       : alternative conditional branches
//   `endif               : end a conditional block
//   `default_nettype none: disallow accidental implicit wire declarations
//
// A macro is a textual substitution; a parameter belongs to a module's
// elaborated hardware configuration. They are not interchangeable.
// Restoring `default_nettype wire prevents surprises in later files.
// ============================================================================

`timescale 1ns/1ps
// Reject undeclared implicit wires, which often originate from typos.
`default_nettype none

// Include the accompanying .vh file before the module is parsed.
`include "demo_macros.vh"

// Define a default only when the macro has not already been defined.
`ifndef DATA_WIDTH
`define DATA_WIDTH 8
`endif

module preprocessor_directives;
    // The preprocessor substitutes the macro before compilation.
    reg [`DATA_WIDTH-1:0] number;

    initial begin
        number = `SCALE_VALUE;
        $display("DATA_WIDTH=%0d number=%0d", `DATA_WIDTH, number);
        $display("SQUARE(3)=%0d", `SQUARE(3));

// This branch is selected only when USE_VERBOSE is defined.
`ifdef USE_VERBOSE
        $display("USE_VERBOSE is DEFINED: verbose branch");
`else
        $display("USE_VERBOSE is NOT defined: normal branch");
`endif

        $finish;
    end
endmodule

// Restore the common default for independently read source files.
`default_nettype wire
