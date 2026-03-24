module top_module();
	reg clk ,in ;
    reg [2:0] s;
    wire out ;
    
    q7 U_q7(
        .clk(clk),
        .in(in),
        .s(s),
        .out(out)
    );
    always#5 clk = ~clk;
    
    initial begin
        clk = 1'b0 ;
        s = 'd2 ;
        in = 'b0;
        @(negedge clk)
        s = 'd6;
        @(negedge clk)
        s = 'd2;
        in= 'b1;
        @(negedge clk)
        s = 'd7;
        in = 'b0 ;
        @(negedge clk)
        s = 'd0;
        in = 'b1;
        repeat(3) @(negedge clk);
        in = 'b0 ;
    end
        
    
endmodule
