`timescale 1ns/1ps

// ============================================================================
// 14 - TIMESCALE: TIME UNIT AND TIME PRECISION
// ============================================================================
// The leading character on `timescale is a BACKTICK (`), not apostrophe (').
//   `timescale 1ns/1ps
//               ^^^  ^^^
//               unit precision
//
// Time unit = 1 nanosecond:
//   #1     = 1ns
//   #0.5   = 0.5ns = 500ps
//   #0.001 = 0.001ns = 1ps
//
// Time precision = 1 picosecond: values are rounded to a 1ps grid.
// 'timescale' does not produce a delay on its own. It establishes how #
// delay numbers are interpreted for the following source scope.
//
// $time reports integer time units, while $realtime is more convenient for
// observing fractional time values at this timescale.
// ============================================================================

module tb_timescale_precision;
    reg a;
    initial begin
        a=0;
        $display("Initial: t=%0.3f ns, a=%b",$realtime,a);
        #1 a=1;
        $display("After #1: t=%0.3f ns, a=%b",$realtime,a);
        #0.5 a=0;
        $display("After #0.5: t=%0.3f ns, a=%b",$realtime,a);
        #0.001 a=1;
        $display("After #0.001: t=%0.3f ns, a=%b",$realtime,a);
        #1 $finish;
    end
endmodule
