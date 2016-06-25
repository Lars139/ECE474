module digit_sel(input reset_n,
	input clk_1ms,
	input clk_1sec,
	input [2:0] dec_min_t,
	input [3:0] dec_min_u,
	input [1:0] dec_hr_t,
	input [3:0] dec_hr_u,
	output [3:0] dec_7seg,
	output [2:0] digit_select
);

//-------------------------------- VARIABLE  -------------------------//
enum reg [2:0] {ds_dg1 = 3'b000, ds_dg2 = 3'b001, ds_col = 3'b010, ds_dg3 = 3'b011, ds_dg4 = 3'b100, ds_df = 3'b111} ds_ps, ds_ns;

//buffer for the select
reg [2:0] b_dg_sel;

//buffer reg for the number to be going to decoded 7seg
reg [3:0] b_dec_7seg;

//blinker for the colon
reg [3:0] blinker;

//-------------------------------  DATA PATH --------------------------//
/*Block: Blinker
* Desc: Blinker
*/
assign blinker = clk_1sec ? 4'hA : 4'hB ;


/*Block: Digit Select Translation 
* Desc : This is updating the present state to next state
*/
always_ff @ (posedge clk_1ms, negedge reset_n) begin
	if(!reset_n)
		ds_ps <= ds_df;
	else
		ds_ps <= ds_ns;
end


/*Block: Digit Select Next State Control
* Desc : Controlling the next state of the state machine
*/
always_comb begin
	ds_ns = ds_df;
	case(ds_ps)
		ds_df:
			ds_ns = ds_dg1;

		ds_dg1:
			ds_ns = ds_dg2;

		ds_dg2:
			ds_ns = ds_col;

		ds_col:
			ds_ns = ds_dg3;

		ds_dg3:
			ds_ns = ds_dg4;

		ds_dg4:
			ds_ns = ds_dg1;
	endcase
end


/*Block: Digit Selection Mealy output
* Desc : Output from the sate machine
*/
always_comb begin
	unique case(ds_ps)
		ds_dg1: 
			begin
			b_dg_sel = 3'b000;
			b_dec_7seg = dec_min_u;
			end

		ds_dg2:
			begin
			b_dg_sel = 3'b001;
			b_dec_7seg = {'0, dec_min_t};
			end

		ds_col:
			begin
			b_dg_sel = 3'b010;
			b_dec_7seg = blinker;
			end

		ds_dg3:
			begin
			b_dg_sel = 3'b011;
			b_dec_7seg = dec_hr_u;
			end

		ds_dg4:
			begin
			b_dg_sel = 3'b100;
			b_dec_7seg = {'0,'0,dec_hr_t};
			end
	endcase
end


assign dec_7seg = b_dec_7seg;
assign digit_select = b_dg_sel;
 


endmodule
