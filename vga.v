
module VGA
  (
   input wire        clk,
   input wire        rst,

   output wire       hsync,
   output wire       vsync,
   output wire [3:0] vga_r,
   output wire [3:0] vga_g,
   output wire [3:0] vga_b);

    reg [9:0]        hsync_cnt;
    reg [9:0]        vsync_cnt;

    always @(posedge clk)
      hsync_cnt <= (rst) ? 0 :
                   (hsync_cnt == 799) ? 0 : hsync_cnt + 1;

    always @(posedge clk)
      vsync_cnt <= (rst) ? 0 :
                   (hsync_cnt == 799) ? ((vsync_cnt == 524) ? 0 : vsync_cnt + 1) :
                   vsync_cnt;

    wire             output_enable = (hsync_cnt < 640 && vsync_cnt < 480);

    wire [3:0]       r_color = ((hsync_cnt / 80) & 1) ? 4'hf : 4'h0;
    wire [3:0]       g_color = ((hsync_cnt / 80) & 2) ? 4'hf : 4'h0;
    wire [3:0]       b_color = ((hsync_cnt / 80) & 4) ? 4'hf : 4'h0;

    assign vga_r = (output_enable) ? r_color : 4'b0;
    assign vga_g = (output_enable) ? g_color : 4'b0;
    assign vga_b = (output_enable) ? b_color : 4'b0;

    assign hsync = (hsync_cnt < 656 || hsync_cnt >= 752);
    assign vsync = (vsync_cnt < 490 || vsync_cnt >= 492);

endmodule
