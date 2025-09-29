module top_module(
    input  wire       clk,
    input  wire       reset,
    input  wire       ena,
    output reg        pm,
    output reg [7:0]  hh,
    output reg [7:0]  mm,
    output reg [7:0]  ss
);

    always @(posedge clk) begin
        if (reset) begin
            // Initialize to 12:00:00 AM
            pm <= 1'b0;       // 0 = AM, 1 = PM
            hh <= 8'h12;      // BCD: 12
            mm <= 8'h00;
            ss <= 8'h00;
        end else if (ena) begin
            // ----------------- SECONDS -----------------
            if (ss == 8'h59) begin
                ss <= 8'h00;

                // --------------- MINUTES ----------------
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // --------------- HOURS ----------------
                    if (hh == 8'h11) begin
                        hh <= 8'h12;
                        pm <= ~pm;   // toggle AM/PM at 11:59:59
                    end else if (hh == 8'h12) begin
                        hh <= 8'h01; // wrap 12 -> 1
                    end else if (hh[3:0] == 9) begin
                        hh[3:0] <= 0;
                        hh[7:4] <= hh[7:4] + 1;
                    end else begin
                        hh[3:0] <= hh[3:0] + 1;
                    end

                end else if (mm[3:0] == 9) begin
                    mm[3:0] <= 0;
                    mm[7:4] <= mm[7:4] + 1;
                end else begin
                    mm[3:0] <= mm[3:0] + 1;
                end

            end else if (ss[3:0] == 9) begin
                ss[3:0] <= 0;
                ss[7:4] <= ss[7:4] + 1;
            end else begin
                ss[3:0] <= ss[3:0] + 1;
            end
        end
    end

endmodule
