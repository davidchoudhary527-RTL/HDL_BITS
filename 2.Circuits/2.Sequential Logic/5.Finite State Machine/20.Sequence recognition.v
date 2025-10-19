module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter START = 4'b0000,
              D1    = 4'b0001,
              D2    = 4'b0010,
              D3    = 4'b0011,
              D4    = 4'b0100,
              D5    = 4'b0101,
              D6    = 4'b0110,
              D7    = 4'b0111,
              DISC  = 4'b1000,
              FLAG  = 4'b1001,
              ERROR = 4'b1010;
    
    reg [3:0] state ;
    
    always@(posedge clk)
        begin
            if(reset)
                state <= START ;
            else
                begin
                    case(state)
                        START : 
                            begin
                                state <= (in)? D1 : START ;
                            end
                        D1    : 
                            begin
                                state <= (in)? D2 : START ;
                            end
                        D2    : 
                            begin
                                state <= (in)? D3 : START ;
                            end
                        D3    : 
                            begin
                                state <= (in)? D4 : START ;
                            end
                        D4    : 
                            begin
                                state <= (in)? D5 : START ;
                            end
                        D5    : 
                            begin
                                state <= (in)? D6 : DISC ;
                            end
                        D6    : 
                            begin
                                state <= (in)? ERROR : FLAG ;
                            end
                        DISC  :
                            begin
                                state <= (in)? D1 : START ;
                            end
                        FLAG  :
                            begin
                                state <= (in)? D1 : START ;
                            end
                        ERROR :
                            begin
                                state <= (in)? ERROR : START ;
                            end
                    endcase
                end
        end
    
    assign disc = (state == DISC) ;
    assign flag = (state == FLAG) ;
    assign err  = (state == ERROR) ;
endmodule
