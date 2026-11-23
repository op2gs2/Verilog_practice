`timescale 1ns/1ps

// ============================================================================
// 12 - CONTINUOUS ASSIGNMENT DELAY VS. NET DELAY
// ============================================================================
// Three related but distinct syntaxes:
//   1) and #5 u_gate (y_gate, a, b);  // Gate primitive delay.
//   2) wire #5 y_net;                  // Net declaration delay.
//   3) assign #5 y_assign = a & b;    // Continuous assignment delay.
//
// Important distinction:
//   wire #5 y_net = a & b;
// is a NET DECLARATION ASSIGNMENT, interpreted as a continuous assignment
// with delay, not the same construct as an explicit delayed net followed
// by a separate driving assignment.
//
// All output transitions can have equal timestamps in simple cases while
// event scheduling and multiple-driver behavior remain different.
// ============================================================================

module continuous_assignment_delay_example (
    input wire a,b,
    output wire gate_delay_y, net_delay_y, assign_delay_y, decl_assign_y
);
    wire #5 delayed_net;

    and #5 g0 (gate_delay_y,a,b);
    and g1 (delayed_net,a,b);
    assign net_delay_y = delayed_net;
    assign #5 assign_delay_y = a & b;

    // Verilog's net declaration assignment form:
    wire #5 declaration_wire = a & b;
    assign decl_assign_y = declaration_wire;
endmodule

module tb_continuous_assignment_delay_example;
    reg a,b;
    wire yg,yn,ya,yd;
    continuous_assignment_delay_example dut(a,b,yg,yn,ya,yd);
    initial begin
        $monitor("t=%0.3f ns a=%b gate=%b net=%b assign=%b decl=%b",
                 $realtime,a,yg,yn,ya,yd);
        a=0; b=1;
        #20 a=1;
        #20 a=0;
        #20 $finish;
    end
endmodule
