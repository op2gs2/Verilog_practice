`timescale 1ns/1ps

// ============================================================================
// 01 - BASIC LOGIC GATE PRIMITIVES
// ============================================================================
// Goal:
//   Learn the built-in Verilog gate keywords and their port order.
//
// Major concepts:
//   1. Gate primitives are structural module items, not procedural statements.
//   2. Gate pins are positional: (output, input1, input2, ...).
//   3. AND, NAND, OR, NOR, XOR, XNOR support multiple inputs.
//   4. BUF and NOT each have one INPUT but may have one or more OUTPUTS.
//   5. Verilog uses four-state values 0, 1, X (unknown), Z (high impedance).
//      In the BUF/NOT primitive truth tables, a Z input produces X output.
//   6. 'assign y = a;' transfers Z; 'buf (y, a);' treats Z as unknown.
//
// 'initial' and 'always' cannot contain gate instantiations. They may drive
// signals connected to already-instantiated gates, as shown in the testbench.
// ============================================================================

module basic_logic_gates (
    input  wire a,
    input  wire b,
    output wire y_and,
    output wire y_nand,
    output wire y_or,
    output wire y_nor,
    output wire y_xor,
    output wire y_xnor,
    output wire y_buf,
    output wire y_not
);
    and  g_and  (y_and,  a, b);
    nand g_nand (y_nand, a, b);
    or   g_or   (y_or,   a, b);
    nor  g_nor  (y_nor,  a, b);
    xor  g_xor  (y_xor,  a, b);
    xnor g_xnor (y_xnor, a, b);
    buf  g_buf  (y_buf,  a);
    not  g_not  (y_not,  a);
endmodule

module tb_basic_logic_gates;
    reg a, b;
    wire y_and, y_nand, y_or, y_nor;
    wire y_xor, y_xnor, y_buf, y_not;

    basic_logic_gates dut (
        .a(a), .b(b),
        .y_and(y_and), .y_nand(y_nand),
        .y_or(y_or), .y_nor(y_nor),
        .y_xor(y_xor), .y_xnor(y_xnor),
        .y_buf(y_buf), .y_not(y_not)
    );

    initial begin
        $display("time a b AND NAND OR NOR XOR XNOR BUF NOT");
        $monitor("%0.3f ns %b %b  %b    %b    %b   %b   %b    %b    %b   %b",
                 $realtime, a, b, y_and, y_nand, y_or, y_nor,
                 y_xor, y_xnor, y_buf, y_not);
        a = 0; b = 0;
        #10 b = 1;
        #10 a = 1; b = 0;
        #10 b = 1;
        #10 a = 1'bx;
        #10 a = 1'bz; // For BUF/NOT, a Z input becomes an X output.
        #10 $finish;
    end
endmodule
