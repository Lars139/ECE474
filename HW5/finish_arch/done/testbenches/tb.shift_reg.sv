`timescale 1ns/1ns

module tb; //testbench module 

integer input_file, output_file, in, out;
integer i;
parameter CYCLE = 100; 

reg clk_50, reset_n;
reg data_ena;
reg serial_data;
reg [7:0] to_fifo_data;
reg byte_assembled;

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
    reset_n <= 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

shift_reg shift_reg_0(.*); //instantiate the gcd unit

initial begin
   data_ena = '1;
  while(! $feof(input_file)) begin 
   while(1) begin 
	#(CYCLE);
   $fscanf(input_file,"%d",  serial_data);
   $display ("to_fifo_data= %d ", to_fifo_data);
  end
  end
$stop;
$fclose(input_file);
$fclose(output_file);
end

endmodule
