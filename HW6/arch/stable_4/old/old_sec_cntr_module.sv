module sec_cntr( input reset_n,
	input clk_1sec,
	output f_1min    //Has it been a minutes yet?
	);

//Creating a counter for second that would count up to 59
reg [5:0] cntr;

//Creating a buffer to store the value of 1minute flag
reg b_1min;

/* Block: second counter
*  Desc:  This block is the second counter itself
*/
always_ff @ (posedge clk_1sec, negedge reset_n) begin
if(!reset_n)
	cntr <= 6'b00_0000;

else
	begin
	if(b_1min)
		cntr <= 6'b00_0000;
	else
		begin
		cntr <= cntr+1;
		end
	end
end//Ends here -- second counter

/* Block: Is_59?
*  Desc: This block toggle b_1min once the counter reaches 59
* 	 b_1min will later be used to reset the counter to 0
*/
always_comb begin
if(cntr == 59)
	b_1min = '1;
else
	b_1min = '0;
end//Ends here -- is_59


//f_1min is b_1min (just change the name)
assign f_1min = b_1min ? '1 : '0;



endmodule
