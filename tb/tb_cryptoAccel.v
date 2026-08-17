`timescale 1ns/1ps

module tb_master;

    reg tb_clk;
    reg tb_rst;
    reg tb_process;
    reg [7:0] tb_data_in;

    wire [7:0] tb_data_out;
    wire tb_valid_out;

    crypto_accel uut (
        .clk(tb_clk),
        .rst(tb_rst),
        .process(tb_process),
        .data_in(tb_data_in),
        .data_out(tb_data_out),
        .valid_out(tb_valid_out)
    );

    // Generate a 10ns clock
    always #5 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("build/master_waveform.vcd");
        $dumpvars(0, tb_master);

        // Initialise inputs
        tb_clk = 0;
        tb_rst = 1;
        tb_process = 0;
        tb_data_in = 8'h00;

        // Release reset to plant the LFSR seed
        #15 tb_rst = 0;
        #10;

        // Encrypt the letter H
        tb_data_in = "H";
        tb_process = 1;
        #10 tb_process = 0;
        #20; // Wait for FSM to cycle through ENCRYPT and DONE

        // Encrypt the letter E
        tb_data_in = "E";
        tb_process = 1;
        #10 tb_process = 0;
        #20;

        // Encrypt the first letter L
        tb_data_in = "L";
        tb_process = 1;
        #10 tb_process = 0;
        #20;

        // Encrypt the second letter L
        tb_data_in = "L";
        tb_process = 1;
        #10 tb_process = 0;
        #20;

        // Encrypt the letter O
        tb_data_in = "O";
        tb_process = 1;
        #10 tb_process = 0;
        #40;

        $finish;
    end
endmodule