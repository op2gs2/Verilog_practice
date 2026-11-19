// ============================================================================
// TESTBENCH 2: HALF-ADDER AND FULL-ADDER TRUTH TABLES
//
// The half adder has four possible binary input pairs.
// The full adder has eight possible binary input triples.
// A loop enumerates all eight triples; half-adder outputs ignore cin.
// Expected outputs are computed separately from the DUT instances.
// This illustrates exhaustive testing when the input space is small.
// ============================================================================

`timescale 1ns/1ps

module tb_adders;
    reg a, b, cin;
    wire ha_sum, ha_carry;
    wire fa_sum, fa_cout;
    reg expected_ha_sum, expected_ha_carry;
    reg expected_fa_sum, expected_fa_cout;
    integer i;
    integer errors;

    half_adder u_half (.a(a), .b(b), .sum(ha_sum), .carry(ha_carry));
    full_adder_structural u_full (
        .a(a), .b(b), .cin(cin), .sum(fa_sum), .cout(fa_cout)
    );

    // Enumerate every possible 3-bit binary input tuple.
    initial begin
        errors = 0;
        for (i = 0; i < 8; i = i + 1) begin
            // The integer loop index is truncated to three bits.
            {a, b, cin} = i;
            #1;

            // Half adder does not use the carry-in bit.
            expected_ha_sum   = a ^ b;
            expected_ha_carry = a & b;

            expected_fa_sum  = a ^ b ^ cin;
            // Carry is 1 if at least two inputs are 1.
            expected_fa_cout = (a & b) | (a & cin) | (b & cin);

            if ((ha_sum !== expected_ha_sum) ||
                (ha_carry !== expected_ha_carry) ||
                (fa_sum !== expected_fa_sum) ||
                (fa_cout !== expected_fa_cout)) begin
                errors = errors + 1;
                $display("ERROR: a=%b b=%b cin=%b", a, b, cin);
            end
        end

        if (errors == 0)
            $display("TEST PASS: half_adder_and_full_adder");
        else
            $display("TEST FAIL: half_adder_and_full_adder errors=%0d", errors);
        $finish;
    end
endmodule
