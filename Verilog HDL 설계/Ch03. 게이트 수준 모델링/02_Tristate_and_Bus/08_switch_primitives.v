`timescale 1ns/1ps

// ============================================================================
// 08 - SWITCH-LEVEL PRIMITIVES
// ============================================================================
// Switch primitives model logic-level connectivity, not detailed analog
// transistor voltages or currents. They are mainly educational / simulation
// constructs and are generally not appropriate for ordinary synthesizable
// ASIC/FPGA RTL.
//
//   nmos(out, data, control): drives data if control=1, otherwise Z.
//   pmos(out, data, control): drives data if control=0, otherwise Z.
//   tranif1(net_a, net_b, control): bidirectional connection if control=1.
//
// 'tranif1' connects nets in BOTH directions; unlike bufif1, it is not a
// directional data output. Do not confuse the digital switch abstraction
// with a real CMOS transmission-gate implementation.
// ============================================================================

module switch_primitives (
    input  wire source_data,
    input  wire enable,
    output wire nmos_out,
    output wire pmos_out,
    output wire tran_out
);
    // Directional MOS switch primitives:
    nmos u_nmos (nmos_out, source_data, enable);
    pmos u_pmos (pmos_out, source_data, enable);

    // Bidirectional switch, driven here from only one side for clarity:
    wire left_net;
    wire right_net;
    assign left_net = source_data;
    tranif1 u_tran (left_net, right_net, enable);
    assign tran_out = right_net;
endmodule

module tb_switch_primitives;
    reg data,en;
    wire n,p,t;
    switch_primitives dut(data,en,n,p,t);
    initial begin
        data=0; en=0;
        #1 $display("data=%b en=%b nmos=%b pmos=%b tran=%b",data,en,n,p,t);
        #9 en=1;
        #1 $display("data=%b en=%b nmos=%b pmos=%b tran=%b",data,en,n,p,t);
        #9 data=1;
        #1 $display("data=%b en=%b nmos=%b pmos=%b tran=%b",data,en,n,p,t);
        #9 en=0;
        #1 $display("data=%b en=%b nmos=%b pmos=%b tran=%b",data,en,n,p,t);
        #1 $finish;
    end
endmodule
