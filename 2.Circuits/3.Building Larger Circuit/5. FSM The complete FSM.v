module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    parameter IDLE = 0 , A = 1 , B = 2 , C = 3 , D = 4 , E = 5 , F = 6 , G = 7 , COUNT = 8 , DONE = 9;
    reg [3:0]   state;
    
     always@(posedge clk)
        begin
            if(reset)
                state <= IDLE ;
            else
                begin
                    case(state)
                        IDLE :  state <= (data)? A : IDLE ;
                        A    :  state <= (data)? B : IDLE ;
                        B    :  state <= (!data)? C : B ;
                        C    :  state <= (data)? D : IDLE;
                        D    :  state <= E ;
                        E    :  state <= F ;
                        F    :  state <= G ;
                        G    :  state <= COUNT ;
                        COUNT:  state <= (done_counting)? DONE : COUNT ;
                        DONE :  state <= (ack)? IDLE : DONE ;
                    endcase
                end
        end
    
    assign shift_ena = (state==D | state==E | state==F | state==G);
    assign counting  = (state == COUNT);
    assign done      = (state == DONE);
endmodule
