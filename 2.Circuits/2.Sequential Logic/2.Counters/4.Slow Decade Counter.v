module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always @(posedge clk)
        begin
            if(reset)
                q <= 4'd0 ;
            else
                begin
                    if( q != 'b1001 )
                        q <= (slowena)? q+1 : q ;
                    else
                        q <= (slowena)? 4'b0: q ;
                end
        end
    
endmodule
