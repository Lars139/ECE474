`timescale 1ps/1ps

module tb ();
  parameter CYCLE = 5000;  //5ns period = 200Mhz
  integer out_file;

//define needed internal wires (type reg) to apply signals to 

//create the clock
  initial begin
    clk = 0;
    forever #(CYCLE/2) clk = ~clk;
  end
 
//create reset_n
  initial begin
    reset_n = 0;       //initalize reset aserted
    @(posedge clk);    //wait 2 clock cycles
    @(posedge clk);   
    #100 reset_n =1;   //release reset_n after 1ns past rising edge
  end

//initalize other signals at reset time
  initial begin  
    cnt_in=0;
    ena=0;
    ..........
    ..........
  end 
  
  initial begin
    integer i;
    @(posedge reset_n);
    ena=1;
    for(i=0; i<=3; i++) @(posedge clk);  // run the clock some
    #100 s_reset=1;
    ...
    ...
    ...apply stimulus to the counter
    ...
    ...
    ...
  end
 
  //open file for results 
  initial begin
    out_file = $fopen("updn_cntr.out"); 
    $fdisplay (out_file, "cnt_out  term_cnt    time");
  end
  //write results to file
  always @ (negedge clk)  begin
    $fdisplay (out_file,"%7h   %7b   %5d", cnt_out, term_cnt, $time);
  end 

//instantiate the counter here
  updn_cntr .......




endmodule //tb.sv
