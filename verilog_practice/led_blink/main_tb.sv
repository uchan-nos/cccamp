module main_tb;

logic sys_clk, rst_n_raw;
logic [5:0] onboard_led;

main main(.*);

// 5 単位時間ごとにクロックを反転 => 10 単位時間で 1 クロック
always #5 begin
  sys_clk = ~sys_clk;
end

initial begin
  sys_clk <= 0;
  rst_n_raw <= 0;
  $timeformat(0, 0, "", 5);
  $monitor("%t led=%b", $time, onboard_led);

  #13
  rst_n_raw <= 1;

  #500000000
  $finish();
end

endmodule
