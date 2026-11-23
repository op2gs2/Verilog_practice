`timescale 1ns/1ps

// ============================================================================
// 11 - NET DELAY (EXPLICIT NET DECLARATION)
// ============================================================================
// In 'wire #2 delayed_net;', the #2 applies to the NET declaration.
// It models the delay between the driver's resolved value and the net value
// seen by loads. This is different from a gate's own primitive delay.
//
// A net may be driven by a gate primitive, a continuous assignment, or
// multiple sources. The net's delay is NOT an accurate physical wire RC
// extraction and is usually not used in synthesizable FPGA/ASIC RTL.
// ============================================================================

module net_delay_example (
    input  wire a,b,
    output wire y_direct,y_net,y_both
);
    wire #2 delayed_net;      // 2ns net delay.
    wire #2 gate_and_net;     // 2ns net delay after 3ns gate delay.

    and u_direct (y_direct,a,b);
    and u_net (delayed_net,a,b);
    and #3 u_both (gate_and_net,a,b);

    assign y_net = delayed_net;
    assign y_both = gate_and_net;
endmodule

module tb_net_delay_example;
    reg a,b;
    wire yd,yn,yb;
    net_delay_example dut(a,b,yd,yn,yb);
    initial begin
        $monitor("t=%0.3f ns input=%b direct=%b net2=%b gate3_net2=%b",
                 $realtime,a,yd,yn,yb);
        a=0; b=1;
        #20 a=1;  // Stable isolated change: net at 22ns; both at 25ns.
        #20 a=0;  // Stable isolated change: net at 42ns; both at 45ns.
        #20 $finish;
    end
endmodule
