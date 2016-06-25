module fifo(input clk_2,
	input clk_50,
	input reset_n,
	input [7:0] to_fifo_data,
	input rd_fifo,
	input wr_fifo,
	output reg not_empty,
	output reg [7:0] data);
//------------------------- FIFO CTRL VARS --------------------------//
//---------------------------------------- WRITE
// declaring wr_counter for FIFO write (3bits)
reg [2:0] wr_cntr;

//TODO:FIXME: Why can't I change f_wr_fifo_reg, and wr_fifo_reg_ena to be 'wire' instead of 'reg'?
//write FIFO registers flags. Each bit position corresponding to each reg
reg [3:0] f_wr_fifo_reg;

//write FIFO enable: ena_wr_fifo_reg[n] = (f_wr_fifo_reg[n] & wr_fifo)
reg [3:0] wr_fifo_reg_ena;

//---------------------------------------  READ
// declaring rd_counter for FIFO read (3bits)
reg [2:0] rd_cntr;

// flag indicating wether FIFO is empty
reg f_not_empty;

// the last flip-flop to sync the clk
reg not_empty_ff;

//---------------------------------------  DATA PATH
//FIFO DATA PATH VARS
reg [7:0] reg_0, reg_1, reg_2, reg_3; // Declaring FIFO registers


//-------------------------- FIFO WR_CTRL ---------------------------//

/* Block: wr_cntr
*  Desc: a write FIFO 3-bit counter (incrementer) 
*  with an overflow bit (leftmost bit) uses for state machine control 
*  to determine which FIFO register to be written.  
*/
always_ff @ (posedge clk_50, negedge reset_n) begin
if(!reset_n) //resetting
	//setting the reset to be zero 
	wr_cntr <= 0; 

else //not resetting
	if(wr_fifo)
		wr_cntr <= wr_cntr +1; //if wr_FIFO, increment
	else
		wr_cntr <= wr_cntr; //if not, hold the value
end//End here -- wr_cntr


/* Block: wr_cntr_decoder_f
*  Desc: Takes input from wr_cntr 
*	1) decode to enable register write flags
*	2) use flags to generate enable signal for each reg  
*/
always_comb 
begin 
	casez (wr_cntr) //Ignore the toggle bit
	3'b?00: 
		begin
		f_wr_fifo_reg[0] = '1;
		wr_fifo_reg_ena = 0;
		wr_fifo_reg_ena[0] = (wr_fifo & f_wr_fifo_reg[0]);
		end
	3'b?01:
		begin
		f_wr_fifo_reg[1] = '1;
		wr_fifo_reg_ena = 0;
		wr_fifo_reg_ena[1] = (wr_fifo & f_wr_fifo_reg[1]);
		end

	3'b?10: 
		begin
		f_wr_fifo_reg[2] = '1;
		wr_fifo_reg_ena = 0;
		wr_fifo_reg_ena[2] = (wr_fifo & f_wr_fifo_reg[2]);
		end

	3'b?11:
		begin
		f_wr_fifo_reg[3] = '1;
		wr_fifo_reg_ena = 0;
		wr_fifo_reg_ena[3] = (wr_fifo & f_wr_fifo_reg[3]);
		end

	default:
		begin 
		wr_fifo_reg_ena = 0;
		wr_fifo_reg_ena = 4'b0000;
		end
	endcase
end //End here -- WR_decoder

//--------------------------- FIFO RD_CTRL --------------------------//

/* Block: RD_cntr
*  Desc:  This is the read coutner to keep track of where the reading 
*  head is to read off of the FIFO
*/
always_ff@ (posedge clk_2, negedge reset_n)begin
if(!reset_n)
	rd_cntr <= 0;
else
	if(rd_fifo)
		rd_cntr <= rd_cntr + 1;
	else
		rd_cntr <= rd_cntr;
end //End here -- RD_cntr



//---------------------------- FIFO DATA PATH -----------------------//

/* Block: FIFO_buffer_registers
*  Desc: These are the four registers FIFO buffer storage
*/
//TODO:Should these be separate into their own ff blocks?
always_ff @ (posedge clk_50, negedge reset_n) begin
if(!reset_n) //resetting
	begin //fills everything with zeros
	reg_0 <= 0;
	reg_1 <= 0;
	reg_2 <= 0;	
	reg_3 <= 0;
	end
else //not resetting
	begin
	case(wr_fifo_reg_ena)//TODO:FIXME:wr_fifo_reg_ena is not resetting and it's wrong
	4'b0001: reg_0 <= to_fifo_data; 
	4'b0010: reg_1 <= to_fifo_data; 
	4'b0100: reg_2 <= to_fifo_data; 
	4'b1000: reg_3 <= to_fifo_data; 
	default: 	
		begin
		reg_0 <= reg_0;
		reg_1 <= reg_1;
		reg_2 <= reg_2;
		reg_3 <= reg_3;
		end
	endcase
	end
end//(!reset_n) ends here


/* Block: FIFO_output_mux
*  Desc: select which register of FIFO will go through
*/
always_comb begin
	casez(rd_cntr)
	3'b?00: data = reg_0;
	3'b?01: data = reg_1;
	3'b?10: data = reg_2;
	3'b?11: data = reg_3;
	endcase
end


/* Block: Is_FIFO_empty
* Desc: check if the FIFO is full or empty
*/
always_comb begin
	f_not_empty = (rd_cntr ^ wr_cntr);
end


/* Block: Is_FIFO_empty_out
* Desc: use the flag from Is_FIFO_empty and output the stat
*/
always_ff @ (posedge clk_2, negedge reset_n) begin
if(!reset_n)
	not_empty_ff <= '0;	
else
	not_empty_ff <= f_not_empty;
end
assign not_empty = f_not_empty & not_empty_ff; 
//Ends here -- Is_FIFO_empty_out


endmodule
	
	
