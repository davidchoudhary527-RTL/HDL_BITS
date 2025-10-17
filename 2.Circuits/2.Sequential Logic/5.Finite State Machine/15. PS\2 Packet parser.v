module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    parameter [1:0] B1 = 0 , B2 = 1 , B3 = 2 ,DONE = 3 ;
    reg [1:0] state ;
    // State transition logic (combinational)
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
                            end
                        B2 : 
                            begin
                                state <= B3 ;
                            end
                        B3 : 
                            begin
                                state <=DONE ;
							end
                        DONE:
                            begin
                                state <= (in[3])? B2 : B1;
                            end
                    endcase
                end
        end
    // Output logic
    assign done = (state == DONE ) ;

endmodule
