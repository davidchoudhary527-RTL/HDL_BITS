module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    reg [1:0] counter ;
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                begin
                    state <= 2'b01;
                end
            else
                begin
                    case(state)
                        2'b00 : state <= (train_valid)? ((train_taken)? 2'b01 : 2'b00 ) : 2'b00 ;
                        2'b01 : state <= (train_valid)? ((train_taken)? 2'b10 : 2'b00 ) : 2'b01 ;
                        2'b10 : state <= (train_valid)? ((train_taken)? 2'b11 : 2'b01 ) : 2'b10 ;
                        2'b11 : state <= (train_valid)? ((train_taken)? 2'b11 : 2'b10 ) : 2'b11 ;
                    endcase
                end
        end

endmodule
