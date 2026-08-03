module dff (
    input wire clock,
    input wire reset,
    input wire d, //input wire
    output reg q // output wire
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule