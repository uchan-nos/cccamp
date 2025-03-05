/*
 * 0.5 秒ごとに LED のパターンを反転させる回路（レジスタ出力版）
 *
 * Tang Nano 9K での動作の様子を YouTube で公開しています。
 * https://www.youtube.com/watch?v=d-PA88KCTPU
 */
module main#(
  parameter CLOCK_HZ = 27_000_000
) (
  input sys_clk,
  input rst_n_raw,
  output logic [5:0] onboard_led
);

logic rst_n;
logic [$clog2(CLOCK_HZ/2):0] counter;

always @(posedge sys_clk) begin
  rst_n <= rst_n_raw;
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    counter <= 0;
  else if (counter >= CLOCK_HZ/2 - 1)
    counter <= 0;
  else
    counter <= counter + 1'd1;
end

// 出力をレジスタで行う
always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    onboard_led <= 6'b111001;
  else if (counter == 0)
    onboard_led <= ~onboard_led;
end

endmodule
