`timescale 1ns/1ns

module tb; //testbench module 

integer i;

parameter CYCLE = 100; 

reg clk_1sec, clk_1ms;
reg reset_n;
reg mil_time;
reg [2:0] digit_select;
reg [6:0] segment_data;

reg f_1min;

//clock generation for write clock
initial begin
  clk_1sec <= 0; 
  forever #(CYCLE/2) clk_1sec = ~clk_1sec;
end

//release of reset_n relative to two clocks
initial begin
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

initial begin
    mil_time <= '1;
end

clock clock_0(.*);

initial begin
while(1) begin
#(CYCLE);
end

end

endmodule
