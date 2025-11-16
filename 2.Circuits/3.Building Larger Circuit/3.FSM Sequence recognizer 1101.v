module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    parameter [2:0] IDLE = 00 , A = 1 , B = 2 , C = 3 , DONE = 4;
    reg [2:0] state ;
    
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
                        C    :  state <= (data)? DONE : A;
                        DONE :  state <= DONE;
                    endcase
                end
        end
    assign start_shifting = (state == DONE );
    
endmodule
