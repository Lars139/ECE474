//top.sv -  R. Traylor  -  5.31.2015
//this module is the clock hardware testbench      
//

module top(
          input          reset_n,             //async reset - active low
          input          clk_50,              //input clock for DE0 nano board
          output         enable_low,          //hardwired enable_n on the 138 decoder
          output         enable_high,         //hardwired enable  on the 138 decoder
          input          mil_time,            //1=24 hour clock, 0=12 hour clock   
          input          raw_set_clk_button,  //pushbutton input  -set clock
          input          raw_set_sec_button,  //      "           -increment seconds
          input          raw_set_min_button,  //      "           -increment minutes
          input          raw_set_hrs_button,  //      "           -increment hours
          output         clk_10khz,           //PLL test output
          output   [6:0] segment_data,        //segment outputs for all digits
          output   [2:0] digit_select         //digit select, encoded for the HC138 decoder
          );

wire         clk_1ms;      //one millisecond clock to pass to clock module
wire         clk_1sec;     //one second clock to pass to clock module 
wire         pll_reset;    //reset for pll must be inverted
reg  [13:0]  counter_reg;  //divide down counter for 10khz pll output

assign enable_low  = 1'b0;     //HC138 decoder enable, active low
assign enable_high = 1'b1;     //HC138 decoder enable, active high

clock  clock_inst0 (
       .reset_n             ( reset_n             ) ,
       .clk_1sec            ( clk_1sec            ) ,   //1 sec clock tick for counter
       .clk_1ms             ( clk_1ms             ) ,   //fast clock for multiplexing digits 
       .mil_time            ( mil_time            ) ,   //1=24 hour clock, 0=12 hour clock   
       .raw_set_clk_button  ( raw_set_clk_button  ) ,   //pushbutton input  -set clock
       .raw_set_sec_button  ( raw_set_sec_button  ) ,   //      "           -increment seconds
       .raw_set_min_button  ( raw_set_min_button  ) ,   //      "           -increment minutes
       .raw_set_hrs_button  ( raw_set_hrs_button  ) ,   //      "           -increment hours
       .segment_data        ( segment_data        ) ,   //segment outputs for all digits
       .digit_select        ( digit_select        )     //digit select, encoded for the HC138 decoder
     );

assign pll_reset   = ~reset_n; //areset on PLL is active high

//The PLL outputs a 10khz clock. It can't go slower with a 50Mhz reference clock.
newpll  newpll_0 (
        .areset ( pll_reset ), //inverted reset_n
        .inclk0 ( clk_50    ), //DE0 clock is 50Mhz
        .c0     ( clk_10khz ), //monitored outside chip
        .locked (           )  //no connect
        );

//create the 1hz (1 sec period) clock tick from the 10khz PLL output
//always @(posedge clk_50, negedge reset_n)   //FAST CLOCK FOR TESTING
always @(posedge clk_10khz, negedge reset_n)
    if(~reset_n)                      counter_reg <= '0; 
    else if (counter_reg == 14'd4999) counter_reg <= '0; //reset at 4999
    else                              counter_reg <= counter_reg + 1'b1;
assign clk_1ms  = counter_reg[3];     //1 ms clock for multiplexing digits


//divide timer by two to give division by 10000 with 50% duty cycle
//this gives the colon a 1 sec blink rate with equal on and off times
always @(posedge clk_10khz, negedge reset_n)
    if(~reset_n)                      clk_1sec   <= 1'b0; 
    else if (counter_reg == 14'd4999) clk_1sec    <= ~clk_1sec; //toggle at 

endmodule
