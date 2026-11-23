`timescale 1ns/1ps

// ============================================================================
// 17 - FUNCTIONAL EQUIVALENCE DOES NOT REQUIRE STRUCTURAL IDENTITY
// ============================================================================
// Boolean distributive law:
//   (a & b) | (a & c) == a & (b | c)
//
// Two algebraic descriptions produce the same 0/1 truth table even though
// their initial logic graphs differ. Logic synthesis can factor and map the
// logic to library cells (AND, NAND, AOI/OAI, etc.).
//
// Synthesis must preserve defined functional behavior under its assumptions.
// Exact primitive count, module boundary, power, delay, or placement is NOT
// automatically preserved. Formal equivalence checking is commonly used to
// compare pre- and post-synthesis behavior.
// ============================================================================

module logic_equivalence (
    input wire a,b,c,
    output wire y_unfactored,
    output wire y_factored,
    output wire equivalent
);
    wire w1,w2;
    and u1(w1,a,b);
    and u2(w2,a,c);
    or  u3(y_unfactored,w1,w2);
    assign y_factored = a & (b | c);
    assign equivalent = (y_unfactored === y_factored);
    // '===' produces a known 0/1 for exact 4-state comparison.
    // The equivalence comparison output is a SIMULATION illustration.
endmodule

module tb_logic_equivalence;
    reg a,b,c;
    wire y0,y1,equal;
    logic_equivalence dut(a,b,c,y0,y1,equal);
    integer i;
    initial begin
        for (i=0; i<8; i=i+1) begin
            {a,b,c}=i;
            #1 $display("abc=%b%b%b y_original=%b y_factored=%b same=%b",
                        a,b,c,y0,y1,equal);
        end
        $finish;
    end
endmodule
