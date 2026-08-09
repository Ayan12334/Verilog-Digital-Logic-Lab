module sequence_lock (
    input wire clk,
    input wire rst,    
    input wire data,
    output reg unlock
);
    // need 5 states, represented by 0-4 which requires 3 bits in binary (100 being 4)
    reg [2:0] current_state; //3 bits
    reg [2:0] next_state;

    localparam S_INITIAL = 3'b000;
    localparam S_1 = 3'b001;
    localparam S_2 = 3'b010;
    localparam S_3 = 3'b011;
    localparam S_UNLOCK = 3'b100;

    //sequential
    always @(posedge clk or posedge rst) begin
        if(rst) current_state <= S_INITIAL;  
        else current_state <= next_state; 
    end

    // * means its combinational and listens to everything
    always @(*) begin
        case (current_state)
            S_INITIAL: begin
                if(data == 1'b0) next_state = S_INITIAL; 
                else next_state = S_1;
            end

            S_1: begin
                if(data == 1'b0) next_state = S_2; 
                else next_state = S_1; // This overlaps - '1-1' ends in '1' so we can stay in S_1.
            end

            S_2: begin
                if(data == 1'b0) next_state = S_INITIAL; 
                else next_state = S_3;
            end

            S_3: begin
                if(data == 1'b0) next_state = S_2; //this overlaps - '1-0-1-0' ends in '1-0' so we can fall back to S_2.
                else next_state = S_UNLOCK;
            end

            S_UNLOCK: begin
                next_state = S_INITIAL;
            end
             
            default: next_state = S_INITIAL;
        endcase
    end

    //combinational
    always @(*) begin
        if(current_state == S_UNLOCK) unlock = 1'b1;
        else unlock = 1'b0;
    end
endmodule
