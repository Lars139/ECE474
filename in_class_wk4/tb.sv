module tb ();
parameter CYCLE = 100;
reg clk, reset_n;
reg [7:0] count;


//create the clock
initial begin
  clk = 0;
  forever #(CYCLE/2) clk = ~clk;
end

//create the timing for reset
initial begin
  reset_n = 0; //initalize reset aserted
  #(3*CYCLE) @(posedge clk); //wait 3 clock cycles and one pos edge
  @(negedge clk); reset_n = 1; //at the next negedge, release reset_n
end

//a simple counter
always_ff @ (posedge clk, negedge reset_n)
  if(~reset_n)
    count <= '0;
  else
    count <= count + 1;

endmodule
