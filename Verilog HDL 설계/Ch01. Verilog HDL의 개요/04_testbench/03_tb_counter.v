// ============================================================================
// TESTBENCH 3: CLOCK, RESET, ENABLE, AND COUNTER ROLLOVER
//
// The clock period is 10 ns when `timescale is 1ns/1ps.
// A three-bit counter cycles through 0,1,2,3,4,5,6,7,0.
// Stimulus is applied at falling edges to avoid DUT/TB races.
// Checks occur after a rising edge and a short simulation delay,
// allowing nonblocking register updates to become visible.
// Reset is asynchronous: it does not require another rising clock edge.
// ============================================================================

`timescale 1ns/1ps

module tb_counter;
    reg clk;
    reg rst_n;
    reg enable;
    wire [2:0] count;
    integer i;
    integer errors;

    parameterized_counter #(.WIDTH(3)) u_counter (
        .clk(clk), .rst_n(rst_n), .enable(enable), .count(count)
    );

    // Toggle every 5 ns, creating a 10 ns clock period.
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        // An asynchronous reset can assert between clock edges.
        rst_n = 0;
        enable = 0;
        errors = 0;
        #1;
        if (count !== 3'd0) begin
            errors = errors + 1;
            $display("ERROR: reset count=%0d", count);
        end

        // Change control inputs away from the active sampling edge.
        @(negedge clk);
        rst_n = 1;
        enable = 1;

        for (i = 1; i <= 8; i = i + 1) begin
            // Observe one counter update for this clock cycle.
            @(posedge clk);
            // Wait until nonblocking assignments have taken effect.
            #1;
            if (count !== (i % 8)) begin
                errors = errors + 1;
                $display("ERROR: tick=%0d count=%0d expected=%0d",
                         i, count, i % 8);
            end
        end

        @(negedge clk);
        enable = 0;
        repeat (2) begin
            @(posedge clk);
            #1;
            if (count !== 3'd0) begin
                errors = errors + 1;
                $display("ERROR: disabled counter changed to %0d", count);
            end
        end

        @(negedge clk);
        enable = 1;
        @(posedge clk); #1;
        rst_n = 0;
        #1;
        if (count !== 3'd0) begin
            errors = errors + 1;
            $display("ERROR: async reset did not clear count");
        end

        if (errors == 0)
            $display("TEST PASS: parameterized_counter");
        else
            $display("TEST FAIL: parameterized_counter errors=%0d", errors);
        $finish;
    end
endmodule
