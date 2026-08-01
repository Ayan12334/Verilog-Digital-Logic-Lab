`timescale 1ns/1ps

module tb_xor;
    reg [7:0] tb_in;
    reg [7:0] tb_key;
    wire [7:0] tb_c;
    wire [7:0] tb_d;

    //Inputs plaintext (tb_in) & key -> outputs ciphertext (tb_c)
    xor_8bit encryptor (
        .data_in(tb_in),
        .key(tb_key),
        .data_out(tb_c)
    );

    //Inputs ciphertext (tb_c) & key -> outputs decrypted (tb_d)
    xor_8bit decryptor(
        .data_in(tb_c),  // Feed the encrypted output into data_in
        .key(tb_key),
        .data_out(tb_d)
    );

    initial begin
        $dumpfile("xor_sim.vcd");
        $dumpvars(0, tb_xor);
        
        //numbers are written as <bits>'<base><value>
        //test 1
        tb_in = 8'hA5; tb_key = 8'h5F; #10;
        
        //test 2
        tb_in = 8'hFF; tb_key = 8'h12; #10;

        $finish;
    end
endmodule 

//note: when you do in ^ key = ciphertext, 
//if we now do cypher ^ key this will give us the decyrpted version and this should match with in 