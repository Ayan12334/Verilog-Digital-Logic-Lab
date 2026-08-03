`timescale 1ns/1ps

module tb_register8;

    reg tb_clk;
    reg tb_rst;
    reg [7:0] tb_d;
    wire [7:0] tb_q;

    register8 uut (
        .clk(tb_clk),
        .rst(tb_rst),
        .d(tb_d),
        .q(tb_q)
    );

    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("build/dff8_waveform.vcd");
        $dumpvars(0, tb_register8);

        tb_clk = 0;
        tb_rst = 1;
        tb_d = 8'b00000000;

        // Release reset
        #15 tb_rst = 0;

        #10 tb_d = 8'b10101010;

        // 11111111 in binary
        #10 tb_d = 8'hFF;

        // 11000011 in binary
        #10 tb_d = 8'hC3;

        #12 tb_d = 8'hAA; 
        #8  tb_d = 8'h00;

        #20 $finish;
    end

endmodule