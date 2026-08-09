`timescale 1ns/1ps

module tb_counter8;
    reg tb_clk;
    reg tb_rst;
    wire [7:0] tb_count;

    counter8 uut(
        .clk(tb_clk),
        .rst(tb_rst),
        .count(tb_count)
    );

    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("build/counter8_waveform.vcd");
        $dumpvars(0, tb_counter8);

        // reset count
        tb_clk = 0;
        tb_rst = 1;

        #15 tb_rst = 0; 
        #200;
        $finish;
    end

endmodule
