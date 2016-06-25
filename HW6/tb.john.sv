`timescale 1ns/1ns

module tb; //testbench module 

integer input_file, output_file, in, out;
integer i;

parameter CYCLE = 100; 

reg clk_50, reset_n;
reg start, done, data_en;
reg serial_data;
reg [7:0] data_out;

//clock generation for write clock
initial begin
  clk_50 <= 0; 
  forever #(CYCLE/2) clk_50 = ~clk_50;
end

//release of reset_n relative to two clocks
initial begin
    input_file  = $fopen("input_data", "rb");
    if (input_file==0) begin 
      $display("ERROR : CAN NOT OPEN input_file"); 
    end
    output_file = $fopen("output_data", "wb");
    if (output_file==0) begin 
      $display("ERROR : CAN NOT OPEN output_file"); 
    end
    serial_data='x;
    start=1'b0;
    reset_n <= 0;
	 data_en = 1;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

shiftReg shiftReg_0(.*); //instantiate the gcd unit

initial begin

  #(CYCLE*4);  //delay after reset
  while(! $feof(input_file)) begin 
   $fscanf(input_file,"%d", serial_data);
   start=1'b1;
   #(CYCLE);
   data_en=1'b1;
   while(done != 1'b1) #(CYCLE);
   $display ("serial_data=%d   data_out=%d", serial_data, data_out);
   #(CYCLE*2); //2 cycle delay between trials
  end
$stop;
$fclose(input_file);
end

endmodule
