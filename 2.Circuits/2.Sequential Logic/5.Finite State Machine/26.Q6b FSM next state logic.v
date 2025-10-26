module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    reg [3:1] next ;
    
    always@(*)
        begin
            case({y,w})
                4'b0000 : next <= 3'b001 ;
                4'b0001 : next <= 3'b000 ;
                4'b0010 : next <= 3'b010 ;
                4'b0011 : next <= 3'b011 ;
                4'b0100 : next <= 3'b100 ;
                4'b0101 : next <= 3'b011 ;
                4'b0110 : next <= 3'b101 ;
                4'b0111 : next <= 3'b000 ;
                4'b1000 : next <= 3'b100 ;
                4'b1001 : next <= 3'b011 ;
                4'b1010 : next <= 3'b010 ;
                4'b1011 : next <= 3'b011 ;
            endcase
        end
                assign Y2 = next[2] ;
endmodule

