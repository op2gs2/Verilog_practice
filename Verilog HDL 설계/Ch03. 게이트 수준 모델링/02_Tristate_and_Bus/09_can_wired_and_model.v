`timescale 1ns/1ps

// ============================================================================
// 09 - CONCEPTUAL CAN BUS WIRED-AND MODEL (NOT A REAL TRANSCEIVER)
// ============================================================================
// CAN defines DOMINANT = logic 0 and RECESSIVE = logic 1.
// In a simplified digital model:
//   tx_bit=0 -> driver actively drives 0 (dominant).
//   tx_bit=1 -> driver releases bus (Z); weak pull-up resolves to 1.
// Therefore the bus is 0 whenever ANY active node drives dominant.
//
// A 'tri1' net supplies a weak logic 1 when no stronger driver is active.
// Its role here is a LOGIC abstraction of recessive, NOT a physical model
// of CAN_H/CAN_L, line termination, fault tolerance, or voltage levels.
//
// During the arbitration field, a transmitting node that sends recessive 1
// but samples dominant 0 detects arbitration loss. All nodes can observe the
// bus; only simultaneously transmitting nodes participate in arbitration.
// Arbitration IDs identify messages, not unique ECU addresses.
// ============================================================================

module can_wired_and_model (
    input wire tx_a, tx_b,
    input wire arbit_a, arbit_b,
    output wire rx_bus,
    output wire lost_a, lost_b
);
    tri1 shared_bus;
    wire drive_a,drive_b;

    // Invert TX: 0 enables dominant driver; 1 releases the line.
    assign drive_a = ~tx_a;
    assign drive_b = ~tx_b;
    bufif1 driver_a (shared_bus, 1'b0, drive_a);
    bufif1 driver_b (shared_bus, 1'b0, drive_b);

    assign rx_bus = shared_bus;
    assign lost_a = arbit_a & tx_a & ~rx_bus;
    assign lost_b = arbit_b & tx_b & ~rx_bus;
endmodule

module tb_can_wired_and_model;
    reg tx_a,tx_b,arbit_a,arbit_b;
    wire rx_bus,lost_a,lost_b;
    can_wired_and_model dut(tx_a,tx_b,arbit_a,arbit_b,rx_bus,lost_a,lost_b);
    initial begin
        arbit_a=1; arbit_b=1;
        tx_a=1; tx_b=1; // Both release: recessive 1.
        #10 $display("A=%b B=%b BUS=%b lostA=%b lostB=%b",tx_a,tx_b,rx_bus,lost_a,lost_b);
        tx_a=1; tx_b=0; // A loses because A sent recessive, bus is dominant.
        #10 $display("A=%b B=%b BUS=%b lostA=%b lostB=%b",tx_a,tx_b,rx_bus,lost_a,lost_b);
        arbit_a=0;     // This toy flag says A is no longer arbitrating.
        #10 $display("A=%b B=%b BUS=%b lostA=%b lostB=%b",tx_a,tx_b,rx_bus,lost_a,lost_b);
        tx_a=0; tx_b=1;
        #10 $display("A=%b B=%b BUS=%b lostA=%b lostB=%b",tx_a,tx_b,rx_bus,lost_a,lost_b);
        #1 $finish;
    end
endmodule
