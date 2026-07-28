module xor_8bit (
    input wire [7:0] data_in, //[7:0] represents a byte
    input wire [7:0] key,

    output wire [7:0] data_out
    
);
    assign data_out = data_in ^ key;

endmodule