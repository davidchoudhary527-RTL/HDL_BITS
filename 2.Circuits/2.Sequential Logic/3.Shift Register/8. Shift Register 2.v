module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    MUXDFF ins0(SW[3], KEY[0], KEY[1], KEY[2], KEY[3], LEDR[3]);
    MUXDFF ins1(SW[2], KEY[0], KEY[1], KEY[2], LEDR[3], LEDR[2]);
    MUXDFF ins2(SW[1], KEY[0], KEY[1], KEY[2], LEDR[2], LEDR[1]);
    MUXDFF ins3(SW[0], KEY[0], KEY[1], KEY[2], LEDR[1], LEDR[0]);
endmodule

module MUXDFF (
	input R,
    input clk,
    input E,
    input L,
    input W,
    output reg Q
);
    wire in0 , in1 ;
    assign in0 = (E)? W : Q  ;
    assign in1 = (L)? R : in0 ;
    always@(posedge clk)
        begin
            Q   <= in1;
        end

endmodule
