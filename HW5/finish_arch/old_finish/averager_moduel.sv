module averager(input clk_2,
	input reset_n,
	input reg_out,
	input zero_sel,
	input reg [7:0] data,
	output reg [7:0] ram_data);

//------------------ INTERNAL VARIABLES ----------------------------//

//a result buffer that will store value until all 4 vals are added
reg [9:0] buffer;


-//------------------------ AVERAGER -------------------------------//

/*Block: averager
* Desc:  Block contains: 
	 1) an internal adder for the averager.
*	 2) The adder also has a local mxu which is used in case of 
*	 resetting the adder
	 3) Bit-shifting to perform a division of 4.
*/
always_ff @ (posedge clk_2, negedge reset_n) begin
if(!reset_n)
	buffer <= 0;
	ram_data <= 0;
else
	if(reg_out)
		ram_data <= buffer>>2;
	else
		if(zero_sel)
			buffer <= 0;
		else
			buffer <= buffer + data;
end//Ends here -- averager
endmodule
