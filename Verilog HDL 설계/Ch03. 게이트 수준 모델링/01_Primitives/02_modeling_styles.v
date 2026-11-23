`timescale 1ns/1ps

// ============================================================================
// 02 - STRUCTURAL, DATAFLOW, AND PROCEDURAL MODELING IN ONE MODULE
// ============================================================================
// Structural description: explicitly instantiate AND / OR gates or submodules.
// Dataflow description: write a continuous logical relationship with 'assign'.
// Procedural description: use 'always' or 'initial' statements for operations
//   subject to event / time control.
//
// These styles CAN coexist inside the same Verilog module and source file.
// 'assign' is NOT procedural code; it continuously drives a net.
// The blocking '=' inside always @(*) models combinational logic here.
// The nonblocking '<=' inside always @(posedge clk) describes a register.
//
// IMPORTANT: Procedural ordering is a simulation concept. Hardware blocks
// run concurrently. One 'always' block does not execute after another merely
// because its source code appears below it.
// ============================================================================

module modeling_styles (
    input  wire clk,
    input  wire rst_n,
    input  wire a,
    input  wire b,
    input  wire c,
    output wire structural_out,
    output wire dataflow_out,
    output reg  procedural_out,
    output reg  registered_out
);
    wire w_and;

    // 1) Structural: explicitly connect two gate instances.
    and g0 (w_and, a, b);
    or  g1 (structural_out, w_and, c);

    // 2) Dataflow: mathematically equivalent combinational function.
    assign dataflow_out = (a & b) | c;

    // 3) Procedural combinational logic.
    always @(*) begin
        procedural_out = (a & b) | c;
    end

    // 4) Procedural sequential logic.
    //    registered_out changes only at a rising clock edge or reset edge.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            registered_out <= 1'b0;
        else
            registered_out <= dataflow_out;
    end
endmodule

module tb_modeling_styles;
    reg clk, rst_n, a, b, c;
    wire structural_out, dataflow_out, procedural_out, registered_out;
    modeling_styles dut (
        .clk(clk), .rst_n(rst_n), .a(a), .b(b), .c(c),
        .structural_out(structural_out),
        .dataflow_out(dataflow_out),
        .procedural_out(procedural_out),
        .registered_out(registered_out)
    );
    initial begin
        clk = 0; rst_n = 0;
        a = 0; b = 0; c = 0;
        #2 rst_n = 1;
        #3 a = 1; b = 1;
        #5 clk = 1;   // Register captures the combinational value.
        #5 clk = 0; a = 0;
        #5 clk = 1;
        #5 $finish;
    end
    initial $monitor("t=%0.3f ns comb_struct=%b comb_data=%b comb_proc=%b reg=%b",
                     $realtime, structural_out, dataflow_out,
                     procedural_out, registered_out);
endmodule
