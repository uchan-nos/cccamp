module main_tb;

logic sys_clk, rst_n_raw;
logic [5:0] onboard_led;
time last_led_on_time;
time prev_led_on_period;

main#(.CLOCK_HZ(1000_000)) main(.*);

// 5 単位時間ごとにクロックを反転 => 10 単位時間で 1 クロック
always #5 begin
  sys_clk = ~sys_clk;
end

initial begin
  sys_clk <= 0;
  rst_n_raw <= 0;
  $timeformat(0, 0, "", 7);
  $monitor("%t led=%b on_period=%5d", $time, onboard_led, prev_led_on_period);

  #13
  rst_n_raw <= 1;

  #1_000_0000
  $finish();
end

// LED が点灯した瞬間に last_led_on_time を更新
// onboard_led は 0 で点灯、1 で消灯
always @(negedge onboard_led[0], negedge rst_n_raw) begin
  if (~rst_n_raw)
    last_led_on_time <= 0;
  else
    last_led_on_time <= $time;
end

// LED が消灯した瞬間に prev_led_on_period を更新
always @(posedge onboard_led[0], negedge rst_n_raw) begin
  if (~rst_n_raw)
    prev_led_on_period <= 0;
  else
    prev_led_on_period <= $time - last_led_on_time;
end

endmodule
