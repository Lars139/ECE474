module hr_cntr( input reset_n,
	input clk_1sec,
	input f_1min,
	input f_1hr,		//Has it been an hour yet?
	input mil_time,
	output f_1day,
	output [1:0] dec_hr_t, //a raw number of tenth digit for hr (to be decoded to 7seg)
	output [3:0] dec_hr_u	//a raw number of unit digit for hr (to be decoded to 7seg)
	);

//------------------------- VARIABLE DECLARATION -----------------//
//Creating a counter for second that would count up to 59
reg [5:0] cntr;

//Creating a buffer to store the value of 1-day flag
reg b_1day;

//buffer for the output (preventing latches)
reg [1:0] b_hr_t;  //for tenth digit
reg [3:0] b_hr_u;  //for unit  digit

//a flag indicating if it is in the afternoon
reg f_noon;

//a coutner buffer for the AM/PM clock mode
reg [5:0] b_cntr;

//---------------------------- DATA PATH -------------------------//
/* Block: minute counter
*  Desc:  This block is the second counter itself
*/
always_ff @ (posedge clk_1sec, negedge reset_n) begin
if(!reset_n)
	cntr <= 0;
else
	begin
	if(b_1day && f_1hr)
		cntr <= 6'b00_0000;
	else
		if(f_1hr)
			begin
			cntr <= cntr+1;
			end
		else
			begin
			cntr <= cntr;
			end
	end
end//Ends here -- second counter


/* Block: Is_23?
*  Desc: This block toggle b_1day once the minute counter reaches 24
* 	 b_1day will later be used to reset the counter to 0
*  Note: f_1hr is only high for 1sec when an hour has passed
*/
always_comb begin
if(cntr == 23 && f_1hr )  //&& f_1hr to make the signal high only for 1sec
	b_1day = '1;
else
	b_1day = '0;
end//Ends here -- is_59

//f_1hr is b_1day (just change the name)
assign f_1day = b_1day ? 1 : 0;


/* Block: Is_13?
*  Desc: This block toggle f_noon once it reaches 1am (13:00) 
* 	 It will be used in the AM/PM mode to determind the tenth digit
*	 of an hour display
*/
always_comb begin
if(cntr >= 13) //&& with f_1hr to make the signal goes high for 1sec
	f_noon = '1;
else
	f_noon = '0;
end//Ends here -- Is_13



/* Block: mil_time control
*  Desc:  This block control the counter ouput depending on the clock displaying mode
*      if it is military mode, the cntr goes through (cntr counts up to 24 hr) 
*      If it is the AM/PM mode, and it passed noon, the output will be (cntr - 12)
*/
always_comb begin
if(mil_time)
	b_cntr = cntr;
else
	if(f_noon)
		b_cntr = cntr - 4'd12;
	else
		b_cntr = cntr;
end//Ends here -- mil_time control


/* Block: minute digit parse
*  Desc: This block is a combinatorial logic block that will 
*	 and parse each digit of minute (output of this module)
*/
always_comb begin
if(b_cntr >= 0 && b_cntr < 10)
	begin
	b_hr_t = 2'd0;
	b_hr_u = b_cntr;
	end
else if(b_cntr >= 10 && b_cntr < 20)
	begin
	b_hr_t = 2'd1;
	b_hr_u = b_cntr - 5'd10;
	end
else if(b_cntr >= 20 && b_cntr < 30)
	begin
	b_hr_t = 2'd2;
	b_hr_u = b_cntr - 5'd20;
	end
else 
	begin
	b_hr_t = 2'd0;
	b_hr_u = 4'd0;
	end

end

//connecting the output wires to the buffer
assign dec_hr_t = b_hr_t;
assign dec_hr_u = b_hr_u;

endmodule
