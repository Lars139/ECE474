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

reg ram_wr;

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

/*Block: mealy output
* Desc: Controlling the output of the state machine 
*/
always_comb begin
	case(rbc_ps)
		byte1:
			zero_sel = '0;
		byte4:
			reg_out = '1;
		rbc_set: begin
			reg_out = '0;
			ram_wr = '1;
			zero_sel = '1;
		end
	endcase
end

assign ram_wr_n = !ram_wr;
assign avg_ena = (rd_fifo) ? 1:0; 

//--------------------- READ WAIT SM ----------------------// 
// 3-state state machine for byte_count 
enum reg [1:0] {rd_df = 2'b11, rd_wait = 2'b00, rd_read = 2'b01} rd_wt_ps, rd_wt_ns;

/*Block: read_wait trans
* Desc: update the present state to the next state
*/
always_ff @(posedge clk_2, negedge reset_n) begin
	if(!reset_n) 
		rd_wt_ps <= rd_wait;
	else
		rd_wt_ps <= rd_wt_ns;
end

/*Block: next state control (check header)
* Desc: controlling the next state of the byte count
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
*/
always_comb begin
	case(rd_wt_ps)
		rd_read:
			rd_fifo = '1;
	endcase
end


	
endmodule

