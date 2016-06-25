module seven_seg_dec(input [3:0] dec_7seg,
	output [6:0] segment_data);

reg [6:0] b_segment_data;

/* Block: 7 segment display decoder
*  Desc : This logic cloud turn a number and turn them to
* 	  a corresponding number on a stnadard 7seg display
*/
always_comb begin
	case(dec_7seg)
		4'b0000: b_segment_data = 7'h01; //displaying 0
		4'b0001: b_segment_data = 7'h4F; //displaying 1
		4'b0010: b_segment_data = 7'h12; //displaying 2
		4'b0011: b_segment_data = 7'h06; //displaying 3
		4'b0100: b_segment_data = 7'h4C; //displaying 4
		4'b0101: b_segment_data = 7'h24; //displaying 5
		4'b0110: b_segment_data = 7'h20; //displaying 6
		4'b0111: b_segment_data = 7'h0F; //displaying 7
		4'b1000: b_segment_data = 7'h00; //displaying 8
		4'b1001: b_segment_data = 7'h04; //displaying 9
		4'b1010: b_segment_data = 7'h1F; //displaying colon (on)
		4'b1011: b_segment_data = 7'h7F; //displaying colon (off)
		default: b_segment_data = 7'h7F; //if error, all off
	endcase
end

//assigning the output data to be equal to the buffer.
assign segment_data = b_segment_data;

endmodule
