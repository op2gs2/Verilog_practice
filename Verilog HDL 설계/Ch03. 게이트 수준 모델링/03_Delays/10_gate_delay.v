`timescale 1ns/1ps

// ============================================================================
// 10 - GATE PROPAGATION DELAY
// ============================================================================
// All basic logic gate primitives (AND/OR/NOT/BUF/...) accept delay syntax.
// A gate delay models when a primitive output transition occurs after its
// inputs change. This is a SIMULATION model, not a cell-size selection or a
// synthesis constraint for physical silicon.
//
//   and #3 u_and(y,a,b); => 3 * 1ns = 3ns for this source file.
// 'timescale 1ns/1ps' defines a time unit of 1ns, precision of 1ps.
// ============================================================================

module gate_delay_example (
    input  wire a,b,
    output wire y_zero, y_three, y_seven
);
    and    u0 (y_zero, a, b);    // No explicit gate delay.
    and #3 u1 (y_three, a, b);  // 3ns delay.
    and #7 u2 (y_seven, a, b);  // 7ns delay.
endmodule

module tb_gate_delay_example;
    reg a,b;
    wire z,d3,d7;
    gate_delay_example dut(a,b,z,d3,d7);
    initial begin
        $monitor("t=%0.3f ns a=%b b=%b direct=%b d3=%b d7=%b",
                 $realtime,a,b,z,d3,d7);
        a=0; b=1;  // Stabilize output at 0.
        #20 a=1;   // Expect direct at 20ns, d3 at 23ns, d7 at 27ns.
        #20 a=0;   // Expect direct at 40ns, d3 at 43ns, d7 at 47ns.
        #20 $finish;
    end
endmodule
