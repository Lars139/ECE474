module tas (
       input  clk_50,               // 50Mhz input clock
       input  clk_2,                // 2Mhz input clock
       input  reset_n,              // reset async active low
       input  serial_data,          // serial input data
       input  data_ena,             // serial data enable
       output ram_wr_n,             // write strobe to ram
       output [7:0] ram_data,       // ram data
       output [10:0] ram_addr       // ram address
       );

//-------------------- INTERNAL VARIABLES ------------------//
//-------------------------------------------------- shift_reg 
//output from bit shift (serial to parallel)
reg [7:0] to_fifo_data;

//flag indicating that the byte is complete
reg byte_assembled;

//flag if the header is A5 or C3
reg a5_or_c3;

//------------------------------------------------- ctrl_50MHz
//wr_to
reg wr_fifo;

//------------------------------------------------- fifo
//read fifo
reg rd_fifo;

//flag if FIFO is empty
reg not_empty;

//the output data from FIFO
reg [7:0] data;

//------------------------------------------------- ctrl_2MHz
//select zero flag for clearing the average
reg zero_sel;
reg reg_out;

//------------------------------------------------- averager
reg avg_ena;

//------------------ MODULE INSTANTIATE --------------------//
ctrl_50MHz ctrl_50MHz_0(.*);
shift_reg shift_reg_0(.*);
fifo fifo_0(.*);
ctrl_2MHz ctrl_2MHz_0(.*);
averager averager_0(.*);

//------------------ CHECK FOR HEADER ----------------------//
always_comb begin
	if(byte_assembled && (to_fifo_data == 8'ha5 || to_fifo_data == 8'hc3 ))
		a5_or_c3 = 1;
	else
		a5_or_c3 = 0;
end

endmodule
