`timescale 1ns/1ps

// ============================================================================
// 03 - MODULE INSTANCES VS. FUNCTION CALLS
// ============================================================================
// A module defines a hardware component with explicit ports. Two instances
// represent two separately elaborated component instances.
//
// A Verilog function packages a calculation expression. Synthesizable
// combinational functions do not instantiate separate modules or imply an
// instruction-like runtime call. Synthesis expands/optimizes their logic.
//
// Neither two module instances nor two function calls guarantee exactly two
// physical AND standard cells after logic optimization. Synthesis may share,
// simplify, replicate, or remap hardware while preserving intended behavior.
// ============================================================================

module reusable_and (
    input  wire a, b,
    output wire y
);
    assign y = a & b;
endmodule

module module_vs_function (
    input  wire a, b, c, d,
    output wire inst_y1, inst_y2,
    output reg func_y1, func_y2
);
    // Two named module instances, independent as elaborated objects.
    reusable_and u_and_0 (.a(a), .b(b), .y(inst_y1));
    reusable_and u_and_1 (.a(c), .b(d), .y(inst_y2));

    // Verilog-2001 function: one return value, zero simulation time.
    function my_and;
        input x;
        input z;
        begin
            my_and = x & z;
        end
    endfunction

    always @(*) begin
        // These calls describe the two desired calculations.
        func_y1 = my_and(a, b);
        func_y2 = my_and(c, d);
    end
endmodule

module tb_module_vs_function;
    reg a, b, c, d;
    wire i1, i2, f1, f2;
    module_vs_function dut(a, b, c, d, i1, i2, f1, f2);
    initial begin
        a=0; b=1; c=1; d=1;
        #1 $display("inst=%b%b function=%b%b", i1, i2, f1, f2);
        #4 a=1; d=0;
        #1 $display("inst=%b%b function=%b%b", i1, i2, f1, f2);
        #1 $finish;
    end
endmodule
