module top_module (input a, input b, input c, output out);//

    wire out_n ;
    assign out = ~out_n ;
    andgate inst1 ( out_n , a , b , c , 1'b1 , 1'b1 );

endmodule
