// ============================================================================
// MINI PROJECT TESTBENCH: ACCEPT, BLOCK, IDLE, AND RESET
//
// The testbench applies valid/blocked/normal opcodes and compares outputs.
// A helper task packages one clock-aligned transaction and its expectation.
// The checks include consecutive blocked commands and asynchronous reset.
// This module illustrates testbench organization, not a hardware IP.
// ============================================================================

`timescale 1ns/1ps

module tb_command_filter;
    reg clk, rst_n, valid_in;
    reg [7:0] opcode_in;
    wire valid_out, pass_out, alert_out;
    integer errors;

    command_filter #(.BLOCKED_OPCODE(8'hA5)) u_dut (
        .clk(clk), .rst_n(rst_n),
        .valid_in(valid_in), .opcode_in(opcode_in),
        .valid_out(valid_out), .pass_out(pass_out), .alert_out(alert_out)
    );

    always #5 clk = ~clk;

    // Encapsulate one transaction and expected flag values.
    task check_command;
        input test_valid;
        input [7:0] test_opcode;
        input expected_valid;
        input expected_pass;
        input expected_alert;
        begin
            // Drive new inputs before the next rising edge.
            @(negedge clk);
            valid_in = test_valid;
            opcode_in = test_opcode;
            @(posedge clk);
            // Allow all registered outputs to update before comparison.
            #1;
            if ({valid_out, pass_out, alert_out} !==
                {expected_valid, expected_pass, expected_alert}) begin
                errors = errors + 1;
                $display("ERROR: opcode=%h valid=%b -> got=%b%b%b expected=%b%b%b",
                         test_opcode, test_valid,
                         valid_out, pass_out, alert_out,
                         expected_valid, expected_pass, expected_alert);
            end
        end
    endtask

    initial begin
        clk = 0; rst_n = 0; valid_in = 0; opcode_in = 0; errors = 0;
        #1;
        if ({valid_out, pass_out, alert_out} !== 3'b000) begin
            errors = errors + 1;
            $display("ERROR: reset outputs are not 000");
        end
        @(negedge clk); rst_n = 1;

        // Normal command should pass.
        check_command(1'b1, 8'h10, 1, 1, 0);
        // Blocked command should raise an alert.
        check_command(1'b1, 8'hA5, 1, 0, 1);
        check_command(1'b1, 8'hA5, 1, 0, 1);
        // Idle cycles must not report a command.
        check_command(1'b0, 8'hA5, 0, 0, 0);
        check_command(1'b1, 8'hFF, 1, 1, 0);

        @(negedge clk); rst_n = 0;
        #1;
        if ({valid_out, pass_out, alert_out} !== 3'b000) begin
            errors = errors + 1;
            $display("ERROR: asynchronous reset outputs are not 000");
        end

        if (errors == 0)
            $display("TEST PASS: command_filter");
        else
            $display("TEST FAIL: command_filter errors=%0d", errors);
        $finish;
    end
endmodule
