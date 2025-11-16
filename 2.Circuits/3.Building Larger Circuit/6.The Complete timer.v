module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
 parameter IDLE = 0 , A = 1 , B = 2 , C = 3 , D = 4 , E = 5 , F = 6 , G = 7 , COUNT = 8 , DONE = 9;
    reg [3:0]   state , delay ;
    reg [9:0]   count1000;
    reg done_counting;
     always@(posedge clk)
        begin
            if(reset)
                begin
                	state <= IDLE ;
                    count1000 <= 'd0 ;
                end
            else
                begin
                    case(state)
                        IDLE :  state <= (data)? A : IDLE ;
                        A    :  state <= (data)? B : IDLE ;
                        B    :  state <= (!data)? C : B ;
                        C    :  state <= (data)? D : IDLE;
                        D    :  begin state <= E ; count[3] <= data ; end
                        E    :  begin state <= F ; count[2] <= data ; end
                        F    :  begin state <= G ; count[1] <= data ; end
                        G    :  begin state <= COUNT ; count[0] <= data ; end
                        COUNT:  
                            begin
                                if(count == 0 )
                                begin
                                    if(count1000 == 'd999)
                                        begin
                                            state <=  DONE  ;
                                            count1000 = 'd0;
                                        end
                                    else 
                                        begin
                                            state <= COUNT ;
                                            count1000 = count1000 + 1'b1;
                                        end
                                end
                            else
                                begin
                                    if(count1000 == 'd999)
                                        begin
                                            state <= COUNT ;
                                            count = count - 1'b1 ;
                                            count1000 = 'd0;
                                        end
                                    else 
                                        begin
                                            state <= COUNT ;
                                            count1000 = count1000 + 1'b1;
                                        end
                                end
                            end
                        DONE :  state <= (ack)? IDLE : DONE ;
                    endcase
                end
        end
    
	assign counting  = (state == COUNT);
    assign done      = (state == DONE);
endmodule
