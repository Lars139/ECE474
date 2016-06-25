module updn_cntr #(WIDTH=8)(
    input                   reset_n  ,  //asynchronous reset, active low
    input                   clk      ,  //clock input
    input       [WIDTH-1:0] cnt_in   ,  //counter parallel input
    input                   up_dn    ,  //up, down control; up=1, down=0
    input                   ena      ,  //enable, active high
    input                   cnt_load ,  //count/load control; cnt=1, load=0
    input                   s_reset  ,  //synchronous reset, active high
    output  reg [WIDTH-1:0] cnt_out  ,  //counter output
    output                  term_cnt    //terminal cnt, assert when cnt_out=0
    );

reg [WIDTH-1:0]timer;


always_ff @(posedge clk, negedge reset_n)
begin
	if(!reset_n) timer = '0;	//if reset_n is pressed reset timer
	else 
	begin
		if (s_reset) timer = '0; //if timer_reset is set, clear
		else 
		begin
			if (!ena) timer = timer;
			else
			begin
				if(!cnt_load) timer = cnt_in;
				else
				begin
					if(up_dn) timer = timer + 1'b1; //if up increment
					else if(!up_dn) timer = timer - 1'b1; //if down, dec
				end
			end
		end
	end
	
	cnt_out = timer;
end
assign term_cnt = !cnt_out;
endmodule
