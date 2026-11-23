`timescale 1ns/1ps

// ============================================================================
// 06 - TRI-STATE GATE PRIMITIVES
// ============================================================================
//   bufif1(out, data, enable): data when enable=1, otherwise Z.
//   bufif0(out, data, enable): data when enable=0, otherwise Z.
//   notif1(out, data, enable): ~data when enable=1, otherwise Z.
//   notif0(out, data, enable): ~data when enable=0, otherwise Z.
//
// Z = a high-impedance DRIVER, not the logic value zero.
// Unknown enable/data values require four-state resolution rules.
// This demo uses only 0/1 for data and enable to make the truth table clear.
//
// IMPORTANT: Typical FPGA internal logic does not have freely usable
// tri-state routing. I/O tri-states or target-specific primitives may be
// supported; internal tri-states are usually handled with multiplexers.
// ============================================================================

module tristate_gates (
    input wire data, en,
    output wire y_bufif0, y_bufif1, y_notif0, y_notif1
);
    bufif0 u0 (y_bufif0, data, en);
    bufif1 u1 (y_bufif1, data, en);
    notif0 u2 (y_notif0, data, en);
    notif1 u3 (y_notif1, data, en);
endmodule

module tb_tristate_gates;
    reg data, en;
    wire y0,y1,n0,n1;
    tristate_gates dut(data,en,y0,y1,n0,n1);
    initial begin
        $display("data en  bufif0 bufif1 notif0 notif1");
        $monitor("  %b    %b     %b      %b      %b      %b",
                 data,en,y0,y1,n0,n1);
        data=0; en=0;
        #10 data=1;
        #10 en=1;
        #10 data=0;
        #10 $finish;
    end
endmodule
