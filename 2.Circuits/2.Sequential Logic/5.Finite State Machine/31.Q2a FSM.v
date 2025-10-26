module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A =0 , B =1 ,C =2 ,D =3;
    reg [2:0] state ;
    
    always@(posedge clk)
        begin
            if(!resetn)
                state <= A;
            else
                begin
                    case(state)
                        A : state <= (r[1])? B : ((r[2])? C : ((r[3])? D : A));
                        B : state <= (r[1])? B : A ;
                        C : state <= (r[2])? C : A ;
                        D : state <= (r[3])? D : A ;
                    endcase
                end
        end
    
    assign g[1] = (state == B) ;
    assign g[2] = (state == C) ;
    assign g[3] = (state == D) ;
    
    
endmodule
