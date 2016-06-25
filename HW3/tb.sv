`timescale 1ps/1ps

module tb ();
  parameter CYCLE = 5000;  //5ns period = 200Mhz
  integer out_file;

//define needed internal wires (type reg) to apply signals to 
  reg 			reset_n;
  reg 			clk;
  reg 	[7:0]     cnt_in;
  reg 			up_dn;
  reg 			ena;
  reg 			cnt_load;
  reg 			s_reset;
  reg 	[7:0]     cnt_out;
  reg 			term_cnt;
 
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
    cnt_in= 00;
    up_dn = 1;
    ena=1;
    cnt_load = 1; 
    s_reset = 0;
  end 
  
  initial begin
    integer i;
    @(posedge clk);
   
    cnt_in=00;
    @(posedge clk);

    #100 reset_n = 1; 
    #100 up_dn = 1;
    #100 ena = 1;
    #100 cnt_load = 1;
    #100 s_reset = 0;
    #100 cnt_in = 00;
    for(i=0; i<=3; i++) @(posedge clk);  

    #100 s_reset = 1;    
    @(posedge clk);  

    #100 ena = !ena;    
    #100 s_reset = !s_reset;
    @(posedge clk);  

    #100 ena = !ena;
    #100 cnt_load = !cnt_load;
    #100 cnt_in = 02;
    @(posedge clk); 

    #100 up_dn = !up_dn;
    #100 ena = !ena;
    @(posedge clk); 
    
    #100 ena = !ena;
    #100 cnt_load = !cnt_load;
    for(i=0; i<=4; i++) @(posedge clk);  

    #100 s_reset = !s_reset;

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
  updn_cntr counter(
	.reset_n,
	.clk, 
	.cnt_in,
	.up_dn,
	.ena,
	.cnt_load,
	.s_reset,
	.cnt_out,
	.term_cnt
	); 




endmodule //tb.sv
