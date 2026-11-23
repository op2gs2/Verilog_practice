`timescale 1ns/1ps

// ============================================================================
// 13 - RISE, FALL, AND TURN-OFF DELAYS
// ============================================================================
// For most logic gates, two delay values specify delays to an output
// rising to 1 and falling to 0:
//   not #(3, 5) u_inv(y, a);
//
// For tri-state gates, the third delay describes a transition to Z:
//   bufif1 #(3, 5, 7) u_tri(y, data, enable);
//
// Interpret delay direction at the OUTPUT, not the INPUT.
// Example NOT: input 0 -> 1 means output 1 -> 0 (FALL delay).
//
// For bufif1 with data=1 and enable changing 1 -> 0 at t=30ns,
// the driver is scheduled to release output (Z) at t=37ns.
// If another driver exists, the resolved bus need not become Z.
// ============================================================================

module rise_fall_turnoff (
    input wire data,en,
    output wire invert_out,
    output wire tristate_out
);
    not    #(3, 5)    u_inv (invert_out,data);
    bufif1 #(3, 5, 7) u_tri (tristate_out,data,en);
endmodule

module tb_rise_fall_turnoff;
    reg data,en;
    wire inverted,tri_out;
    rise_fall_turnoff dut(data,en,inverted,tri_out);
    initial begin
        $monitor("t=%0.3f ns data=%b enable=%b inverted=%b tri=%b",
                 $realtime,data,en,inverted,tri_out);
        data=0; en=1;  // Outputs settle.
        #20 data=1;    // Inverter falls at 25ns; tri-state rises at 23ns.
        #10 en=0;      // Tri-state turns off at 37ns.
        #15 data=0;
        #10 en=1;      // Tri-state starts driving 0 after fall delay.
        #15 $finish;
    end
endmodule
