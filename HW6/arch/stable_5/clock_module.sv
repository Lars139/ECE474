module clock( input reset_n,
	input clk_1sec,
	input clk_1ms,
	input mil_time,
	output [6:0] segment_data,
	output reg [2:0] digit_select
);

//--------------------------- VARIABLES --------------------------//
//---------------------------------------------------- sec_cntr
//a flag that would toggle to 1 if a minute has passed.
reg f_1min;

//---------------------------------------------------- min_cntr
//a flag that would toggle to 1 if an hour has passed.
reg f_1hr;

//a raw number representing digit for the minute digits
//these numbers are to be decoded to 7seg [a-g] domain
reg [2:0] dec_min_t; //tenth digit; 3 bits, val range: [0,5]
reg [3:0] dec_min_u; //unit  digit; 4 bits, val range: [0,9]

//---------------------------------------------------- hr_cntr
//a flag that would toggle to 1 if a day has passed.
reg f_1day;

//a raw number representing digit for the hour digits
//these numbers are to be decoded to 7seg [a-g] domain
reg [1:0] dec_hr_t; //tenth digit; 2 bits, val range: [0,2]
reg [3:0] dec_hr_u; //unit  digit; 4 bits, val range: [0,9]


//---------------------------------------------------- digit_sel
//a raw number from giant mux to be decoded
reg [3:0] dec_7seg; 

//------------------------- DATA PATH --------------------------//
//connecting the second counter to the clock module.
sec_cntr sec_cntr_0(.*);

//connecting the minute counter to the clock module.
min_cntr min_cntr_0(.*);

//connecting the hour counter to the clock module.
hr_cntr hr_cntr_0(.*);

//instantiating the digital select module
digit_sel digit_sel_0(.*);

//instantiating the 7seg display decoder
seven_seg_dec seven_seg_dec_0(.*);

endmodule
