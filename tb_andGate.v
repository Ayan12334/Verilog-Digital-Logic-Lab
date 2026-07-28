`timescale 1ns / 1ps

module tb_andGate;

    // 1. Declare Testbench Signals
    reg  tb_a;
    reg  tb_b;
    reg  tb_enable;
    wire tb_y;

    // 2. Instantiate the Unit Under Test (UUT)
    andGate uut (
        .a(tb_a),
        .b(tb_b),
        .enable(tb_enable),
        .y(tb_y)
    );

    // 3. Drive the Inputs Inside an Initial Block
    initial begin
        // Generate waveform dump file for GTKWave / EPWave
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_andGate);

        // Test Case 1: Disabled (enable = 0)
        tb_a = 1; tb_b = 1; tb_enable = 0;
        #10; // Wait 10 nanoseconds

        //Test Case 2: Enabled, but b = 0 
        tb_a = 1; tb_b = 0; tb_enable = 1;
        #10;

        // Test Case 3: Enabled, both inputs = 1 
        tb_a = 1; tb_b = 1; tb_enable = 1;
        #10;

        $finish; // End simulation
    end

endmodule