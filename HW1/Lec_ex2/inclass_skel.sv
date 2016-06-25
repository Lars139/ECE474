module inclass (
       input  clk,           // clock input
       input  reset_n,       // reset async active low
       input  read,          // read signal 
       input  write,         // write signal
       input  [7:0] data_in, // data input 
       output [7:0] data_out // data output 
       );

//declare internal signals
  wire [2:0] address;   //output of counter 
  wire ram_wr;          //write line to fifo
  wire ram_rd;          //read line to fifo
  wire logic_one;       //read line to fifo

  assign logic_one = 1'b1;    //pullup to logic one

//-----------------  module instantiations  --------------------------
counter #(.width(3)) counter_0(   //this is a three bit counter
  .clk           ,
  .reset_n       ,
  .enable        (logic_one),
  .up            (ram_rd),
  .down          (ram_wr),
  .count_out     (address));

//instantiate the ram here. 
ram(
	.address	(address),
	.data_in	(data_in),
	.ram_wr		(ram_wr),
	.ram_rd		(ram_rd),
	.data_out	(data_out)
);


//at least two ways to do it. 
//ram(,);

//instantaiate logic_blk here
logic_blk(
	.clk		,
	.reset_n	,
	.wr		(write),
	.rd		(read),
	.wr_ram		(ram_wr),
	.rd_ram		(ram_rd),
	.error_flag	( )
);

//--------------------------------------------------------------------
endmodule

