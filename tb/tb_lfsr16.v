`timescale 1ns/1ps

module tb_lfsr16;

    reg tb_clk;
    reg tb_rst;
    reg tb_enable;
    
    wire [15:0] tb_lfsr_out;

    lfsr16 uut (
        .clk(tb_clk),
        .rst(tb_rst),
        .enable(tb_enable),
        .lfsr_out(tb_lfsr_out)
    );

    // Generate a 10ns clock cycle
    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("build/lfsr_waveform.vcd");
        $dumpvars(0, tb_lfsr16);

        // Initialise all inputs to zero and press reset
        tb_clk = 0;
        tb_rst = 1;
        tb_enable = 0;

        // Wait 15ns and release the reset button to plant the seed
        #15 tb_rst = 0;

        // Turn on the enable wire to start the random number generation
        #10 tb_enable = 1;

        // Let the engine run for 20 clock cycles to watch the numbers bounce
        #200;

        // Turn off the engine to prove it stops shifting
        tb_enable = 0;
        #20;

        $finish;
    end

endmodule