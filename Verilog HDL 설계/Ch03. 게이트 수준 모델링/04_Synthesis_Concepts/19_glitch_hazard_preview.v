`timescale 1ns/1ps

// ============================================================================
// 19 - OPTIONAL NEXT LESSON: GLITCH VS. STATIC-1 HAZARD
// ============================================================================
// This is a PREVIEW of combinational timing behavior.
//
// Consider a 2:1 mux-like sum-of-products function:
//   y = (a & b) | (~a & c)
// If b=1 and c=1, ideal y is always 1 for either stable value of a.
// However, with unequal physical path delays a transition of a can briefly
// cause BOTH product terms to be 0. That temporary output pulse is a GLITCH.
// The potential for this unintended pulse is called a HAZARD.
//
// Below, the inverted path is deliberately slow, making the glitch visible
// when a transitions from 1 to 0. This is NOT a synthesizable timing fix.
// The logically equivalent expression also has a consensus term (b & c)
// which can be added in a hazard-aware circuit, but physical timing still
// needs verification.
// ============================================================================

module glitch_hazard_preview (
    input  wire a,b,c,
    output wire y_delayed,
    output wire y_ideal
);
    wire na,term_a,term_b;
    not #4 u_inv (na,a);                // Slow inverse path.
    and #1 u_and0 (term_a,a,b);        // Fast direct path.
    and #1 u_and1 (term_b,na,c);       // Slow inverse path.
    or  #1 u_or   (y_delayed,term_a,term_b);

    // Ideal zero-delay combinational value for comparison.
    assign y_ideal = (a & b) | (~a & c);
endmodule

module tb_glitch_hazard_preview;
    reg a,b,c;
    wire delayed,ideal;
    glitch_hazard_preview dut(a,b,c,delayed,ideal);
    initial begin
        $monitor("t=%0.3f ns a=%b delayed=%b ideal=%b",$realtime,a,delayed,ideal);
        a=1; b=1; c=1;
        #20 a=0;  // Ideal y stays 1. Delayed y may momentarily fall to 0.
        #20 $finish;
    end
endmodule
