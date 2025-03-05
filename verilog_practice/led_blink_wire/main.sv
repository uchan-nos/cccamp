/*
 * 0.5 秒ごとに LED のパターンを反転させる回路（配線出力版）
 *
 * Tang Nano 9K での動作の様子を YouTube で公開しています。
 * https://www.youtube.com/watch?v=d-PA88KCTPU
 */
module main(
  input sys_clk,
  input rst_n_raw,
  output [5:0] onboard_led
);

logic rst_n;
logic [24:0] counter;

always @(posedge sys_clk) begin
  rst_n <= rst_n_raw;
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    counter <= 0;
  else if (counter >= 27_000_000 - 1)
    counter <= 0;
  else
    counter <= counter + 25'd1;
end

// 出力を配線（継続代入）で行う
assign onboard_led = counter < 13_500_000 ? 6'b101001 : 6'b010110;

endmodule
