module andGate (
    input wire a,
    input wire b,
    input wire enable,

    output wire y
);
    assign y = enable ? a&b : 0;

endmodule