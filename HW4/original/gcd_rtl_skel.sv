//gdc skeleton code

module gcd( input [31:0] a_in,
            input [31:0] b_in,
            input start,
            input reset_n,
            input clk,
            output reg [31:0] result,
            output reg done);

//declare the internal 32-bit register busses

reg [31:0] .......
reg [31:0] .......

//declare the enumerated values for register a mux select
  enum reg [1:0] {load_a        .......

//delcare the enumerated values for register b mux select
  enum reg [1:0] {load_b        .......

//create reg_a and its mux
always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n)  .......

//create reg_b and its mux
always_ff @(posedge clk, negedge reset_n) begin
  if (!reset_n)  ........ 

//create the combinatorial signals that will steer the state machine 
assign a_lt_b  ........ 
assign b_neq_zero  ........

//create the output signal from the internal register output
assign result = reg_a;

//declare the enumerated values for gcd_sm
  enum reg [1:0] {idle      = 2'b00,......

//build the present state storage for the state machine
always_ff @(posedge clk, negedge reset_n)
    if (!reset_n) gcd_ps <=  ........

//build the next state combo logic for the state machine
always_comb begin
  gcd_ns = XX;       //default _ns assignment
  case (gcd_ps)  ........

//form the state machine mealy outputs here
always_comb begin
  reg_a_sel = hold_a;  //default assignments
  reg_b_sel = hold_b;
  done = 1'b0;
    case (gcd_ps)  ........
end //always_comb

//that's all folks! Piece of cake.

endmodule
