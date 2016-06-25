
module alu_DW01_addsub_0 ( A, B, CI, ADD_SUB, SUM, CO );
  input [8:0] A;
  input [8:0] B;
  output [8:0] SUM;
  input CI, ADD_SUB;
  output CO;

  wire   [9:0] carry;
  wire   [8:0] B_AS;
  assign carry[0] = ADD_SUB;

  XOR3X1 U1_8 ( .IN1(A[8]), .IN2(carry[0]), .IN3(carry[8]), .Q(SUM[8]) );
  FADDX1 U1_7 ( .A(A[7]), .B(B_AS[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  FADDX1 U1_6 ( .A(A[6]), .B(B_AS[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  FADDX1 U1_5 ( .A(A[5]), .B(B_AS[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  FADDX1 U1_4 ( .A(A[4]), .B(B_AS[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  FADDX1 U1_3 ( .A(A[3]), .B(B_AS[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  FADDX1 U1_2 ( .A(A[2]), .B(B_AS[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  FADDX1 U1_1 ( .A(A[1]), .B(B_AS[1]), .CI(carry[1]), .CO(carry[2]), .S(SUM[1]) );
  FADDX1 U1_0 ( .A(A[0]), .B(B_AS[0]), .CI(carry[0]), .CO(carry[1]), .S(SUM[0]) );
  XOR2X1 U1 ( .IN1(B[7]), .IN2(carry[0]), .Q(B_AS[7]) );
  XOR2X1 U2 ( .IN1(B[6]), .IN2(carry[0]), .Q(B_AS[6]) );
  XOR2X1 U3 ( .IN1(B[5]), .IN2(carry[0]), .Q(B_AS[5]) );
  XOR2X1 U4 ( .IN1(B[4]), .IN2(carry[0]), .Q(B_AS[4]) );
  XOR2X1 U5 ( .IN1(B[3]), .IN2(carry[0]), .Q(B_AS[3]) );
  XOR2X1 U6 ( .IN1(B[2]), .IN2(carry[0]), .Q(B_AS[2]) );
  XOR2X1 U7 ( .IN1(B[1]), .IN2(carry[0]), .Q(B_AS[1]) );
  XOR2X1 U8 ( .IN1(B[0]), .IN2(carry[0]), .Q(B_AS[0]) );
endmodule


module alu ( in_a, in_b, opcode, alu_out, alu_zero, alu_carry );
  input [7:0] in_a;
  input [7:0] in_b;
  input [3:0] opcode;
  output [7:0] alu_out;
  output alu_zero, alu_carry;
  wire   N78, N79, N80, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90, N91,
         N92, N93, N94, N95, N96, N97, N98, N99, N100, N101, N102, N103, N104,
         N105, N106, N107, N108, N109, N110, \U3/U1/Z_0 , \U3/U1/Z_1 ,
         \U3/U1/Z_2 , \U3/U1/Z_3 , \U3/U1/Z_4 , \U3/U1/Z_5 , \U3/U1/Z_6 ,
         \U3/U1/Z_7 , \U3/U2/Z_0 , \U3/U2/Z_1 , \U3/U2/Z_2 , \U3/U2/Z_3 ,
         \U3/U2/Z_4 , \U3/U2/Z_5 , \U3/U2/Z_6 , \U3/U2/Z_7 , \U3/U3/Z_0 , n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129;

  alu_DW01_addsub_0 r30 ( .A({n129, \U3/U1/Z_7 , \U3/U1/Z_6 , \U3/U1/Z_5 , 
        \U3/U1/Z_4 , \U3/U1/Z_3 , \U3/U1/Z_2 , \U3/U1/Z_1 , \U3/U1/Z_0 }), .B(
        {1'b0, \U3/U2/Z_7 , \U3/U2/Z_6 , \U3/U2/Z_5 , \U3/U2/Z_4 , \U3/U2/Z_3 , 
        \U3/U2/Z_2 , \U3/U2/Z_1 , \U3/U2/Z_0 }), .CI(1'b0), .ADD_SUB(
        \U3/U3/Z_0 ), .SUM({N86, N85, N84, N83, N82, N81, N80, N79, N78}) );
  MUX41X1 U85 ( .IN1(n76), .IN3(n74), .IN2(n75), .IN4(in_a[2]), .S0(opcode[2]), 
        .S1(opcode[3]), .Q(alu_out[2]) );
  MUX21X1 U86 ( .IN1(N80), .IN2(in_a[2]), .S(n65), .Q(n76) );
  MUX41X1 U87 ( .IN1(N80), .IN3(N92), .IN2(N100), .IN4(N108), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n74) );
  MUX41X1 U88 ( .IN1(in_a[3]), .IN3(n126), .IN2(in_a[1]), .IN4(N80), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n75) );
  MUX41X1 U89 ( .IN1(n88), .IN3(n86), .IN2(n87), .IN4(in_a[6]), .S0(opcode[2]), 
        .S1(opcode[3]), .Q(alu_out[6]) );
  MUX21X1 U90 ( .IN1(N84), .IN2(in_a[6]), .S(n65), .Q(n88) );
  MUX41X1 U91 ( .IN1(N84), .IN3(N88), .IN2(N96), .IN4(N104), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n86) );
  MUX41X1 U92 ( .IN1(in_a[7]), .IN3(n122), .IN2(in_a[5]), .IN4(N84), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n87) );
  MUX41X1 U93 ( .IN1(n79), .IN3(n77), .IN2(n78), .IN4(in_a[3]), .S0(opcode[2]), 
        .S1(opcode[3]), .Q(alu_out[3]) );
  MUX21X1 U94 ( .IN1(N81), .IN2(in_a[3]), .S(n65), .Q(n79) );
  MUX41X1 U95 ( .IN1(N81), .IN3(N91), .IN2(N99), .IN4(N107), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n77) );
  MUX41X1 U96 ( .IN1(in_a[4]), .IN3(n125), .IN2(in_a[2]), .IN4(N81), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n78) );
  MUX41X1 U97 ( .IN1(n93), .IN3(n89), .IN2(n92), .IN4(in_a[7]), .S0(opcode[2]), 
        .S1(opcode[3]), .Q(alu_out[7]) );
  MUX21X1 U98 ( .IN1(N85), .IN2(in_a[7]), .S(n65), .Q(n93) );
  MUX21X1 U99 ( .IN1(n91), .IN2(n90), .S(opcode[0]), .Q(n92) );
  MUX41X1 U100 ( .IN1(N85), .IN3(N87), .IN2(N95), .IN4(N103), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n89) );
  MUX41X1 U101 ( .IN1(n70), .IN3(n66), .IN2(n69), .IN4(in_a[0]), .S0(opcode[2]), .S1(opcode[3]), .Q(alu_out[0]) );
  MUX21X1 U102 ( .IN1(N78), .IN2(in_a[0]), .S(n65), .Q(n70) );
  MUX21X1 U103 ( .IN1(n67), .IN2(n68), .S(opcode[0]), .Q(n69) );
  MUX41X1 U104 ( .IN1(N78), .IN3(N94), .IN2(N102), .IN4(N110), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n66) );
  MUX41X1 U105 ( .IN1(n82), .IN3(n80), .IN2(n81), .IN4(in_a[4]), .S0(opcode[2]), .S1(opcode[3]), .Q(alu_out[4]) );
  MUX21X1 U106 ( .IN1(N82), .IN2(in_a[4]), .S(n65), .Q(n82) );
  MUX41X1 U107 ( .IN1(N82), .IN3(N90), .IN2(N98), .IN4(N106), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n80) );
  MUX41X1 U108 ( .IN1(in_a[5]), .IN3(n124), .IN2(in_a[3]), .IN4(N82), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n81) );
  MUX41X1 U109 ( .IN1(n73), .IN3(n71), .IN2(n72), .IN4(in_a[1]), .S0(opcode[2]), .S1(opcode[3]), .Q(alu_out[1]) );
  MUX21X1 U110 ( .IN1(N79), .IN2(in_a[1]), .S(n65), .Q(n73) );
  MUX41X1 U111 ( .IN1(N79), .IN3(N93), .IN2(N101), .IN4(N109), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n71) );
  MUX41X1 U112 ( .IN1(in_a[2]), .IN3(n127), .IN2(in_a[0]), .IN4(N79), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n72) );
  MUX41X1 U113 ( .IN1(n85), .IN3(n83), .IN2(n84), .IN4(in_a[5]), .S0(opcode[2]), .S1(opcode[3]), .Q(alu_out[5]) );
  MUX21X1 U114 ( .IN1(N83), .IN2(in_a[5]), .S(n65), .Q(n85) );
  MUX41X1 U115 ( .IN1(N83), .IN3(N89), .IN2(N97), .IN4(N105), .S0(opcode[0]), 
        .S1(opcode[1]), .Q(n83) );
  MUX41X1 U116 ( .IN1(in_a[6]), .IN3(n123), .IN2(in_a[4]), .IN4(N83), .S0(
        opcode[1]), .S1(opcode[0]), .Q(n84) );
  AND2X1 U117 ( .IN1(opcode[1]), .IN2(n121), .Q(n91) );
  AND2X1 U118 ( .IN1(N78), .IN2(opcode[1]), .Q(n68) );
  MUX21X1 U119 ( .IN1(in_a[1]), .IN2(n128), .S(opcode[1]), .Q(n67) );
  MUX21X1 U120 ( .IN1(in_a[6]), .IN2(N85), .S(opcode[1]), .Q(n90) );
  NOR2X0 U121 ( .IN1(opcode[0]), .IN2(opcode[1]), .QN(n65) );
  NOR2X0 U122 ( .IN1(n94), .IN2(n95), .QN(alu_zero) );
  OR4X1 U123 ( .IN1(alu_out[1]), .IN2(alu_out[0]), .IN3(alu_out[3]), .IN4(
        alu_out[2]), .Q(n95) );
  OR4X1 U124 ( .IN1(alu_out[5]), .IN2(alu_out[4]), .IN3(alu_out[7]), .IN4(
        alu_out[6]), .Q(n94) );
  NAND2X0 U125 ( .IN1(n96), .IN2(n97), .QN(alu_carry) );
  NAND4X0 U126 ( .IN1(opcode[3]), .IN2(opcode[0]), .IN3(n98), .IN4(in_a[7]), 
        .QN(n97) );
  NOR2X0 U127 ( .IN1(opcode[2]), .IN2(opcode[1]), .QN(n98) );
  NAND2X0 U128 ( .IN1(N86), .IN2(n99), .QN(n96) );
  OR2X1 U129 ( .IN1(n100), .IN2(n129), .Q(n99) );
  NOR2X0 U130 ( .IN1(n101), .IN2(n102), .QN(\U3/U2/Z_7 ) );
  NOR2X0 U131 ( .IN1(n101), .IN2(n103), .QN(\U3/U2/Z_6 ) );
  NOR2X0 U132 ( .IN1(n101), .IN2(n104), .QN(\U3/U2/Z_5 ) );
  NOR2X0 U133 ( .IN1(n101), .IN2(n105), .QN(\U3/U2/Z_4 ) );
  NOR2X0 U134 ( .IN1(n101), .IN2(n106), .QN(\U3/U2/Z_3 ) );
  NOR2X0 U135 ( .IN1(n101), .IN2(n107), .QN(\U3/U2/Z_2 ) );
  NOR2X0 U136 ( .IN1(n101), .IN2(n108), .QN(\U3/U2/Z_1 ) );
  NAND3X0 U137 ( .IN1(n109), .IN2(n110), .IN3(n111), .QN(\U3/U2/Z_0 ) );
  MUX21X1 U138 ( .IN1(n112), .IN2(n113), .S(opcode[1]), .Q(n111) );
  NAND2X0 U139 ( .IN1(n114), .IN2(opcode[0]), .QN(n113) );
  NAND3X0 U140 ( .IN1(n115), .IN2(n116), .IN3(opcode[2]), .QN(n112) );
  OR2X1 U141 ( .IN1(n117), .IN2(n101), .Q(n109) );
  NAND2X0 U142 ( .IN1(n114), .IN2(n118), .QN(n101) );
  XNOR2X1 U143 ( .IN1(opcode[1]), .IN2(n115), .Q(n118) );
  MUX21X1 U144 ( .IN1(n100), .IN2(n129), .S(n121), .Q(\U3/U1/Z_7 ) );
  MUX21X1 U145 ( .IN1(n100), .IN2(n129), .S(n122), .Q(\U3/U1/Z_6 ) );
  MUX21X1 U146 ( .IN1(n100), .IN2(n129), .S(n123), .Q(\U3/U1/Z_5 ) );
  MUX21X1 U147 ( .IN1(n100), .IN2(n129), .S(n124), .Q(\U3/U1/Z_4 ) );
  MUX21X1 U148 ( .IN1(n100), .IN2(n129), .S(n125), .Q(\U3/U1/Z_3 ) );
  MUX21X1 U149 ( .IN1(n100), .IN2(n129), .S(n126), .Q(\U3/U1/Z_2 ) );
  MUX21X1 U150 ( .IN1(n100), .IN2(n129), .S(n127), .Q(\U3/U1/Z_1 ) );
  MUX21X1 U151 ( .IN1(n100), .IN2(n129), .S(n128), .Q(\U3/U1/Z_0 ) );
  INVX0 U152 ( .IN(n110), .QN(n129) );
  NAND4X0 U153 ( .IN1(opcode[3]), .IN2(opcode[1]), .IN3(opcode[0]), .IN4(n119), 
        .QN(n110) );
  AO21X1 U154 ( .IN1(n114), .IN2(opcode[0]), .IN3(\U3/U3/Z_0 ), .Q(n100) );
  AND3X1 U155 ( .IN1(n115), .IN2(n116), .IN3(n120), .Q(\U3/U3/Z_0 ) );
  XNOR2X1 U156 ( .IN1(n119), .IN2(opcode[1]), .Q(n120) );
  INVX0 U157 ( .IN(opcode[2]), .QN(n119) );
  INVX0 U158 ( .IN(opcode[3]), .QN(n116) );
  INVX0 U159 ( .IN(opcode[0]), .QN(n115) );
  NOR2X0 U160 ( .IN1(opcode[2]), .IN2(opcode[3]), .QN(n114) );
  NOR2X0 U161 ( .IN1(n125), .IN2(n106), .QN(N99) );
  NOR2X0 U162 ( .IN1(n124), .IN2(n105), .QN(N98) );
  NOR2X0 U163 ( .IN1(n123), .IN2(n104), .QN(N97) );
  NOR2X0 U164 ( .IN1(n122), .IN2(n103), .QN(N96) );
  NOR2X0 U165 ( .IN1(n121), .IN2(n102), .QN(N95) );
  NAND2X0 U166 ( .IN1(n117), .IN2(n128), .QN(N94) );
  NAND2X0 U167 ( .IN1(n108), .IN2(n127), .QN(N93) );
  NAND2X0 U168 ( .IN1(n107), .IN2(n126), .QN(N92) );
  NAND2X0 U169 ( .IN1(n106), .IN2(n125), .QN(N91) );
  INVX0 U170 ( .IN(in_a[3]), .QN(n125) );
  NAND2X0 U171 ( .IN1(n105), .IN2(n124), .QN(N90) );
  INVX0 U172 ( .IN(in_a[4]), .QN(n124) );
  NAND2X0 U173 ( .IN1(n104), .IN2(n123), .QN(N89) );
  INVX0 U174 ( .IN(in_a[5]), .QN(n123) );
  NAND2X0 U175 ( .IN1(n103), .IN2(n122), .QN(N88) );
  INVX0 U176 ( .IN(in_a[6]), .QN(n122) );
  NAND2X0 U177 ( .IN1(n102), .IN2(n121), .QN(N87) );
  INVX0 U178 ( .IN(in_a[7]), .QN(n121) );
  XNOR2X1 U179 ( .IN1(n117), .IN2(in_a[0]), .Q(N110) );
  XNOR2X1 U180 ( .IN1(n108), .IN2(in_a[1]), .Q(N109) );
  XNOR2X1 U181 ( .IN1(n107), .IN2(in_a[2]), .Q(N108) );
  XNOR2X1 U182 ( .IN1(n106), .IN2(in_a[3]), .Q(N107) );
  INVX0 U183 ( .IN(in_b[3]), .QN(n106) );
  XNOR2X1 U184 ( .IN1(n105), .IN2(in_a[4]), .Q(N106) );
  INVX0 U185 ( .IN(in_b[4]), .QN(n105) );
  XNOR2X1 U186 ( .IN1(n104), .IN2(in_a[5]), .Q(N105) );
  INVX0 U187 ( .IN(in_b[5]), .QN(n104) );
  XNOR2X1 U188 ( .IN1(n103), .IN2(in_a[6]), .Q(N104) );
  INVX0 U189 ( .IN(in_b[6]), .QN(n103) );
  XNOR2X1 U190 ( .IN1(n102), .IN2(in_a[7]), .Q(N103) );
  INVX0 U191 ( .IN(in_b[7]), .QN(n102) );
  NOR2X0 U192 ( .IN1(n128), .IN2(n117), .QN(N102) );
  INVX0 U193 ( .IN(in_b[0]), .QN(n117) );
  INVX0 U194 ( .IN(in_a[0]), .QN(n128) );
  NOR2X0 U195 ( .IN1(n127), .IN2(n108), .QN(N101) );
  INVX0 U196 ( .IN(in_b[1]), .QN(n108) );
  INVX0 U197 ( .IN(in_a[1]), .QN(n127) );
  NOR2X0 U198 ( .IN1(n126), .IN2(n107), .QN(N100) );
  INVX0 U199 ( .IN(in_b[2]), .QN(n107) );
  INVX0 U200 ( .IN(in_a[2]), .QN(n126) );
endmodule

