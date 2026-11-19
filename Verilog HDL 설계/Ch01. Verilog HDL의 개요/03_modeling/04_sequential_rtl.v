// ============================================================================
// MODELING STYLE 4: SEQUENTIAL RTL (FLIP-FLOP WITH ENABLE)
//
// Unlike combinational logic, a flip-flop remembers past state.
// 1. If rst_n becomes 0, q asynchronously resets to 0.
// 2. On a rising edge of clk, if en=1, q captures d.
// 3. Otherwise q retains its previous value.
//
// A nonblocking assignment (<=) schedules a register update.
// Avoid treating it as an immediate software-style assignment.
// ============================================================================

`timescale 1ns/1ps

module dff_with_enable (
    input  wire clk,
    input  wire rst_n,
    input  wire en,
    input  wire d,
    output reg  q
);
    // Capture data on the clock edge or clear on reset assertion.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            // Reset takes precedence over enable.
            q <= 1'b0;
        // Without an else, the flip-flop holds q when en is 0.
        else if (en)
            // Update q using a nonblocking assignment.
            q <= d;

    end
endmodule
