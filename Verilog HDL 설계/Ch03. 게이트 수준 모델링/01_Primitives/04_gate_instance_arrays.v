`timescale 1ns/1ps

// ============================================================================
// 04 - ARRAYS OF GATE PRIMITIVE INSTANCES
// ============================================================================
// Example: and g_and[3:0] (y, a, b);
//
// This elaborates FOUR AND gate instances (not four sequential evaluations).
// With four-bit vectors, each instance receives corresponding input bits:
//   g_and[0]: y[0] = a[0] & b[0]
//   g_and[1]: y[1] = a[1] & b[1]
//   g_and[2]: y[2] = a[2] & b[2]
//   g_and[3]: y[3] = a[3] & b[3]
//
// An input scalar used on the gate array is connected to each instance.
// This creates a shared ENABLE, not four software calls.
// ============================================================================

module gate_instance_arrays (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       en,
    output wire [3:0] y_and,
    output wire [3:0] y_mask,
    output wire [3:0] y_invert,
    output wire [3:0] y_assign
);
    and g_and[3:0] (y_and, a, b);
    and g_mask[3:0] (y_mask, a, en);
    not g_inv[3:0] (y_invert, a);

    // This continuous vector expression is functionally equivalent to g_and.
    assign y_assign = a & b;
endmodule

module tb_gate_instance_arrays;
    reg [3:0] a, b;
    reg en;
    wire [3:0] y_and, y_mask, y_invert, y_assign;
    gate_instance_arrays dut(a,b,en,y_and,y_mask,y_invert,y_assign);
    initial begin
        a=4'b1010; b=4'b1100; en=1;
        #1 $display("a=%b b=%b and=%b mask=%b not=%b assign=%b",
                    a,b,y_and,y_mask,y_invert,y_assign);
        #4 en=0;
        #1 $display("en=%b mask=%b (expected 0000)",en,y_mask);
        #4 $finish;
    end
endmodule
