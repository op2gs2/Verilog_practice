// ============================================================================
// MODELING STYLE 5: FINITE-STATE MACHINE (FSM)
//
// Purpose: flag the second (and later) consecutive BAD valid event.
// event_valid=0 does not count as an event and preserves the prior state.
// A valid good event resets the state to S_IDLE.
//
// S_IDLE     : the last valid event was not bad.
// S_SEEN_BAD : the last valid event was bad.
//
// The combinational block determines next_state from present state/inputs.
// The clocked block updates state and produces a registered alert.
// This is a teaching example, not a real security monitoring engine.
// ============================================================================

`timescale 1ns/1ps

module two_bad_event_detector (
    input  wire clk,
    input  wire rst_n,
    input  wire event_valid,
    input  wire event_bad,
    output reg  alert
);
    // Local constants encode the two FSM states.
    localparam S_IDLE     = 1'b0;
    localparam S_SEEN_BAD = 1'b1;

    // Registered current state.
    reg state;
    // Combinationally computed future state.
    reg next_state;

    // Next-state combinational logic.
    always @(*) begin
        // Default assignment prevents latches and retains state when invalid.
        next_state = state;
        if (event_valid) begin
            if (event_bad)
                next_state = S_SEEN_BAD;
            else
                next_state = S_IDLE;
        end
    end

    // Register the state and the alert output.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            alert <= 1'b0;
        end
        else begin
            // The next state becomes the state on this edge.
            state <= next_state;

            // Uses the OLD state due to nonblocking register semantics.
            alert <= event_valid && event_bad && (state == S_SEEN_BAD);
        end
    end
endmodule
