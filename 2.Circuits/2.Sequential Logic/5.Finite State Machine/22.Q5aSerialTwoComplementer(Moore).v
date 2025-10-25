module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter S0 = 0 , S1 =1 ;
    reg state ;
    
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                begin
                	state <= S0 ;
                    z <= 0 ;
                end
            else
                begin
                	case(state)
                        S0 : 
                            begin
                                state <= (x)? S1 : S0 ;
                                z <= x ;
                            end
                        S1 :
                            begin
                                state <= S1;
                                z <= ~x ; 
                            end
                        default :
                            begin
                                state <= S0;
                            end
                    endcase
                end 
        end
    
endmodule
