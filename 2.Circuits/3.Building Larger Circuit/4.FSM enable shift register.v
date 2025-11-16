module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
	parameter S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;
    reg [2:0]   state;
    
    always@(posedge clk) begin
        case(state)
            S0:     state = reset ? S1 : S0;
            S1:     state = S2;
            S2:     state = S3;
            S3:     state = S4;
            S4:     state = S0;
        endcase
    end
    assign shift_ena = (state==S1 | state==S2 | state==S3 | state==S4);
endmodule
