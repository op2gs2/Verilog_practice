// ============================================================================
// TESTBENCH 1: COMPARE THREE COMBINATIONAL DESCRIPTIONS
//
// DUT stands for Device Under Test.
// All three MUX implementations should agree for all eight binary inputs.
// The testbench drives a, b, c and checks each DUT output.
//
// initial : executes an event-driven stimulus process, starting at time zero.
// #1      : one simulated time-unit delay, not a hardware register delay.
// !==     : case inequality; compares x and z states explicitly.
// $finish : ends the illustrative simulation.
// A testbench is educational verification code and is not synthesized.
// ============================================================================

`timescale 1ns/1ps

module tb_combinational_equivalence;
    // Stimulus values are assigned by the testbench process.
    reg a, b, c;
    // A DUT output drives this net.
    wire y_gate;
    wire y_dataflow;
    wire y_behavioral;
    reg expected;
    integer i;
    integer errors;

    gate_level_model       u_gate (.a(a), .b(b), .c(c), .y(y_gate));
    dataflow_model         u_data (.a(a), .b(b), .c(c), .y(y_dataflow));
    behavioral_comb_model  u_beh  (.a(a), .b(b), .c(c), .y(y_behavioral));

    // Apply every binary input combination and compare outputs.
    initial begin
        errors = 0;
        a = 0; b = 0; c = 0;
        $display("a b c | gate flow behavior expected");

        for (i = 0; i < 8; i = i + 1) begin
            // Concatenation distributes bits of i into a, b, and c.
            {a, b, c} = i;
            // Allow delta-cycle updates to settle before checking.
            #1;

            // Independent reference description of 2:1 MUX behavior.
            expected = a ? b : c;
            $display("%b %b %b |   %b     %b       %b       %b",
                     a,b,c,y_gate,y_dataflow,y_behavioral,expected);

            if ((y_gate !== expected) ||
                (y_dataflow !== expected) ||
                (y_behavioral !== expected)) begin
                errors = errors + 1;
                $display("ERROR: mismatch at i=%0d", i);
            end
        end

        if (errors == 0)
            $display("TEST PASS: combinational_equivalence");
        else
            $display("TEST FAIL: combinational_equivalence errors=%0d", errors);
        $finish;
    end
endmodule
