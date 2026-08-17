module lfsr16 (
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [15:0] lfsr_out
);

    // Taps are physical wires soldered to specific flip flops
    // We use XOR because it is balanced and prevents hardware getting stuck
    // This specific primitive polynomial maximises all combinations (2^16-1)
    // It ensures the sequence goes through all unique states before repeating
    wire feedback;
    assign feedback = lfsr_out[15] ^ lfsr_out[13] ^ lfsr_out[12] ^ lfsr_out[10];

    always @(posedge clk or posedge rst) begin
        // We must seed the memory with a nonzero hex value
        // An all zero state would mathematically flatline the XOR loop
        if (rst) lfsr_out <= 16'hACE1;
         
        // Shifts all bits left by one position when enabled
        // The new XOR feedback bit is pushed into the empty starting slot
        else if (enable) lfsr_out <= {lfsr_out[14:0], feedback};
    end

endmodule