module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter START = 4'b0000,
              D1    = 4'b0001,
              D2    = 4'b0010,
              D3    = 4'b0011,
              D4    = 4'b0100,
              D5    = 4'b0101,
              D6    = 4'b0110,
              D7    = 4'b0111,
              D8    = 4'b1000,
              STOP  = 4'b1001,
              DONE  = 4'b1010,
              WAIT  = 4'b1011;
    reg [3:0] state ;
    
    always @(posedge clk)
        begin
            if(reset)
                state <= START ;
            else
                begin
                    case(state)
                        START : state <= (in)? START : D1 ;
                        D1    : state <= D2 ;
                        D2    : state <= D3 ;
                        D3    : state <= D4 ;
                        D4    : state <= D5 ;
                        D5    : state <= D6 ;
                        D6    : state <= D7 ;
                        D7    : state <= D8 ;
                        D8    : state <= STOP ;
                        STOP  : state <= (in)? DONE: WAIT ;
                        WAIT  : state <= (in)? START : WAIT;
                        DONE  : state <= (in)? START : D1;
                    endcase
                end
        end
    
    assign done = (state == DONE);
                        
    		 	
endmodule
