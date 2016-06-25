module shift_reg(input clk_50, 
	input reset_n,
	input serial_data,
	input data_ena,
	output [7:0] to_fifo_data,
	output reg byte_assembled);
//------------------- INTERNAL VARIABLES -----------------//

//Creating a bit-shift flip-flop
reg [7:0] ff;

// 2-state state machine: 1-allow, 0-not 
enum reg {allow = '1, not_allow ='0, df='x} sm_ps, sm_ns;


//int i;  //for for-loop

//--------------------- CONTROL --------------------------//

/*Block: ctrol_bitshift
* Desc: generating the signal  byte_assembled
*/
always_ff @(posedge clk_50, negedge reset_n) begin
	if(!reset_n) 
		sm_ps <= not_allow;
	else
		sm_ps <= sm_ns;
end

/*Block: next_state_control
* Desc: generating the signal  byte_assembled
*/
always_comb begin
	sm_ns = df;
	case(sm_ps)
		allow:
			if(data_ena == 0)
				sm_ns <= not_allow;
			else 
				sm_ns <= allow;
		not_allow: 
			if(data_ena == 1) 
				sm_ns <= allow;
			else 
				sm_ns <= not_allow;

		df: sm_ns <= not_allow;
	endcase
end

/*Block: mealy output
* Desc: output of the state machine if the reading is allowed
*/

assign byte_assembled = ((sm_ps==allow) && (data_ena == '0)) ? '1 : '0;

//----------------------- DATA PATH ----------------------//
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

