module adder8(
  input  [7:0]  a,       //data in a
  input  [7:0]  b,       //data in b
  output [7:0] sum_out,  //sum output
  output c_out           //carry output
  );


//declaring internal wires
	wire [6:0] c;	// c is for c_out for each adder


//seriously, I think there must be a better way of doing this
fadder adder_0(
	.a	( a[0] ),
	.b	( b[0] ),
	.cin	(  0   ),	    //Intensionally left blank
	.sum_out( sum_out[0] ),
	.c_out	( c[0] )
);

fadder adder_1(
	.a	( a[1] ),
	.b	( b[1] ),
	.cin	( c[0] ),	   
	.sum_out( sum_out[1] ),
	.c_out	( c[1] )
);

fadder adder_2(
	.a	( a[2] ),
	.b	( b[2] ),
	.cin	( c[1] ),	   
	.sum_out( sum_out[2] ),
	.c_out	( c[2] )
);

fadder adder_3(
	.a	( a[3] ),
	.b	( b[3] ),
	.cin	( c[2] ),	   
	.sum_out( sum_out[3] ),
	.c_out	( c[3] )
);

fadder adder_4(
	.a	( a[4] ),
	.b	( b[4] ),
	.cin	( c[3] ),	   
	.sum_out( sum_out[4] ),
	.c_out	( c[4] )
);

fadder adder_5(
	.a	( a[5] ),
	.b	( b[5] ),
	.cin	( c[4] ),	   
	.sum_out( sum_out[5] ),
	.c_out	( c[5] )
);

fadder adder_6(
	.a	( a[6] ),
	.b	( b[6] ),
	.cin	( c[5] ),	   
	.sum_out( sum_out[6] ),
	.c_out	( c[6] )
);

fadder adder_7(
	.a	( a[7] ),
	.b	( b[7] ),
	.cin	( c[6] ),	   
	.sum_out( sum_out[7] ),
	.c_out	( c_out )
);


endmodule
