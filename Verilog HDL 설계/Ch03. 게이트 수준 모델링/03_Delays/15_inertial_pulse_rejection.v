`timescale 1ns/1ps

// ============================================================================
// 15 - SHORT PULSE REJECTION (INERTIAL DELAY MODELING)
// ============================================================================
// A primitive delay normally behaves like an inertial delay in the Verilog
// event model. If an input pulse is shorter than the pending delay, a future
// output transition may be cancelled before it takes effect.
//
// Here a 5ns BUF delay is compared with:
//   pulse #1: t=10..12ns, width 2ns -> output is not observed high.
//   pulse #2: t=30..38ns, width 8ns -> output high t=35..43ns.
//
// IMPORTANT:
//  * This is not an accurate silicon glitch/noise filter.
//  * Real cells may produce partial analog pulses and have min-pulse specs.
//  * '#5' is a simulation delay, not a physical delay constraint.
//  * Do not equate all '#' constructs with inertial delay. Procedural
//    nonblocking assignments can model scheduled events differently.
// ============================================================================

module inertial_pulse_rejection (
    input wire a,
    output wire y_direct, y_gate, y_assign
);
    assign y_direct = a;
    buf #5 u_buf (y_gate,a);
    assign #5 y_assign = a;
endmodule

module tb_inertial_pulse_rejection;
    reg a;
    wire y0,y1,y2;
    inertial_pulse_rejection dut(a,y0,y1,y2);
    initial begin
        $monitor("t=%0.3f ns  a=%b direct=%b gate5=%b assign5=%b",
                 $realtime,a,y0,y1,y2);
        a=0;
        #10 a=1; // 10ns
        #2  a=0; // 12ns. The 2ns pulse is filtered in gate5/assign5.
        #18 a=1; // 30ns
        #8  a=0; // 38ns. The 8ns pulse reaches outputs after 5ns.
        #12 $finish;
    end
endmodule
