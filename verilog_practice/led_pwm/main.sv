/*
 * PWM で LED の明るさを徐々に変化させる回路
 */
module main#(
  parameter CLOCK_HZ = 27_000_000
) (
  input sys_clk,
  input rst_n_raw,
  output [5:0] onboard_led
);

logic rst_n;

// PWM 輝度制御タイマと輝度設定値
logic [7:0] pwm_timer;
logic [7:0] brightness;

assign onboard_led = ~{5'b0, pwm_timer <= brightness};

// PWM 周期は 4ms とする。（256 周期で約 1s）
// 256 段階の階調制御とすると、1 段階あたりの時間は 4ms/256 となる。
// カウンタのビット幅は clog2(CLOCK_HZ * 4ms/256) = clog2(CLOCK_HZ * 4 / 1K / 256)
localparam PWM_STEP_PERIOD = CLOCK_HZ * 4 / 1000 / 256;
localparam PWM_STEPTIM_WIDTH = $clog2(PWM_STEP_PERIOD);
logic [PWM_STEPTIM_WIDTH-1:0] pwm_steptim;

// pwm_timer が 0 に戻る瞬間を表すイベントフラグ
logic pwm_timer_update;
assign pwm_timer_update = pwm_timer == 255 & pwm_steptim_update;

// pwm_steptim が 0 に戻る瞬間を表すイベントフラグ
logic pwm_steptim_update;
assign pwm_steptim_update = pwm_steptim == PWM_STEP_PERIOD - 1;

always @(posedge sys_clk) begin
  rst_n <= rst_n_raw;
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    pwm_timer <= 0;
  else if (pwm_steptim_update)
    pwm_timer <= pwm_timer + 1'd1;
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    brightness <= 0;
  else if (pwm_timer_update)
    brightness <= brightness + 1'd1;
end

always @(posedge sys_clk, negedge rst_n) begin
  if (~rst_n)
    pwm_steptim <= 0;
  else if (pwm_steptim_update)
    pwm_steptim <= 0;
  else
    pwm_steptim <= pwm_steptim + 1'd1;
end

endmodule
