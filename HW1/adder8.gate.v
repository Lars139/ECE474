
module fadder_0 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_1 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_2 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_3 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_4 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_5 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_6 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module fadder_7 ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n1;

  XOR2X1 U1 ( .IN1(cin), .IN2(n1), .Q(sum_out) );
  AO22X1 U2 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n1), .Q(c_out) );
  XOR2X1 U3 ( .IN1(a), .IN2(b), .Q(n1) );
endmodule


module adder8 ( a, b, sum_out, c_out );
  input [7:0] a;
  input [7:0] b;
  output [7:0] sum_out;
  output c_out;

  wire   [6:0] c;

  fadder_0 adder_0 ( .a(a[0]), .b(b[0]), .cin(1'b0), .sum_out(sum_out[0]), 
        .c_out(c[0]) );
  fadder_7 adder_1 ( .a(a[1]), .b(b[1]), .cin(c[0]), .sum_out(sum_out[1]), 
        .c_out(c[1]) );
  fadder_6 adder_2 ( .a(a[2]), .b(b[2]), .cin(c[1]), .sum_out(sum_out[2]), 
        .c_out(c[2]) );
  fadder_5 adder_3 ( .a(a[3]), .b(b[3]), .cin(c[2]), .sum_out(sum_out[3]), 
        .c_out(c[3]) );
  fadder_4 adder_4 ( .a(a[4]), .b(b[4]), .cin(c[3]), .sum_out(sum_out[4]), 
        .c_out(c[4]) );
  fadder_3 adder_5 ( .a(a[5]), .b(b[5]), .cin(c[4]), .sum_out(sum_out[5]), 
        .c_out(c[5]) );
  fadder_2 adder_6 ( .a(a[6]), .b(b[6]), .cin(c[5]), .sum_out(sum_out[6]), 
        .c_out(c[6]) );
  fadder_1 adder_7 ( .a(a[7]), .b(b[7]), .cin(c[6]), .sum_out(sum_out[7]), 
        .c_out(c_out) );
endmodule

