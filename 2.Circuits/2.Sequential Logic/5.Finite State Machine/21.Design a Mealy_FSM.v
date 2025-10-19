module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter D1 = 2'b00, D2 = 2'b01, D3 = 2'b10;
    reg [1:0] state ;
    
    always@(posedge clk or negedge aresetn)
        begin
            if(!aresetn)
                state <= D1;
            else
                begin
                    case(state)
                        D1 :
                            begin
                                state <= (x)? D2 : D1 ;
                            end
                        D2 :
                            begin
                                state <= (x)? D2 : D3 ;
                            end
                        D3 :
                            begin
                                state <= (x)? D2 : D1 ;
                            end
                    endcase
                end
        end

      always @(*) begin
        case (state)
            D3: z = x;   // When we’re in D3 and x==1 → “101” detected
            default: z = 0;
        endcase
    end
endmodule
