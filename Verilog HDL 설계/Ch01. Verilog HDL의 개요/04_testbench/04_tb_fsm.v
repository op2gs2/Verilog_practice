// ============================================================================
// TESTBENCH 4: FSM STATE TRANSITIONS AND REGISTERED ALERT
//
// A testbench task groups repeated stimulus and checking operations.
// Input values are presented on a falling edge of clk.
// The expected alert is compared after the following rising edge.
// This example checks valid/invalid events, bad/good sequences,
// and whether alert asserts at the correct point in the sequence.
// ============================================================================

`timescale 1ns/1ps

module tb_fsm;
    reg clk;
    reg rst_n;
    reg event_valid;
    reg event_bad;
    wire alert;
    integer errors;

    two_bad_event_detector u_dut (
        .clk(clk), .rst_n(rst_n),
        .event_valid(event_valid), .event_bad(event_bad), .alert(alert)
    );

    always #5 clk = ~clk;

    // A Verilog task avoids repeating an entire drive-and-check sequence.
    task drive_event;
        input valid_value;
        input bad_value;
        input expected_alert;
        begin
            // Present input data before the next active clock edge.
            @(negedge clk);
            event_valid = valid_value;
            event_bad   = bad_value;
            @(posedge clk);
            // Check after the DUT state registers have updated.
            #1;
            if (alert !== expected_alert) begin
                errors = errors + 1;
                $display("ERROR: valid=%b bad=%b alert=%b expected=%b",
                         valid_value, bad_value, alert, expected_alert);
            end
        end
    endtask

    initial begin
        clk = 0; rst_n = 0;
        event_valid = 0; event_bad = 0; errors = 0;
        #1;
        if (alert !== 1'b0) begin
            errors = errors + 1;
            $display("ERROR: reset did not clear alert");
        end
        @(negedge clk); rst_n = 1;

        // One bad event is not yet enough to assert alert.
        drive_event(1'b1, 1'b1, 1'b0);
        drive_event(1'b0, 1'b0, 1'b0);
        // A subsequent bad event should assert alert.
        drive_event(1'b1, 1'b1, 1'b1);
        drive_event(1'b1, 1'b1, 1'b1);
        drive_event(1'b1, 1'b0, 1'b0);
        drive_event(1'b1, 1'b1, 1'b0);
        drive_event(1'b1, 1'b0, 1'b0);
        drive_event(1'b1, 1'b1, 1'b0);
        drive_event(1'b1, 1'b1, 1'b1);

        if (errors == 0)
            $display("TEST PASS: two_bad_event_detector_fsm");
        else
            $display("TEST FAIL: two_bad_event_detector_fsm errors=%0d", errors);
        $finish;
    end
endmodule
