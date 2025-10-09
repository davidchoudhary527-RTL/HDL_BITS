module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        state <= next_state ;
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        if(areset)
            begin
                next_state <= B;
            end
        else
            begin
                case(state)
                    A : next_state <= (in)? A : B;
                    B : next_state <= (in)? B : A;
                endcase
            end
    end

    // Output logic
        assign out = (state == B);

endmodule
