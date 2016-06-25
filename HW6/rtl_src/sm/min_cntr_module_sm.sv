module min_cntr( input reset_n,
	input clk_1sec,
	input f_1min,
	output f_1hr,		//Has it been an hour yet?
	output [2:0] dec_min_t, //a raw number of tenth digit for minute (to be decoded to 7seg)
	output [3:0] dec_min_u	//a raw number of unit digit for minute (to be decoded to 7seg)
	);

//------------------------- VARIABLE DECLARATION -----------------//
//Creating a counter for second that would count up to 59
reg [5:0] cntr;

//Creating a buffer to store the value of 1-hour flag
reg b_1hr;

//buffer for the output (preventing latches)
reg [2:0] b_min_t;  //for tenth digit
reg [3:0] b_min_u;  //for unit  digit

//creating a state machine buff for f_1hr
reg sm_b_1hr;

//---------------------------- DATA PATH -------------------------//
/* Block: minute counter
*  Desc:  This block is the second counter itself
*/
always_ff @ (posedge clk_1sec, negedge reset_n) begin
if(!reset_n)
	cntr <= 0;
else
	begin
	if(b_1hr && f_1min)
		cntr <= 6'b00_0000;
	else
		if(f_1min)
			begin
			cntr <= cntr+1;
			end
		else
			begin
			cntr <= cntr;
			end
	end
end//Ends here -- second counter


/* Block: minute digit parse
*  Desc: This block is a combinatorial logic block that will 
*	 and parse each digit of minute
*/
always_comb begin
if(cntr >= 0 && cntr < 10)
	begin
	b_min_t = 3'd0;
	b_min_u = cntr;
	end
else if(cntr >= 10 && cntr < 20)
	begin
	b_min_t = 3'd1;
	b_min_u = cntr - 6'd10;
	end
else if(cntr >= 20 && cntr < 30)
	begin
	b_min_t = 3'd2;
	b_min_u = cntr - 6'd20;
	end
else if(cntr >= 30 && cntr < 40)
	begin
	b_min_t = 3'd3;
	b_min_u = cntr - 6'd30;
	end
else if(cntr >= 40 && cntr < 50)
	begin
	b_min_t = 3'd4;
	b_min_u = cntr - 6'd40;
	end
else if(cntr >= 50)
	begin
	b_min_t = 3'd5;
	b_min_u = cntr - 6'd50;
	end
else 
	begin
	b_min_t = 3'd0;
	b_min_u = 4'd0;
	end

end

//connecting the output wires to the buffer
assign dec_min_t = b_min_t;
assign dec_min_u = b_min_u;

//------------------------------ CONTROL SIGNALS -----------------------//

/* Block: Is_59?
*  Desc: This block toggle b_1hr once the minute counter reaches 59
* 	 b_1hr will later be used to reset the counter to 0
*/
always_comb begin
if(cntr == 59 && f_1min )  //&& f_1min to make the signal high only for 1sec
	b_1hr = '1;
else
	b_1hr = '0;
end//Ends here -- is_59


//--------------------------- ANTI-GLITCHING SM --------------------------//
//TODO: make this
enum reg [1:0] {ag_wait = 2'b00, ag_ignore = 2'b01, ag_send = 2'b10, ag_df = 2'b11} ag_ps, ag_ns;

/*Block: Anti glicting transforamtion block
* Desc:  Update the present state to the next state
*/
always_ff @ (posedge clk_1sec, negedge reset_n) begin
if (!reset_n)
	ag_ps <= ag_wait;
else
	ag_ps <= ag_ns;
end//Ends here -- AGTB


/*Block: Anti Glitching Next State control
* Desc:  Contol how the state machine operates via setting the next stages
*/
always_comb begin
	ag_ns = ag_df;
	case(ag_ps)
		ag_df:
			ag_ns = ag_wait;
	
		ag_wait:
			if(b_1hr)	
				ag_ns = ag_ignore;
			else
				ag_ns = ag_wait;
	
		ag_ignore:
			if(!b_1hr)
				ag_ns = ag_send;
			else
				ag_ns = ag_ignore;

		ag_send:
			ag_ns = ag_wait;
	endcase
end//Ends here -- AGNSC


/*Block: Anti glicthing mealy output block
* Desc:  The mealy output from the state machine
*/
always_comb begin
	case(ag_ps)
		ag_wait:
			sm_b_1hr = '0;
		
		ag_send:
			sm_b_1hr = '1;
	endcase	
end

//f_1hr is b_1hr (just change the name)
assign f_1hr = sm_b_1hr ? 1 : 0;





endmodule
