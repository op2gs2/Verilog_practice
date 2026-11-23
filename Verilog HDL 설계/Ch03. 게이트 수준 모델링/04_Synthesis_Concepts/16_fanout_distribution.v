`timescale 1ns/1ps

// ============================================================================
// 16 - FANOUT AND SIGNAL DISTRIBUTION
// ============================================================================
// Fanout is the number of logic inputs driven by one source net. It is a
// PROPERTY of a circuit, not itself an optimization algorithm.
//
// 'assign' declares a continuous relationship: it does not copy once and
// stop, and it is not an 'always' procedural assignment.
//
// A designer can write a BUF with multiple outputs, but a synthesis / place
// and route tool may remove the BUF, insert different physical buffers,
// resize a driving cell, or duplicate logic depending on load and timing.
//
// A physical buffer cell's RC load and slew characteristics are different
// from Verilog's abstract logical 'buf' primitive.
// ============================================================================

module fanout_distribution (
    input wire a,b,
    output wire alert_signal,
    output wire drop_request,
    output wire log_enable,
    output wire buffer_alert,
    output wire buffer_drop,
    output wire buffer_log
);
    wire attack_detected;
    assign attack_detected = a & b;

    // Dataflow fanout to three consumers.
    assign alert_signal = attack_detected;
    assign drop_request = attack_detected;
    assign log_enable   = attack_detected;

    // An alternative structural expression of similar logical behavior.
    buf u_fanout (buffer_alert, buffer_drop, buffer_log, attack_detected);
endmodule

module tb_fanout_distribution;
    reg a,b;
    wire x1,x2,x3,y1,y2,y3;
    fanout_distribution dut(a,b,x1,x2,x3,y1,y2,y3);
    initial begin
        a=0; b=1;
        #1 $display("assign=%b%b%b primitive=%b%b%b",x1,x2,x3,y1,y2,y3);
        #9 a=1;
        #1 $display("assign=%b%b%b primitive=%b%b%b",x1,x2,x3,y1,y2,y3);
        #1 $finish;
    end
endmodule
