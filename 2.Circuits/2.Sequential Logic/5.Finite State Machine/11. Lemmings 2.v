module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    reg [1:0] state , previous_state  ;
    parameter LEFT = 2'b00 ,
              RIGHT = 2'b01 ,
              GROUND = 2'b10 ;
    
    always@(posedge clk or posedge areset)
        begin
            if(areset) 
                state <= LEFT ;
            else
                begin
                	case(state)
                        LEFT  :  
                            begin
                                state <= (ground)? ((bump_left)?  RIGHT : LEFT ) : GROUND ;
                                previous_state <= LEFT ;
                            end
                        RIGHT :  
                            begin
                                state <= (ground)? ((bump_right)? LEFT : RIGHT ) : GROUND ;
                                previous_state <= RIGHT;
                            end
                        GROUND: state <= (ground)? previous_state : GROUND ;
                    endcase
                end
        end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == GROUND);
                    
endmodule
