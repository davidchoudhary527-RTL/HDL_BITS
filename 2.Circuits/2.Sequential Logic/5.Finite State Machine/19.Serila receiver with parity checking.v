module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata
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
              WAIT  = 4'b1011,
              PARITY= 4'b1100;
    
    reg [3:0] state ;
    reg [7:0] data ;
    reg odd ;
    
    always @(posedge clk)
        begin
            if(reset)
                begin
                	state <= START ;
                    data  <= 8'b0  ;
                    odd   <= 0 ;
                end
            else
                begin
                    case(state)
                        START :
                            begin
                                state <= (in)? START : D1 ;
                                odd <= 0;
                            end
                        D1    : 
                            begin
                                state <= D2 ;
                                data  <= {in , data[7:1]};
                                odd <= (in)? ~odd : odd ;
                            end
                        D2    : 
                            begin
                                state <= D3 ;
                                data  <= {in , data[7:1]};
                                odd <= (in)? ~odd : odd ;
                            end
                        D3    : 
                            begin
                                state <= D4 ;
                                data  <= {in , data[7:1]};
                                odd <= (in)? ~odd : odd ;
                            end
                        D4    : 
                            begin
                                state <= D5 ;
                                data  <= {in , data[7:1]} ;
                                odd <= (in)? ~odd : odd ;
                            end
                        D5    : 
                            begin
                                state <= D6 ;
                                data  <= {in , data[7:1]} ;
                                odd <= (in)? ~odd : odd ;
                            end
                        D6    : 
                            begin
                                state <= D7 ;
                                data  <= {in , data[7:1]} ;
                                odd <= (in)? ~odd : odd ;
                            end
                        D7    : 
                            begin
                                state <= D8 ;
                                data  <= {in , data[7:1]} ;
                                odd <= (in)? ~odd : odd ;
                            end
                        D8    : 
                            begin
                                state <= PARITY ;
                                data  <= {in , data[7:1]} ;
                                odd <= (in)? ~odd : odd ;
                            end
                        PARITY: state <= (in== ~odd)? STOP :WAIT ;
                        STOP  : state <= (in)? DONE: WAIT ;
                        WAIT  : state <= (in)? START : WAIT;
                        DONE  : state <= (in)? START : D1;
                    endcase
                end
        end
    
    assign done = (state == DONE);
    assign out_byte = (done)? data : 8'b0 ;
    // New: Add parity checking.
endmodule
