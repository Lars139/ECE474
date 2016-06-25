module ram(
  input  [2:0] address,  //address input  
  input  [7:0] data_in,  //data input 
  input        ram_wr,   //write strobe
  input        ram_rd,   //read strobe
  output [7:0] data_out  //ram output data bus 
  );
  endmodule
