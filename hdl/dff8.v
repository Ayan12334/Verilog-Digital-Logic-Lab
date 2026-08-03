module register8 (
    input wire clk,
    input wire rst,
    input wire [7:0] d,  // 8-bit wide input bus
    output reg [7:0] q   // 8-bit wide output register
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // 8'b means an 8-bit binary number
            q <= 8'b00000000; 
        end else begin
            q <= d; 
        end
    end

endmodule