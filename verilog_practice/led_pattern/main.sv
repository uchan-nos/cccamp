module main(
  input sys_clk,
  input rst_n_raw,
  output [5:0] onboard_led
);

assign onboard_led = 6'b001010;

endmodule
