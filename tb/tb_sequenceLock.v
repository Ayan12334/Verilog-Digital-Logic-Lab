`timescale 1ns/1ps

module tb_sequenceLock;

    reg tb_clk;
    reg tb_rst;
    reg tb_data;
    wire tb_unlock;

    sequenceLock uut (
        .clk(tb_clk),
        .rst(tb_rst),
        .data(tb_data),
        .unlock(tb_unlock)
    );

    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("build/sequence_waveform.vcd");
        $dumpvars(0, tb_sequenceLock);

        // System On
        tb_clk = 0;
        tb_data = 0;
        tb_rst = 1;

        // Wait 15ns and release the reset button
        #15 tb_rst = 0;

        // We type: 1 - 0 - 1 - 0 - 1 - 1
        // The GTKWave at the 4th bit will fail, but will recycle the '1-0' 
        // to finish the sequence on the 6th bit
        
        #10 tb_data = 1'b1; 
        #10 tb_data = 1'b0; 
        #10 tb_data = 1'b1; 
        #10 tb_data = 1'b0; 
        #10 tb_data = 1'b1; 
        #10 tb_data = 1'b1; 

        // Wait 20ns to see the unlock wire spike, then finish
        #20 $finish;
    end

endmodule