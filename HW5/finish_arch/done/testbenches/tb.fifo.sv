`timescale 1ns/1ns

module tb; //testbench module 

integer input_file, output_file, in, out;
integer i;
integer j;
parameter CYCLE = 100; 

reg clk_50, clk_2, reset_n;
reg rd_fifo, wr_fifo;
reg [7:0] to_fifo_data;
reg [7:0] data;
reg not_empty;


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
    reset_n = 0;
    #(CYCLE * 1.5) reset_n = 1'b1; //reset for 1.5 clock cycles
end

fifo fifo_0(.*);

//Test: If the block is empty and you try to read
initial begin
  rd_fifo = '1;
  for(i = 0; i < 2; ++i) #(CYCLE) rd_fifo = '0;
end

//Test: Trying to write stuff to the fifo
initial begin
  wr_fifo = '1;
  i = 0;
  while(! $feof(input_file)) begin 
   while(1) begin //Test writing first 2 int to the FIFO
	#(CYCLE);
   $fscanf(input_file,"%d", to_fifo_data);


  end
  end
    for(j = 0; j < 4; j++) begin //printing out all the FIFO
	rd_fifo = '1;
	#(CYCLE) rd_fifo='0;
   	$display ("FIFO_reg%d: %d ",j, data);
    end
   	$display ("\n");

$stop;
$fclose(input_file);
end

endmodule
