// ============================================================================
// EXAMPLE 07 - Parameter and localparam constants
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. parameter sets a value for each module instance at elaboration time.
//   2. localparam defines an internal constant that instantiating modules cannot override.
//   3. WIDTH-1:0 declares exactly WIDTH bits when WIDTH is positive.
//   4. {WIDTH{1'b1}} repeats the one-bit value 1 WIDTH times.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module width_configurable #(
    // WIDTH defaults to eight unless the instance overrides it.
    parameter WIDTH = 8
)(
    // Both ports scale with the same WIDTH constant.
    input  wire [WIDTH-1:0] data_in,
    output wire [WIDTH-1:0] data_out,
    output wire [WIDTH-1:0] max_value
);
    // MAX_COUNT is derived from WIDTH and cannot be overridden directly.
    localparam [WIDTH-1:0] MAX_COUNT = {WIDTH{1'b1}};
    assign data_out  = data_in;
    // Expose the generated all-ones value for illustration.
    assign max_value = MAX_COUNT;
endmodule
