`timescale 1ns/1ps

// ============================================================================
// 18 - HARDWARE REUSE VS. INSTANTIATION / RESOURCE SHARING
// ============================================================================
// 'module' is reusable source design, but each instance is an elaborated
// circuit component, not a software function invocation in time.
//
// duplicated_and: two independent output functions are available at once.
// shared_and: two MUXes choose a pair of inputs for ONE named AND operator.
//
// A single output of 'shared_and' cannot provide both results simultaneously.
// Retaining results of different time slots requires registers and control.
// Note that synthesis optimization may change the final physical gate count.
// ============================================================================

module duplicated_and (
    input wire a,b,c,d,
    output wire y1,y2
);
    and g1(y1,a,b);
    and g2(y2,c,d);
endmodule

module shared_and (
    input wire a,b,c,d,sel,
    output wire y
);
    wire in_left, in_right;
    assign in_left  = sel ? c : a;
    assign in_right = sel ? d : b;
    and u_shared(y,in_left,in_right);
endmodule

module tb_resource_sharing;
    reg a,b,c,d,sel;
    wire y1,y2,y_shared;
    duplicated_and dut_dual(a,b,c,d,y1,y2);
    shared_and dut_shared(a,b,c,d,sel,y_shared);
    initial begin
        a=1; b=0; c=1; d=1; sel=0;
        #1 $display("dual=%b%b selected=%b (a&b)",y1,y2,y_shared);
        #4 sel=1;
        #1 $display("dual=%b%b selected=%b (c&d)",y1,y2,y_shared);
        #1 $finish;
    end
endmodule
