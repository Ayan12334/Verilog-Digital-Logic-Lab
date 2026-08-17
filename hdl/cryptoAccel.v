module crypto_accel (
    input wire clk,
    input wire rst,
    input wire process, //When 1, it tells the chip the incoming data needs encrypting
    input wire [7:0] data_in,
    output reg [7:0] data_out, //Encrypted data going out
    output reg valid_out //Set to 1 when encryption is done
);

    localparam S_IDLE = 2'b00;
    localparam S_ENCRYPT = 2'b01;
    localparam S_DONE = 2'b10;

    // State Registers
    reg [1:0] current_state;
    reg [1:0] next_state;

    // Internal wires to connect the LFSR output to this module
    wire [15:0] lfsr_val;
    wire lfsr_enable;

    // Instantiate the hardware random number generator
    lfsr16 key_generator (
        .clk(clk),
        .rst(rst),
        .enable(lfsr_enable),
        .lfsr_out(lfsr_val)
    );

    //Trigger the LFSR to generate a new key only during the encryption state
    assign lfsr_enable = (current_state == S_ENCRYPT);

    //sequential state memory
    always @(posedge clk or posedge rst) begin
        if (rst) current_state <= S_IDLE;
        else current_state <= next_state;
    end
    
    //combinational
    always @(*) begin
        case (current_state)
            S_IDLE: begin
                if (process) next_state = S_ENCRYPT;
                else next_state = S_IDLE;
            end
            
            S_ENCRYPT: next_state = S_DONE;
            S_DONE:    next_state = S_IDLE;
            
            default:   next_state = S_IDLE;
        endcase
    end

    //sequential
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out  <= 8'h00;
            valid_out <= 1'b0;
        end else begin
            case (current_state)
                // Turn off valid signal when resting
                S_IDLE: valid_out <= 1'b0; 

                // XOR the 8-bit data against the lower 8 bits of the LFSR
                S_ENCRYPT: data_out <= data_in ^ lfsr_val[7:0]; 
                
                // Tell the system the data is ready to read
                S_DONE: valid_out <= 1'b1; 
            endcase
        end
    end
endmodule