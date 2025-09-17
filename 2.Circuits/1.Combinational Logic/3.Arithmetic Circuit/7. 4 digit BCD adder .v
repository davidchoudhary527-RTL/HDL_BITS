module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire [4:0] cout_temp ;
    assign cout_temp[0] = cin ;
    genvar i ;
    generate 
        for ( i=0 ; i < 4 ; i++ )
            begin : bcd_adder
                bcd_fadd U_bcd(
                    .a(a[4*i+3 : 4*i]),
                    .b(b[4*i+3 : 4*i]),
                    .cin(cout_temp[i]),
                    .sum(sum[4*i+3 : 4*i]),
                    .cout(cout_temp[i+1])
                );
            end
    endgenerate
    assign cout = cout_temp[4];

endmodule
