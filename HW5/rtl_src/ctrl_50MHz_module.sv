module ctrl_50MHz(input clk_50, 
	input reset_n,
	input byte_assembled,
	input a5_or_c3,
	output reg wr_fifo);
//--------------------- BYTE COUNT SM--------------------------//
// 6-state state machine for byte_count 
enum reg [2:0] {byte_count_df = 3'b111, header = 3'b000, byte1 = 3'b001, byte2 = 3'b010, byte3 = 3'b011, byte4 = 3'b100} byte_count_ps, byte_count_ns;


/*Block: byte count trans 
* Desc: update the present state to the next state
*/
always_ff @(posedge clk_50, negedge reset_n) begin
	if(!reset_n) 
		byte_count_ps <= header;
	else
		byte_count_ps <= byte_count_ns;
end

/*Block: next state control (byte count)
* Desc: controlling the next state of the byte count
*/
always_comb begin
	byte_count_ns = byte_count_df;
	case(byte_count_ps)
		byte_count_df:
			if(byte_assembled)
				byte_count_ns = header;
			else
				byte_count_ns = byte_count_df;
	
		header:
			if(byte_assembled)
				byte_count_ns = byte1;
			else
				byte_count_ns = header;
		
		byte1:
			if(byte_assembled)
				byte_count_ns = byte2;
			else
				byte_count_ns = byte1;
		
		byte2:
			if(byte_assembled)
				byte_count_ns = byte3;
			else
				byte_count_ns = byte2;

		byte3:
			if(byte_assembled)
				byte_count_ns = byte4;
			else
				byte_count_ns = byte3;
		byte4:
			if(byte_assembled)
				byte_count_ns = header;
			else
				byte_count_ns = byte4;
	endcase
end

/*Block: mealy output
* Desc: Controlling the output of the state machine 
*/
//Intentionally left blank lol

//--------------------- CHECK HEADER SM --------------------------//
// 3-state state machine for byte_count 
enum reg [1:0] {header_df = 2'b11, waiting = 2'b00, temp_pkt = 2'b01} header_ps, header_ns;

/*Block: check header trans
* Desc: update the present state to the next state
*/
always_ff @(posedge clk_50, negedge reset_n) begin
	if(!reset_n) 
		header_ps <= waiting;
	else
		header_ps <= header_ns;
end

/*Block: next state control (check header)
* Desc: controlling the next state of the byte count
*/
always_comb begin
	header_ns = header_df;
	case(header_ps)
		header_df:
				header_ns = waiting;
		waiting:
			if(a5_or_c3 && (byte_count_ps==header) && (byte_assembled))
				header_ns = temp_pkt;
			else
				header_ns = waiting;
		temp_pkt:
			if((byte_count_ps==byte4) && byte_assembled)
				header_ns = waiting;
			else
				header_ns = temp_pkt;
		endcase
end

/*Block: mealy output for header-wait sm
* Desc: Controlling the output of the state machine 
*/
//Intentionally left blank (again)

//--------------------- FIFO CTRL SM --------------------------//
// 3-state state machine for fifo write state machine
enum reg [1:0] {wr_df = 2'b11, write = 2'b01, no_write = 2'b00} wr_ps, wr_ns;

/*Block: fifo write trans
* Desc: update the present state to the next state
*/
always_ff @(posedge clk_50, negedge reset_n) begin
	if(!reset_n) 
		wr_ps <= no_write;
	else
		wr_ps <= wr_ns;
end

/*Block: next state control (check header)
* Desc: controlling the next state of the byte count
*/
always_comb begin
	wr_ns = wr_df;
	case(wr_ps)
		wr_df:
				wr_ns = no_write;
		no_write:
			if( (header_ps==temp_pkt) && (byte_assembled==1) )
				wr_ns = write;
			else
				wr_ns = no_write;
		write:
				wr_ns = no_write;
		endcase
end

/*Block: mealy output for write fifo sm
* Desc: Controlling the output of the state machine 
*/
always_comb begin
	case(wr_ps)
		wr_df:
			wr_fifo = '0;	
		no_write:
			wr_fifo = '0;		
		write:
			wr_fifo = '1;	
			
		endcase
end

endmodule

