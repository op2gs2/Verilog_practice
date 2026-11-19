// ============================================================================
// LEXICAL RULES 4: SYSTEM TASKS AND SYSTEM FUNCTIONS
//
// Names beginning with $ are reserved for system-provided facilities.
// A task performs an action; a function returns a value in an expression.
//
// Tasks:
//   $display  : print with a newline
//   $write    : print without an automatic newline
//   $monitor  : print whenever a monitored signal changes
//   $strobe   : print values at the end of the current simulation time slot
//   $finish   : end simulation
//   $dumpfile / $dumpvars : produce waveform data (tool dependent)
// Functions:
//   $time     : return current simulation time
//   $signed   : interpret a bit pattern as signed
//   $unsigned : interpret a bit pattern as unsigned
//
// These examples document simulation facilities, not synthesizable behavior.
// ============================================================================

`timescale 1ns/1ps

module system_tasks_functions;
    reg clock;
    reg [7:0] raw_byte;

    initial begin
        clock = 1'b0;
        raw_byte = 8'hFF;
        // Choose nanoseconds as a display format for simulation time.
        $timeformat(-9, 0, " ns", 10);
        // Waveform generation is a simulator-specific facility.
        $dumpfile("system_tasks_functions.vcd");
        // Select the signals to record in the waveform trace.
        $dumpvars(0, system_tasks_functions);

        // $time is a function evaluated within a task argument.
        $display("[task] simulation begins: %0t", $time);
        $write("[write] no newline, ");
        $display("[display] newline");

        $display("[function] signed=%0d unsigned=%0d",
                 $signed(raw_byte), $unsigned(raw_byte));

        // Prints again when a monitored argument changes.
        $monitor("[monitor] at %0t clock=%b", $time, clock);
        #5 clock = 1'b1;
        $strobe("[strobe] at %0t clock=%b", $time, clock);
        #5 clock = 1'b0;
        #1 $finish;
    end
endmodule
