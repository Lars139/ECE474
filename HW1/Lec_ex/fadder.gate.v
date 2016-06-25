
module fadder ( a, b, cin, sum_out, c_out );
  input a, b, cin;
  output sum_out, c_out;
  wire   n2;

  XOR2X1 U4 ( .IN1(cin), .IN2(n2), .Q(sum_out) );
  AO22X1 U5 ( .IN1(a), .IN2(b), .IN3(cin), .IN4(n2), .Q(c_out) );
  XOR2X1 U6 ( .IN1(a), .IN2(b), .Q(n2) );
endmodule

