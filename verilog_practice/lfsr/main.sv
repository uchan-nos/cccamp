/*
 * LFSR による疑似乱数生成
 */
module main#(
  parameter CLOCK_HZ = 27_000_000
) (
  input sys_clk,
  input rst_n_raw,
  input sw2_n_raw,
  output [5:0] onboard_led
);

logic rst_n;

logic [15:0] lfsr;
logic lfsr0;
logic [$clog2(CLOCK_HZ / 100)-1:0] sw_tim;
logic sw2_prev, sw2_n, sw2;

assign sw2 = ~sw2_n;

always @(posedge sys_clk) begin
  rst_n <= rst_n_raw;
  sw2_n <= sw2_n_raw;
end

assign lfsr0 = lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10];
assign onboard_led = lfsr[5:0];

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    lfsr <= 16'hCAFE;
  else if (sw_tim == 0 & ~sw2_prev & sw2)
    lfsr <= {lfsr[14:0], lfsr0};
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    sw_tim <= 0;
  else
    sw_tim <= sw_tim + 1'd1;
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    sw2_prev <= 0;
  else if (sw_tim == 0)
    sw2_prev <= sw2;
end

endmodule
