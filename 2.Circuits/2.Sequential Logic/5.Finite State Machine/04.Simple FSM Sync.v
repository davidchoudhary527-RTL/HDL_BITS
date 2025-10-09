module top_module(
    input clk,
    input reset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        state <= next_state;
    end

    always @(posedge clk) begin
        if(reset)
            next_state <= OFF;
        else
            begin
                case(state)
                    ON : next_state <= (k)? OFF : ON;
                    OFF: next_state <= (j)? ON  : OFF;
                endcase
            end
    end

    // Output logic
                    assign out = (state == ON);

endmodule

