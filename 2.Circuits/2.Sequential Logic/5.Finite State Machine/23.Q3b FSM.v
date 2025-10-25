module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter A = 3'd0 , 
		      B = 3'd1 , 
		      C = 3'd2 , 
		      D = 3'd3 , 
		      E = 3'd4 ;
    reg [3:0] state;
    
    always@(posedge clk)
        begin
            if(reset)
                state <= A ;
            else
                begin
                	case(state)
                        A : state <= (x)? B : A ;
                        B : state <= (x)? E : B ;
                        C : state <= (x)? B : C ;
                        D : state <= (x)? C : B ;
                        E : state <= (x)? E : D ;
                    endcase
                end
        end
    
    assign z = (state == D) | (state == E);
endmodule
