`timescale 1ns/1ps

// ============================================================================
// 07 - A NET WITH TWO TRI-STATE DRIVERS
// ============================================================================
// Multiple gate outputs may drive one net. Verilog RESOLVES the values:
//   A=Z, B=Z  -> shared bus Z (no other driver)
//   A=1, B=Z  -> bus 1
//   A=Z, B=0  -> bus 0
//   A=1, B=0  -> bus X for equal-strength drivers (contention)
//   A=0, B=0  -> bus 0, even though both are actively driving it
//
// A driver becoming Z does not guarantee the BUS becomes Z: other drivers
// or a pull-up / pull-down can determine the resolved bus value.
//
// This is a simulation-oriented shared-bus demonstration, not recommended
// synthesizable FPGA fabric RTL.
// ============================================================================

module shared_bus_resolution (
    input wire data_a, data_b,
    input wire enable_a, enable_b,
    output wire bus_value
);
    bufif1 u_driver_a (bus_value, data_a, enable_a);
    bufif1 u_driver_b (bus_value, data_b, enable_b);
endmodule

module tb_shared_bus_resolution;
    reg da,db,ea,eb;
    wire bus;
    shared_bus_resolution dut(da,db,ea,eb,bus);
    initial begin
        $display("enA dataA enB dataB => bus");
        $monitor(" %b     %b     %b     %b    => %b",ea,da,eb,db,bus);
        da=0; db=1; ea=0; eb=0; // Both off: Z
        #10 ea=1;               // Only A: 0
        #10 ea=0; eb=1;          // Only B: 1
        #10 ea=1;               // Opposing strong values: X
        #10 db=0;               // Equal driven values: 0
        #10 $finish;
    end
endmodule
