module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 

    always@(posedge clk or posedge areset)
        begin
            if(areset == 1)
                q <= 'd0;
            else
                begin
                    if(load)
                        q <= data ;
                    else if(ena)
                        begin
                        	q[3] <= 'b0;
                            q <= q>>1;
                        end
                    else
                        q <= q;
                end
                    
        end
        
endmodule
