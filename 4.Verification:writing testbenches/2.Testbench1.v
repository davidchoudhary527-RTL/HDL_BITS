module top_module ( output reg A, output reg B );//

    // generate input patterns here
    initial begin
		A = 'b0;
        B = 'b0;
        
        #10 A ='b1;
        #5  B ='b1;
        #5  A ='b0;
        #20 B ='b0;
    end

endmodule
