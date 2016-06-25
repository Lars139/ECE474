//-------------------------------------------------------------------
//Hardware debouncer
//Returns single pulse if button was pushed and can only
//send another pulse if the button is first released.
//
//-------------------------------------------------------------------
module debouncer( 
      input        reset_n,      //reset async active low
      input        clk,          //input clock
      input        button_data,  //data to debounce
      output  reg  button_true   //pulse data out  
      );

reg  [7:0] shift_reg;  //for 8-bit shift register 
wire       all_ones, all_zeros; 

wire button_data_n;

//looking for an active low signal that is externally pulled up
assign button_data_n = ~button_data;

//the shift register
always_ff @ (posedge clk, negedge reset_n)
  if(!reset_n)  shift_reg <= 8'h0;
  else          shift_reg <= {button_data_n, shift_reg[7:1]};

//detect if shift register holds all zeros or all ones
assign all_ones  =   (&shift_reg);
assign all_zeros =  ~(|shift_reg);

//enumerated state for the debounced button state machine
enum reg [1:0] {
  IDLE    = 2'b00,
  PUSHED  = 2'b01,
  WAIT    = 2'b10,
     XX   = 'x } button_ps, button_ns;

//infer the _ps vector flip flops for button state machine
always_ff @(posedge clk, negedge reset_n)
  if (!reset_n)  button_ps <= IDLE;
  else           button_ps <= button_ns;

always_comb begin
  button_ns = XX; //default value
  button_true = 1'b0;
  case(button_ps)
    IDLE   :  if(all_ones) button_ns = PUSHED;
              else         button_ns = IDLE;
    PUSHED :  begin        button_ns = WAIT;
              button_true = 1'b1;
              end
    WAIT   :  if(all_zeros) button_ns = IDLE;
              else          button_ns = WAIT;
  endcase
end

endmodule
