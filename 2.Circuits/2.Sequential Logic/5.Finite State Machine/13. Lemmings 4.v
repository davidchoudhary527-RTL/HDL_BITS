module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    reg [2:0] state , previous_state  ;
    parameter LEFT = 3'b000 ,
              RIGHT = 3'b001 ,
              GROUND = 3'b010 ,
              DIG  = 3'b011 ,
              DEAD = 3'b100 ;
    int count ;
    
    always@(posedge clk or posedge areset)
        begin
            if(areset) 
                state <= LEFT ;
            else
                begin
                	case(state)
                        LEFT  :  
                            begin
                                state <= (ground)? ((dig)? DIG : (bump_left)?  RIGHT : LEFT ) : GROUND ;
                                previous_state <= LEFT ;
                                count <= 0;
                            end
                        RIGHT :  
                            begin
                                state <= (ground)? ((dig)? DIG :(bump_right)? LEFT : RIGHT ) : GROUND ;
                                previous_state <= RIGHT;
                            end
                        DIG   : 
                            begin
                                state <= (ground)? DIG : GROUND ;
                            end
                        GROUND: 
                            begin
                                state <= (ground)? ((count > 19)? DEAD : previous_state) : GROUND ;
                                count <= count + 1'b1 ; 
                            end
                        DEAD  : 
                            begin
                                state <= DEAD ;
                                count <= 0;
                            end
                    endcase
                end
        end
    
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == GROUND);
    assign digging = (state == DIG ); 

endmodule
