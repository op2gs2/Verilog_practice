// ============================================================================
// MODULE BASICS 3: PARAMETERIZED CLOCKED COUNTER
//
// WIDTH is an elaboration-time parameter, not a runtime input.
// The width of count changes with WIDTH (assumed to be >= 1).
// Example instance override: parameterized_counter #(.WIDTH(3)) u0 (...);
//
// posedge clk   : update stored state only on a rising clock edge.
// negedge rst_n : asynchronous active-low reset.
// <=            : nonblocking assignment; preferred in clocked RTL.
// With enable=0, the flip-flop holds the previous count value.
// A WIDTH-bit counter wraps around after 2**WIDTH counts.
// ============================================================================

`timescale 1ns/1ps

module parameterized_counter #(
    parameter WIDTH = 4
) (
    input  wire clk,
    input  wire rst_n,
    input  wire enable,
    output reg [WIDTH-1:0] count
);

    // One block describes state updates and asynchronous reset.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Replication creates a WIDTH-bit zero vector.
            count <= {WIDTH{1'b0}};
        end
        else if (enable) begin
            // Unsigned addition wraps when count exceeds its bit width.
            count <= count + 1'b1;
        end

    end
endmodule
