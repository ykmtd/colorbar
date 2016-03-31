
module TOP
  (
   input wire        CLOCK_100,

   output wire       VGA_HS,
   output wire       VGA_VS,

   output reg [15:0] LED,

   output wire [3:0] VGA_R,
   output wire [3:0] VGA_G,
   output wire [3:0] VGA_B);

    wire             CLOCK_25, LOCKED;

    clk_wiz_1 clkgen(CLOCK_100, CLOCK_25, LOCKED);

    VGA vga(CLOCK_25, ~LOCKED, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B);

    reg [25:0]       cnt;

    always @(posedge CLOCK_25) cnt <= cnt + 1;

    always @(posedge CLOCK_25) LED <= {VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, ~LOCKED, cnt[25]};

endmodule
