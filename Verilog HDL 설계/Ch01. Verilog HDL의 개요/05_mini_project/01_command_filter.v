// ============================================================================
// MINI PROJECT: SIMPLE 8-BIT COMMAND FILTER
//
// SPECIFICATION:
// - At each rising clock edge, sample valid_in and opcode_in.
// - If valid_in=1 and opcode_in equals BLOCKED_OPCODE, assert alert_out.
// - Otherwise, a valid command asserts pass_out.
// - If valid_in=0, all three output flags are cleared.
// - An active-low asynchronous reset clears all outputs.
// - Results appear after the clocked nonblocking assignments update.
//
// Concepts illustrated: parameter, named ports, compare logic,
// clocked always block, and nonblocking register assignments.
// This is only an introductory logic example: it does not parse CCSDS
// frames, implement a real protocol, or constitute a deployable IDPS.
// ============================================================================

`timescale 1ns/1ps

module command_filter #(
    // The forbidden command can be overridden per instance.
    parameter [7:0] BLOCKED_OPCODE = 8'hA5
) (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       valid_in,
    input  wire [7:0] opcode_in,
    output reg        valid_out,
    output reg        pass_out,
    output reg        alert_out
);
    // Register decisions at the clock edge and clear on reset.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_out <= 1'b0;
            pass_out  <= 1'b0;
            alert_out <= 1'b0;
        end
        else begin
            // Mark the sampled command as valid (or idle).
            valid_out <= valid_in;
            if (valid_in) begin
                // Assert pass only for a nonblocked valid opcode.
                pass_out  <= (opcode_in != BLOCKED_OPCODE);
                // Assert alert only for the blocked opcode.
                alert_out <= (opcode_in == BLOCKED_OPCODE);
            end
            else begin
                pass_out  <= 1'b0;
                alert_out <= 1'b0;
            end
        end
    end
endmodule
