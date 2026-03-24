module top_module ();

    reg clk ,reset ,t;
    wire q ;
    tff U_q7(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );
    always#5 clk = ~clk;
    
    initial begin
        clk = 1'b0 ;
        reset = 1'b1 ;
        @(negedge clk)
        reset =1'b0 ;
        
        t =1'b0 ;
        @(negedge clk)
        t=1'b1 ;
    end
endmodule
