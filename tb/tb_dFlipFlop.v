`timescale 1ns/1ps 

module tb_dff;
    reg tb_clock;
    reg tb_reset;
    reg tb_d;
    wire tb_q;

    dff uut (
        .clock(tb_clock),
        .reset(tb_reset),
        .d(tb_d),
        .q(tb_q)
    );

    always #5 tb_clock = ~tb_clock;

    initial begin
        $dumpfile("build/dff_waveform.vcd");
        $dumpvars(0, tb_dff);

        //Initialise all inputs at tine 0 so nothing is undefined
        tb_clock = 0;
        tb_reset = 1;
        tb_d = 0;

        //wait 15 ns then release reset button
        #15 tb_reset = 0; 

        // Feed data to the flip-flop at various time intervals
        #10 tb_d = 1;
        #10 tb_d = 0;

        //test to see if dff behaves right when we use awkward timings
        #12 tb_d = 1;
        #8  tb_d = 0;
        
        #14 tb_d = 1;
        #8  tb_d = 0;

        #20 $finish;
    end
endmodule