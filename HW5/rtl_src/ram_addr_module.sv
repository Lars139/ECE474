module ram_addr(input clk_2,
	input reset_n,
	input ram_wr_n,
	input [10:0] in_addr,
	output reg [10:0] ram_addr);

//------------------ INTERNAL VARIABLES ----------------------------//

//a result buffer that will store value until all 4 vals are added
reg [10:0] addr_buffer;


//------------------------ AVERAGER -------------------------------//

/*Block: ram addr
* Desc:  Decrement the ram addr pointer when the ram_wr_n is strobed
*/

reg bool; //lemme waste mah clk cycle here

always_ff @ (posedge clk_2, negedge reset_n) begin
if(!reset_n) begin
	addr_buffer <= in_addr;
	bool <= '0;
	end
else
	if(!ram_wr_n)
		if(bool)
			begin
			addr_buffer <= addr_buffer - 1;
			bool <= '1;
			end
		else
			begin
			addr_buffer <= addr_buffer;
			bool <= '1;
			end
	else
		addr_buffer <= addr_buffer;
end//Ends here -- dec 

assign ram_addr = addr_buffer;

endmodule
