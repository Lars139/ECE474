module logic_blk (
  input        clk,        //clock input   
  input        reset_n,    //async reset  
  input        wr,         //write input   
  input        rd,         //read input    
  output       wr_ram,     //writes the ram 
  output       rd_ram,     //reads the ram 
  output       error_flag  //error indication
  );
  endmodule
