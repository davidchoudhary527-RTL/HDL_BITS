module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); 
    
    parameter [1:0] B1 = 0 , B2 = 1 , B3 = 2 ,DONE = 3 ;
    reg [1:0] state ;
    reg [23:0] ans ;
   // State flip-flops (sequential)
    always @(posedge clk)
        begin
            if(reset)
                begin
                    state <= B1 ;
                end
            else
                begin
                    case(state)
                        B1 : 
                            begin
                                state <= (in[3])? B2 : B1 ;
                                ans <= {ans[15:0],in};
                            end
                        B2 : 
                            begin
                                state <= B3 ;
                                ans <= {ans[15:0],in};
                            end
                        B3 : 
                            begin
                                state <=DONE ;
                                ans <= {ans[15:0],in};
							end
                        DONE:
                            begin
                                if(in[3])
                                    begin
                                        state <= B2;
                                        ans <= {ans[15:0],in};
                                    end
                                else
                                    state <= B1 ;
                            end
                    endcase
                end
        end
    // Output logic
    assign done = (state == DONE ) ;
    assign out_bytes = (done) ? ans : 24'b0;
endmodule
