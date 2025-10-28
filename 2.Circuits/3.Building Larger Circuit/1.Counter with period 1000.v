module top_module (
    input clk,
    input reset,
    output [9:0] q);

    always@(posedge clk)
        begin
            if(reset)
                q<='d0;
            else
                q <= (q < 999)? q +1'd1 : 'd0 ;
        end
endmodule
