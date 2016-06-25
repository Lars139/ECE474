module ctrl_2MHz(input clk_2, 
	input reset_n,
	input not_empty,
	output reg zero_sel,
	output reg avg_ena,
	output reg reg_out,
	output reg rd_fifo,
	output reg ram_wr_n);
//--------------------- READ BYTE COUNT SM--------------------------//
// 5-state state machine
enum reg [2:0] {rbc_set = 3'b111, rbc_df = 3'b000, byte1 = 3'b001, byte2 = 3'b010, byte3 = 3'b011, byte4 = 3'b100} rbc_ps, rbc_ns;

/*Block: byte count trans 
* Desc: update the present state to the next state
*/
always_ff @(posedge clk_2, negedge reset_n) begin
	if(!reset_n) 
		rbc_ps <= byte1;
	else
		rbc_ps <= rbc_ns;
end

/*Block: next state control (byte count)
* Desc: controlling the next state of the byte count
* 	This block control the byte count on the
* 	2MHz side
*/
always_comb begin
	rbc_ns = rbc_df;
	case(rbc_ps)
		rbc_df:
			rbc_ns <= byte1;
	
		byte1:
			if(rd_fifo)
				rbc_ns <= byte2;
			else
				rbc_ns <= byte1;
		
		byte2:
			if(rd_fifo)
				rbc_ns <= byte3;
			else
				rbc_ns <= byte2;

		byte3:
			if(rd_fifo)
				rbc_ns <= byte4;
			else
				rbc_ns <= byte3;
		byte4:
			if(rd_fifo)
				rbc_ns <= rbc_set;
			else
				rbc_ns <= byte4;
		rbc_set:
				rbc_ns <= byte1;

	endcase
end

/*Block: Mealy Output 
* Desc: zero_sel: 1-Reset accumluator, 0- retrain value
* 	reg_out: 1 - find the avg value, 0 - attain value
*/
always_comb begin
	case(rbc_ps)
		byte1:
			begin
			zero_sel = '0;
			end
		byte4: //wait until byte4 is written then calculate the avg
			if(rd_fifo)
			reg_out = '1;
			else
			reg_out = '0;

		rbc_set: begin
			reg_out = '0;
			zero_sel = '1;
		end
	endcase
end

assign ram_wr_n = !zero_sel;
assign avg_ena = (rd_fifo) ? 1:0; 

//--------------------- READ WAIT SM ----------------------// 
// 3-state state machine for byte_count 
enum reg [1:0] {rd_df = 2'b11, rd_wait = 2'b00, rd_read = 2'b01} rd_wt_ps, rd_wt_ns;

/*Block: read_wait trans
* Desc: update the present state to the next stat
*/
always_ff @(posedge clk_2, negedge reset_n) begin
	if(!reset_n) 
		rd_wt_ps <= rd_wait;
	else
		rd_wt_ps <= rd_wt_ns;
end

/*Block: next state control (check header)
* Desc: Controlling wether the data in FIFO can be read
*	2 conditions need occurent in order for FIFO to be
*	avaible for reading: 
*		1) FIFO is NOT empty
*		2) the average is not on a setting up mode
*/
always_comb begin
	rd_wt_ns = rd_df;
	case(rd_wt_ps)
		rd_df:
				rd_wt_ns <= rd_wait;
		rd_wait:
			if( (not_empty == 1) && (rbc_ps != rbc_set) )
				rd_wt_ns <= rd_read;
			else
				rd_wt_ns <= rd_wait;
		rd_read:
				rd_wt_ns <= rd_wait;
		endcase
end

/*Block: mealy output for header-wait sm
* Desc: Controlling the output of the state machine 
*	Sending the rd_fifo if the average is ready to read
*	and also make sure that the FIFO is not empty 
*/
always_comb begin
	case(rd_wt_ps)
		rd_read:
			if(not_empty)
				rd_fifo = '1;
			else
				rd_fifo = '0;
		rd_wait:
			rd_fifo = '0;
	endcase
end


	
endmodule

