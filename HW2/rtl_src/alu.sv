module alu(
      input        [7:0] in_a     ,  //input a
      input        [7:0] in_b     ,  //input b
      input        [3:0] opcode   ,  //opcode input
      output  reg  [7:0] alu_out  ,  //alu output
      output  reg        alu_zero ,  //logic '1' when alu_output [7:0] is all zeros
      output  reg        alu_carry   //indicates a carry out from ALU 
      );

//Declaration of OP code macro
//c_ to mark the identifier as a const
parameter c_add = 4'h1;
parameter c_sub = 4'h2;
parameter c_inc = 4'h3;
parameter c_dec = 4'h4;
parameter c_or  = 4'h5;
parameter c_and = 4'h6;
parameter c_xor = 4'h7;
parameter c_shr = 4'h8;
parameter c_shl = 4'h9;
parameter c_onescomp = 4'hA;
parameter c_twoscomp = 4'hB;

//Creating a temporary wire
reg [8:0] temp;

//Does in_a[7:0] means the same thing as in_a??
always_comb
	case (opcode)
		c_add :	begin
			temp = in_a + in_b; 
			alu_out[7:0] = temp[7:0];
			alu_carry = temp[8];
			end
		
		c_sub : begin
			temp  = in_a - in_b;
			alu_out[7:0] = temp[7:0];
			alu_carry = temp[8];
			end

		c_inc :	begin
			temp = in_a + 1;
			alu_out[7:0] = temp[7:0]; 
			alu_carry = temp[8];
			end

		c_dec : begin
			temp = in_a - 1;
			alu_out[7:0] = temp[7:0];
			alu_carry = temp[8];
			end 

		c_or  :	begin
			alu_out[7:0] = in_a | in_b;
			alu_carry = 0;
			end
 
		c_and : begin
			alu_out[7:0] = in_a & in_b;
			alu_carry = 0;
			end

		c_xor : begin
			alu_out[7:0] = in_a ^ in_b;
			alu_carry = 0;
			end

		c_shr : begin
			alu_out[7:0] = in_a[7:0]>>1;
			//alu_out[7] = 0; //Not so sure about this (0 fil?)
			alu_carry = 0;
			end

		c_shl : begin
			temp = in_a[7:0]<<1;
			alu_out[7:0] = temp[7:0];
			alu_carry = temp[8];
			end

		c_onescomp:begin
			alu_out = ~in_a;
			alu_carry = 0;
			end					

		c_twoscomp:begin
			temp = ~in_a + 1'b1;
			alu_out = temp[7:0];
			alu_carry = temp[8];
			end

		default:begin
			alu_out = in_a;
			alu_carry = 0;
			end
	endcase

	assign alu_zero = !alu_out;

endmodule
