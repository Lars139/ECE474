module counter #(parameter width=8) (
  input              clk,       //clock input   
  input              reset_n,   //async reset  
  input              enable,    //count enable 
  input              up,        //count up 
  input              down,      //count down 
  output [width-1:0] count_out  //counter output 
  );
  endmodule
