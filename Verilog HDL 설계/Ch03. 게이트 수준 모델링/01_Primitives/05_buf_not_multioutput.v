`timescale 1ns/1ps

// ============================================================================
// 05 - BUF / NOT: MULTIPLE OUTPUTS VS. MULTIPLE INSTANCES
// ============================================================================
// Unlike AND/OR, BUF and NOT take one input but may have several outputs.
// The INPUT is the LAST port in buf (out0, out1, ..., input).
//
// Compare:
//   buf one_buf (y0, y1, a);   // One gate primitive instance; two outputs.
//   buf two_buf[1:0] (ys, as); // Two instances; bit-by-bit vector mapping.
//
// Be careful: multiple output PINS do not promise a single multi-output
// standard cell after synthesis. A tool may optimize the representation.
// ============================================================================

module buf_not_multioutput (
    input  wire a,
    input  wire [1:0] v,
    output wire y0, y1,
    output wire n0, n1,
    output wire [1:0] y_array,
    output wire [1:0] n_array
);
    buf u_buf (y0, y1, a);
    not u_not (n0, n1, a);
    buf g_buf[1:0] (y_array, v);
    not g_not[1:0] (n_array, v);
endmodule

module tb_buf_not_multioutput;
    reg a;
    reg [1:0] v;
    wire y0,y1,n0,n1;
    wire [1:0] y_array,n_array;
    buf_not_multioutput dut(a,v,y0,y1,n0,n1,y_array,n_array);
    initial begin
        a=0; v=2'b01;
        #1 $display("a=%b -> BUF=%b%b NOT=%b%b; vector=%b inv=%b",
                    a,y1,y0,n1,n0,y_array,n_array);
        #4 a=1; v=2'b10;
        #1 $display("a=%b -> BUF=%b%b NOT=%b%b; vector=%b inv=%b",
                    a,y1,y0,n1,n0,y_array,n_array);
        #1 $finish;
    end
endmodule
