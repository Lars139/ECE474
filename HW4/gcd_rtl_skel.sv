//gdc skeleton code

module gcd( input [31:0] a_in,
      input [31:0] b_in,
      input start,
      input reset_n,
      input clk,
      output reg [31:0] result,
      output reg done);

//declare the internal 32-bit register busses

reg [31:0] reg_a; 
reg [31:0] reg_b;

//declare the enumerated values for register a mux select
enum reg [1:0] {a_swp_b, a_sub_b, hold, ld_in} mux_sig_a, mux_sig_b; 
//NOTE: Potentially can cuase timing isuue. b/c mux_sig_a, mux_sig_b
//uses the same signals name

//create reg_a and its mux
always_ff @(posedge clk, negedge reset_n) 
begin
  if (!reset_n)//Reseting
  begin
    reg_a <= a_in;
  end//if(reset) ends here
  else  //if not reset 

  begin 
    if ( !done ) //If this is not done
    begin
      case (mux_sig_a)
      a_swp_b: //If A<B then swap number
        //NOTE: This swap method can be done in 1 clk-cyc
        reg_a <= reg_b;

      a_sub_b: //Input from A-B
        reg_a <= reg_a - reg_b;

      hold: //A holds its value
        reg_a <= reg_a;

      ld_in: //Take the input
        reg_a <= a_in;
      endcase   
    end // (!done) ends here

    else //If it is done, result = A and A holds its value
    begin
      reg_a <= reg_a;
    end
  end // if(!reset) ends here 


end //end of reg_a

//create reg_b and its mux
always_ff @(posedge clk, negedge reset_n) 
begin
  if (!reset_n) //Reseting
  begin
    reg_b <= b_in;
  end


  else //Not reseting, operates

  begin 
    if ( !done ) //If this is not done
    begin
      case (mux_sig_b)
      a_swp_b: //If A<B then swap number
        reg_b <= reg_a ; //See reg_a 
        
      a_sub_b: //B holds its value while A is fetching (A-B)
        reg_b <= reg_b;

      hold: //B holds its value
        reg_b <= reg_b;

      ld_in: //Take the input
        reg_b <= b_in;
      endcase
    end // (!done) ends here
    else //If it is done, B holds its value
      reg_b <= reg_b;

  end //else (reset_n) ends here


end //end of reg_b

//////////////////////////////// CONSTROL SECTION //////////////////////////

//create the combinatorial signals that will steer the state machine 
assign a_lt_b = (reg_a < reg_b); 
assign b_neq_zero = reg_b ? 1:0; 

//create the output signal from the internal register output
assign result = reg_a;

//declare the enumerated values for gcd_sm
//declare the enumberate values for the present state
//declare the enumberate values for the next state
enum reg [1:0] {idle = 2'b00, load = 2'b01, run = 2'b10, finish = 2'b11} gcd_ps, gcd_ns;


//build the present state storage for the state machine
always_ff @(posedge clk, negedge reset_n)
//Initialize the first state to be idle
  if (!reset_n) gcd_ps <= idle; //present state store the present state
  else 
     gcd_ps <= gcd_ns;

//build the next state combo logic for the state machine
always_comb begin
  gcd_ns = idle;       //default _ns assignment
  case (gcd_ps) 
    idle: 
      if(start)  gcd_ns = load;
      else gcd_ns = idle;
      //end idle

    load:
        gcd_ns = run;
      //end load

    run:
      begin
        if( !b_neq_zero )
          gcd_ns = finish;
        else
          gcd_ns = run;
      end
      //end run

    finish: gcd_ns = idle;
      //end finish
  endcase           
end
//end comb   

//form the state machine mealy outputs here
always_comb begin
  mux_sig_a = hold;  //default assignments
  mux_sig_b = hold;
  done = 1'b0;
  case (gcd_ps) 
    idle:
      begin
        mux_sig_a = hold;
        mux_sig_b = hold;
	done = 1'b0;
      end 
      //end idle

    load:
      begin
        mux_sig_a = ld_in;
        mux_sig_b = ld_in;
      end 
      //end load

    run:
      begin
        // b_neq_zero is a flag here. 
        if(b_neq_zero)
        begin
          if(a_lt_b) //if A<B
          begin
            mux_sig_a = a_swp_b;
            mux_sig_b = a_swp_b;
          end
          else // if A>=B
          begin
            mux_sig_a = a_sub_b;
            mux_sig_b = a_sub_b;
          end

        end // (b_neq_zero) ends here
        else //B==0 
	    done = 1'b1;
      end
      //end run

    finish: 
      begin
        mux_sig_a = hold;
        mux_sig_b = hold;
      end 
      //end finish
  endcase         
end
//end comb   

//that's all folks! Piece of cake.

endmodule
