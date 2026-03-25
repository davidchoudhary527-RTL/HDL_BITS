module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

    reg [9:0] counter = 10'b0 ;
    
    always@(posedge clk)
        begin
            if(load)
                begin
                    counter <= data ;
                end
            else if(counter > 'b0)
                begin 
                    counter <= counter - 1'b1 ;
                end
            else
                begin
                    counter <= counter ;
                end
        end
    assign tc = (counter == 'b0);
    
    
endmodule
