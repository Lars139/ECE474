module shift_reg(input clk_50, 
	input reset_n,
	input serial_data,
	input data_ena,
	output [7:0] to_fifo_data);

reg [7:0] ff;
//int i;  //for for-loop

always_ff @ (posedge clk_50, negedge reset_n)
if(!reset_n) begin
	ff <= '0;
end //end (!reset_n) 
else begin
	if(data_ena) begin
		ff[7] <= serial_data;
		ff[6] <= ff[7];
		ff[5] <= ff[6];
		ff[4] <= ff[5];
		ff[3] <= ff[4];
		ff[2] <= ff[3];
		ff[1] <= ff[2];
		ff[0] <= ff[1];
		/*
		ff[7] <= serial_data;
		for(int i = 7; i > 0 ; i) begin
			ff[i-1] <= ff[i];
		end
		*/
	end //end (data_ena)
end //end else

assign to_fifo_data = ff;
	
endmodule

