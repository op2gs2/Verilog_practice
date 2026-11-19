// ============================================================================
// MODELING STYLE 3: BEHAVIORAL COMBINATIONAL LOGIC
//
// always @(*) automatically tracks signals read by the procedure.
// A blocking assignment (=) is the conventional choice for such logic.
// output reg is required here because y is assigned in an always block.
// The reg declaration DOES NOT necessarily imply a flip-flop.
// Assign y on every path through the block to avoid inferring a latch.
// The intended function is exactly y = a ? b : c for binary inputs.
// ============================================================================

`timescale 1ns/1ps

module behavioral_comb_model (
    input  wire a,
    input  wire b,
    input  wire c,
    output reg  y
);
    // Automatic sensitivity list for combinational behavior.
    always @(*) begin
        // Choose b when select is exactly binary 1.
        if (a == 1'b1)
            // Blocking assignment updates the procedural variable.
            y = b;
        // The explicit else prevents an unintended latch.
        else
            y = c;
    end
endmodule
