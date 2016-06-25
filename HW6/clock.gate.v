
module clock ( reset_n, clk_1sec, clk_1ms, mil_time, segment_data, 
        digit_select );
  output [6:0] segment_data;
  output [2:0] digit_select;
  input reset_n, clk_1sec, clk_1ms, mil_time;
  wire   \sec_cntr_0/N16 , \sec_cntr_0/N15 , \sec_cntr_0/N14 ,
         \sec_cntr_0/N13 , \sec_cntr_0/N12 , \sec_cntr_0/N9 , \sec_cntr_0/N8 ,
         \sec_cntr_0/N7 , \sec_cntr_0/N6 , \sec_cntr_0/cntr[0] ,
         \sec_cntr_0/cntr[1] , \sec_cntr_0/cntr[2] , \sec_cntr_0/cntr[3] ,
         \sec_cntr_0/cntr[4] , \sec_cntr_0/cntr[5] , \min_cntr_0/n43 ,
         \min_cntr_0/n42 , \min_cntr_0/N51 , \min_cntr_0/N19 ,
         \min_cntr_0/N18 , \min_cntr_0/N17 , \min_cntr_0/N16 ,
         \min_cntr_0/N15 , \min_cntr_0/N14 , \min_cntr_0/N12 ,
         \min_cntr_0/N11 , \min_cntr_0/N10 , \min_cntr_0/N9 ,
         \min_cntr_0/cntr[1] , \min_cntr_0/cntr[2] , \min_cntr_0/cntr[3] ,
         \min_cntr_0/cntr[4] , \hr_cntr_0/n38 , \hr_cntr_0/n37 ,
         \hr_cntr_0/N34 , \hr_cntr_0/N33 , \hr_cntr_0/N30 , \hr_cntr_0/N22 ,
         \hr_cntr_0/N21 , \hr_cntr_0/N20 , \hr_cntr_0/N19 , \hr_cntr_0/N18 ,
         \hr_cntr_0/N17 , \hr_cntr_0/N15 , \hr_cntr_0/N14 , \hr_cntr_0/N13 ,
         \hr_cntr_0/N12 , \hr_cntr_0/cntr[1] , \hr_cntr_0/cntr[2] ,
         \hr_cntr_0/cntr[3] , \hr_cntr_0/cntr[4] , \hr_cntr_0/cntr[5] ,
         \digit_sel_0/n16 , \digit_sel_0/n6 , \digit_sel_0/n5 ,
         \digit_sel_0/n4 , \digit_sel_0/N54 , \digit_sel_0/N53 ,
         \digit_sel_0/N52 , \digit_sel_0/N51 , \digit_sel_0/N50 ,
         \digit_sel_0/N49 , \digit_sel_0/N48 , \digit_sel_0/ds_ns[0] ,
         \digit_sel_0/ds_ns[1] , \digit_sel_0/ds_ns[2] ,
         \hr_cntr_0/sub_92/carry[5] , \hr_cntr_0/add_42/carry[5] ,
         \hr_cntr_0/add_42/carry[4] , \hr_cntr_0/add_42/carry[3] ,
         \hr_cntr_0/add_42/carry[2] , \min_cntr_0/add_35/carry[5] ,
         \min_cntr_0/add_35/carry[4] , \min_cntr_0/add_35/carry[3] ,
         \min_cntr_0/add_35/carry[2] , \sec_cntr_0/add_25/carry[5] ,
         \sec_cntr_0/add_25/carry[4] , \sec_cntr_0/add_25/carry[3] ,
         \sec_cntr_0/add_25/carry[2] , n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148;

  DFFARX1 \min_cntr_0/cntr_reg[5]  ( .D(\min_cntr_0/N19 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(n5), .QN(n148) );
  LATCHX1 \digit_sel_0/b_dec_7seg_reg[0]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/N51 ), .Q(n6), .QN(n140) );
  LATCHX1 \digit_sel_0/b_dec_7seg_reg[1]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/N52 ), .Q(n1), .QN(n139) );
  LATCHX1 \digit_sel_0/b_dec_7seg_reg[2]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/N53 ), .Q(n3), .QN(n138) );
  LATCHX1 \digit_sel_0/b_dec_7seg_reg[3]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/N54 ), .Q(n8), .QN(n137) );
  DFFASX1 \digit_sel_0/ds_ps_reg[2]  ( .D(\digit_sel_0/ds_ns[2] ), .CLK(
        clk_1ms), .SETB(reset_n), .Q(n2), .QN(\digit_sel_0/n4 ) );
  DFFASX1 \digit_sel_0/ds_ps_reg[1]  ( .D(\digit_sel_0/ds_ns[1] ), .CLK(
        clk_1ms), .SETB(reset_n), .QN(\digit_sel_0/n5 ) );
  DFFASX1 \digit_sel_0/ds_ps_reg[0]  ( .D(\digit_sel_0/ds_ns[0] ), .CLK(
        clk_1ms), .SETB(reset_n), .Q(n4), .QN(\digit_sel_0/n6 ) );
  DFFARX1 \min_cntr_0/cntr_reg[0]  ( .D(\min_cntr_0/N14 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\min_cntr_0/N51 ), .QN(n141) );
  DFFARX1 \hr_cntr_0/cntr_reg[0]  ( .D(\hr_cntr_0/N17 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\hr_cntr_0/N30 ), .QN(n144) );
  DFFARX1 \sec_cntr_0/cntr_reg[1]  ( .D(\sec_cntr_0/N12 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\sec_cntr_0/cntr[1] ), .QN(n136) );
  DFFARX1 \min_cntr_0/cntr_reg[4]  ( .D(\min_cntr_0/N18 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\min_cntr_0/cntr[4] ), .QN(n146) );
  DFFARX1 \min_cntr_0/cntr_reg[3]  ( .D(\min_cntr_0/N17 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\min_cntr_0/cntr[3] ), .QN(n147) );
  DFFARX1 \min_cntr_0/cntr_reg[2]  ( .D(\min_cntr_0/N16 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\min_cntr_0/cntr[2] ), .QN(\min_cntr_0/n42 ) );
  DFFARX1 \min_cntr_0/cntr_reg[1]  ( .D(\min_cntr_0/N15 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\min_cntr_0/cntr[1] ), .QN(\min_cntr_0/n43 ) );
  DFFARX1 \hr_cntr_0/cntr_reg[1]  ( .D(\hr_cntr_0/N18 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\hr_cntr_0/cntr[1] ), .QN(\hr_cntr_0/n38 ) );
  DFFARX1 \sec_cntr_0/cntr_reg[0]  ( .D(n7), .CLK(clk_1sec), .RSTB(reset_n), 
        .Q(\sec_cntr_0/cntr[0] ), .QN(n7) );
  DFFARX1 \sec_cntr_0/cntr_reg[5]  ( .D(\sec_cntr_0/N16 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\sec_cntr_0/cntr[5] ) );
  DFFARX1 \sec_cntr_0/cntr_reg[4]  ( .D(\sec_cntr_0/N15 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\sec_cntr_0/cntr[4] ) );
  DFFARX1 \sec_cntr_0/cntr_reg[3]  ( .D(\sec_cntr_0/N14 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\sec_cntr_0/cntr[3] ) );
  DFFARX1 \sec_cntr_0/cntr_reg[2]  ( .D(\sec_cntr_0/N13 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\sec_cntr_0/cntr[2] ) );
  DFFARX1 \hr_cntr_0/cntr_reg[2]  ( .D(\hr_cntr_0/N19 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\hr_cntr_0/cntr[2] ), .QN(\hr_cntr_0/n37 ) );
  DFFARX1 \hr_cntr_0/cntr_reg[3]  ( .D(\hr_cntr_0/N20 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\hr_cntr_0/cntr[3] ), .QN(n143) );
  DFFARX1 \hr_cntr_0/cntr_reg[5]  ( .D(\hr_cntr_0/N22 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\hr_cntr_0/cntr[5] ), .QN(n145) );
  DFFARX1 \hr_cntr_0/cntr_reg[4]  ( .D(\hr_cntr_0/N21 ), .CLK(clk_1sec), 
        .RSTB(reset_n), .Q(\hr_cntr_0/cntr[4] ), .QN(n142) );
  HADDX1 \min_cntr_0/add_35/U1_1_4  ( .A0(\min_cntr_0/cntr[4] ), .B0(
        \min_cntr_0/add_35/carry[4] ), .C1(\min_cntr_0/add_35/carry[5] ), .SO(
        \min_cntr_0/N12 ) );
  HADDX1 \sec_cntr_0/add_25/U1_1_3  ( .A0(\sec_cntr_0/cntr[3] ), .B0(
        \sec_cntr_0/add_25/carry[3] ), .C1(\sec_cntr_0/add_25/carry[4] ), .SO(
        \sec_cntr_0/N8 ) );
  HADDX1 \sec_cntr_0/add_25/U1_1_2  ( .A0(\sec_cntr_0/cntr[2] ), .B0(
        \sec_cntr_0/add_25/carry[2] ), .C1(\sec_cntr_0/add_25/carry[3] ), .SO(
        \sec_cntr_0/N7 ) );
  HADDX1 \hr_cntr_0/add_42/U1_1_3  ( .A0(\hr_cntr_0/cntr[3] ), .B0(
        \hr_cntr_0/add_42/carry[3] ), .C1(\hr_cntr_0/add_42/carry[4] ), .SO(
        \hr_cntr_0/N14 ) );
  HADDX1 \hr_cntr_0/add_42/U1_1_2  ( .A0(\hr_cntr_0/cntr[2] ), .B0(
        \hr_cntr_0/add_42/carry[2] ), .C1(\hr_cntr_0/add_42/carry[3] ), .SO(
        \hr_cntr_0/N13 ) );
  HADDX1 \sec_cntr_0/add_25/U1_1_1  ( .A0(\sec_cntr_0/cntr[1] ), .B0(
        \sec_cntr_0/cntr[0] ), .C1(\sec_cntr_0/add_25/carry[2] ), .SO(
        \sec_cntr_0/N6 ) );
  HADDX1 \min_cntr_0/add_35/U1_1_3  ( .A0(\min_cntr_0/cntr[3] ), .B0(
        \min_cntr_0/add_35/carry[3] ), .C1(\min_cntr_0/add_35/carry[4] ), .SO(
        \min_cntr_0/N11 ) );
  HADDX1 \hr_cntr_0/add_42/U1_1_1  ( .A0(\hr_cntr_0/cntr[1] ), .B0(
        \hr_cntr_0/N30 ), .C1(\hr_cntr_0/add_42/carry[2] ), .SO(
        \hr_cntr_0/N12 ) );
  HADDX1 \min_cntr_0/add_35/U1_1_2  ( .A0(\min_cntr_0/cntr[2] ), .B0(
        \min_cntr_0/add_35/carry[2] ), .C1(\min_cntr_0/add_35/carry[3] ), .SO(
        \min_cntr_0/N10 ) );
  HADDX1 \min_cntr_0/add_35/U1_1_1  ( .A0(\min_cntr_0/cntr[1] ), .B0(
        \min_cntr_0/N51 ), .C1(\min_cntr_0/add_35/carry[2] ), .SO(
        \min_cntr_0/N9 ) );
  HADDX1 \sec_cntr_0/add_25/U1_1_4  ( .A0(\sec_cntr_0/cntr[4] ), .B0(
        \sec_cntr_0/add_25/carry[4] ), .C1(\sec_cntr_0/add_25/carry[5] ), .SO(
        \sec_cntr_0/N9 ) );
  HADDX1 \hr_cntr_0/add_42/U1_1_4  ( .A0(\hr_cntr_0/cntr[4] ), .B0(
        \hr_cntr_0/add_42/carry[4] ), .C1(\hr_cntr_0/add_42/carry[5] ), .SO(
        \hr_cntr_0/N15 ) );
  LATCHX1 \digit_sel_0/b_dg_sel_reg[2]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/n16 ), .Q(digit_select[2]) );
  LATCHX1 \digit_sel_0/b_dg_sel_reg[0]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/N49 ), .Q(digit_select[0]) );
  LATCHX1 \digit_sel_0/b_dg_sel_reg[1]  ( .CLK(\digit_sel_0/N48 ), .D(
        \digit_sel_0/N50 ), .Q(digit_select[1]) );
  XOR2X1 U1 ( .IN1(n142), .IN2(n10), .Q(\hr_cntr_0/N34 ) );
  NAND2X0 U2 ( .IN1(n11), .IN2(n142), .QN(\hr_cntr_0/sub_92/carry[5] ) );
  INVX0 U3 ( .IN(n10), .QN(n11) );
  XOR2X1 U4 ( .IN1(\hr_cntr_0/cntr[2] ), .IN2(\hr_cntr_0/cntr[3] ), .Q(
        \hr_cntr_0/N33 ) );
  XOR2X1 U5 ( .IN1(\hr_cntr_0/cntr[5] ), .IN2(\hr_cntr_0/sub_92/carry[5] ), 
        .Q(n9) );
  AND2X1 U6 ( .IN1(\hr_cntr_0/cntr[2] ), .IN2(\hr_cntr_0/cntr[3] ), .Q(n10) );
  OAI221X1 U7 ( .IN1(n1), .IN2(n12), .IN3(n13), .IN4(n140), .IN5(n14), .QN(
        segment_data[6]) );
  NAND2X0 U8 ( .IN1(n15), .IN2(n14), .QN(segment_data[5]) );
  MUX21X1 U9 ( .IN1(n16), .IN2(n17), .S(n140), .Q(n15) );
  NAND2X0 U10 ( .IN1(n1), .IN2(n3), .QN(n17) );
  NAND3X0 U11 ( .IN1(n14), .IN2(n13), .IN3(n18), .QN(segment_data[4]) );
  NAND3X0 U12 ( .IN1(n140), .IN2(n1), .IN3(n138), .QN(n18) );
  OAI21X1 U13 ( .IN1(n1), .IN2(n12), .IN3(n19), .QN(segment_data[3]) );
  OA21X1 U14 ( .IN1(n6), .IN2(n138), .IN3(n20), .Q(n12) );
  NAND2X0 U15 ( .IN1(n16), .IN2(n140), .QN(segment_data[2]) );
  OA21X1 U16 ( .IN1(n1), .IN2(n138), .IN3(n13), .Q(n16) );
  NAND3X0 U17 ( .IN1(n14), .IN2(n20), .IN3(n21), .QN(segment_data[1]) );
  AO21X1 U18 ( .IN1(n140), .IN2(n3), .IN3(n139), .Q(n21) );
  NAND3X0 U19 ( .IN1(n138), .IN2(n6), .IN3(n137), .QN(n20) );
  NAND2X0 U20 ( .IN1(n19), .IN2(n22), .QN(segment_data[0]) );
  NAND3X0 U21 ( .IN1(n137), .IN2(n138), .IN3(n139), .QN(n22) );
  AND3X1 U22 ( .IN1(n14), .IN2(n13), .IN3(n23), .Q(n19) );
  NAND3X0 U23 ( .IN1(n1), .IN2(n3), .IN3(n6), .QN(n23) );
  NAND2X0 U24 ( .IN1(n8), .IN2(n1), .QN(n13) );
  NAND2X0 U25 ( .IN1(n8), .IN2(n3), .QN(n14) );
  NOR2X0 U26 ( .IN1(n24), .IN2(n25), .QN(\sec_cntr_0/N16 ) );
  XNOR2X1 U27 ( .IN1(\sec_cntr_0/cntr[5] ), .IN2(\sec_cntr_0/add_25/carry[5] ), 
        .Q(n25) );
  AND2X1 U28 ( .IN1(\sec_cntr_0/N9 ), .IN2(n26), .Q(\sec_cntr_0/N15 ) );
  AND2X1 U29 ( .IN1(\sec_cntr_0/N8 ), .IN2(n26), .Q(\sec_cntr_0/N14 ) );
  AND2X1 U30 ( .IN1(\sec_cntr_0/N7 ), .IN2(n26), .Q(\sec_cntr_0/N13 ) );
  AND2X1 U31 ( .IN1(\sec_cntr_0/N6 ), .IN2(n26), .Q(\sec_cntr_0/N12 ) );
  MUX21X1 U32 ( .IN1(n27), .IN2(n28), .S(n148), .Q(\min_cntr_0/N19 ) );
  NOR2X0 U33 ( .IN1(n29), .IN2(n30), .QN(n28) );
  AO21X1 U34 ( .IN1(n31), .IN2(n30), .IN3(n26), .Q(n27) );
  INVX0 U35 ( .IN(\min_cntr_0/add_35/carry[5] ), .QN(n30) );
  AO22X1 U36 ( .IN1(n26), .IN2(\min_cntr_0/cntr[4] ), .IN3(\min_cntr_0/N12 ), 
        .IN4(n31), .Q(\min_cntr_0/N18 ) );
  AO22X1 U37 ( .IN1(n26), .IN2(\min_cntr_0/cntr[3] ), .IN3(\min_cntr_0/N11 ), 
        .IN4(n31), .Q(\min_cntr_0/N17 ) );
  AO22X1 U38 ( .IN1(n26), .IN2(\min_cntr_0/cntr[2] ), .IN3(\min_cntr_0/N10 ), 
        .IN4(n31), .Q(\min_cntr_0/N16 ) );
  AO22X1 U39 ( .IN1(n26), .IN2(\min_cntr_0/cntr[1] ), .IN3(\min_cntr_0/N9 ), 
        .IN4(n31), .Q(\min_cntr_0/N15 ) );
  MUX21X1 U40 ( .IN1(n26), .IN2(n31), .S(n141), .Q(\min_cntr_0/N14 ) );
  INVX0 U41 ( .IN(n29), .QN(n31) );
  NAND2X0 U42 ( .IN1(n24), .IN2(n32), .QN(n29) );
  MUX21X1 U43 ( .IN1(n33), .IN2(n34), .S(n145), .Q(\hr_cntr_0/N22 ) );
  AND2X1 U44 ( .IN1(\hr_cntr_0/add_42/carry[5] ), .IN2(n35), .Q(n34) );
  NAND2X0 U45 ( .IN1(n36), .IN2(\hr_cntr_0/add_42/carry[5] ), .QN(n33) );
  AO22X1 U46 ( .IN1(n32), .IN2(\hr_cntr_0/cntr[4] ), .IN3(\hr_cntr_0/N15 ), 
        .IN4(n35), .Q(\hr_cntr_0/N21 ) );
  AO22X1 U47 ( .IN1(n32), .IN2(\hr_cntr_0/cntr[3] ), .IN3(\hr_cntr_0/N14 ), 
        .IN4(n35), .Q(\hr_cntr_0/N20 ) );
  AO22X1 U48 ( .IN1(n32), .IN2(\hr_cntr_0/cntr[2] ), .IN3(\hr_cntr_0/N13 ), 
        .IN4(n35), .Q(\hr_cntr_0/N19 ) );
  AO22X1 U49 ( .IN1(n32), .IN2(\hr_cntr_0/cntr[1] ), .IN3(\hr_cntr_0/N12 ), 
        .IN4(n35), .Q(\hr_cntr_0/N18 ) );
  MUX21X1 U50 ( .IN1(n32), .IN2(n35), .S(n144), .Q(\hr_cntr_0/N17 ) );
  AND2X1 U51 ( .IN1(n36), .IN2(n37), .Q(n35) );
  NAND4X0 U52 ( .IN1(n145), .IN2(\hr_cntr_0/cntr[2] ), .IN3(n143), .IN4(n38), 
        .QN(n37) );
  NOR3X0 U53 ( .IN1(\hr_cntr_0/n38 ), .IN2(n142), .IN3(n144), .QN(n38) );
  INVX0 U54 ( .IN(n32), .QN(n36) );
  NAND4X0 U55 ( .IN1(n24), .IN2(\min_cntr_0/cntr[1] ), .IN3(\min_cntr_0/n42 ), 
        .IN4(n39), .QN(n32) );
  NOR4X0 U56 ( .IN1(n141), .IN2(n146), .IN3(n147), .IN4(n148), .QN(n39) );
  INVX0 U57 ( .IN(n26), .QN(n24) );
  NAND4X0 U58 ( .IN1(\sec_cntr_0/cntr[4] ), .IN2(\sec_cntr_0/cntr[3] ), .IN3(
        \sec_cntr_0/cntr[5] ), .IN4(n40), .QN(n26) );
  NOR4X0 U59 ( .IN1(\sec_cntr_0/cntr[2] ), .IN2(clk_1sec), .IN3(n7), .IN4(n136), .QN(n40) );
  NOR3X0 U60 ( .IN1(\digit_sel_0/ds_ns[1] ), .IN2(\digit_sel_0/n4 ), .IN3(n41), 
        .QN(\digit_sel_0/n16 ) );
  AO21X1 U61 ( .IN1(\digit_sel_0/ds_ns[1] ), .IN2(n2), .IN3(n42), .Q(
        \digit_sel_0/ds_ns[2] ) );
  NOR3X0 U62 ( .IN1(n43), .IN2(\digit_sel_0/N49 ), .IN3(n41), .QN(
        \digit_sel_0/ds_ns[0] ) );
  NAND4X0 U63 ( .IN1(n44), .IN2(n45), .IN3(n46), .IN4(n47), .QN(
        \digit_sel_0/N54 ) );
  NAND2X0 U64 ( .IN1(n42), .IN2(n48), .QN(n46) );
  AO22X1 U65 ( .IN1(n49), .IN2(n50), .IN3(n51), .IN4(n52), .Q(n48) );
  XOR3X1 U66 ( .IN1(n53), .IN2(n54), .IN3(n55), .Q(n51) );
  NAND2X0 U67 ( .IN1(n56), .IN2(\min_cntr_0/cntr[3] ), .QN(n45) );
  NAND3X0 U68 ( .IN1(n57), .IN2(n58), .IN3(n59), .QN(n44) );
  XOR2X1 U69 ( .IN1(\min_cntr_0/cntr[3] ), .IN2(n60), .Q(n58) );
  NAND2X0 U70 ( .IN1(n61), .IN2(n62), .QN(n60) );
  AO21X1 U71 ( .IN1(n63), .IN2(\min_cntr_0/cntr[2] ), .IN3(n64), .Q(n57) );
  AO221X1 U72 ( .IN1(n42), .IN2(n65), .IN3(n66), .IN4(n59), .IN5(n67), .Q(
        \digit_sel_0/N53 ) );
  AO22X1 U73 ( .IN1(n56), .IN2(\min_cntr_0/cntr[2] ), .IN3(n68), .IN4(n69), 
        .Q(n67) );
  NAND2X0 U74 ( .IN1(n70), .IN2(n62), .QN(n69) );
  INVX0 U75 ( .IN(n71), .QN(n56) );
  MUX21X1 U76 ( .IN1(n72), .IN2(n73), .S(\min_cntr_0/n42 ), .Q(n66) );
  XOR2X1 U77 ( .IN1(n74), .IN2(n75), .Q(n73) );
  NAND2X0 U78 ( .IN1(n63), .IN2(n76), .QN(n72) );
  INVX0 U79 ( .IN(n64), .QN(n76) );
  NOR2X0 U80 ( .IN1(n75), .IN2(n74), .QN(n64) );
  NAND2X0 U81 ( .IN1(n75), .IN2(n74), .QN(n63) );
  AO22X1 U82 ( .IN1(n54), .IN2(n52), .IN3(n77), .IN4(n78), .Q(n65) );
  NAND2X0 U83 ( .IN1(n79), .IN2(n80), .QN(n78) );
  AND2X1 U84 ( .IN1(n81), .IN2(n80), .Q(n54) );
  OR2X1 U85 ( .IN1(n53), .IN2(\hr_cntr_0/n38 ), .Q(n80) );
  NAND4X0 U86 ( .IN1(n82), .IN2(n47), .IN3(n83), .IN4(n84), .QN(
        \digit_sel_0/N52 ) );
  AOI222X1 U87 ( .IN1(n43), .IN2(n85), .IN3(n42), .IN4(n86), .IN5(n59), .IN6(
        n75), .QN(n84) );
  AND2X1 U88 ( .IN1(\min_cntr_0/n43 ), .IN2(n87), .Q(n75) );
  INVX0 U89 ( .IN(n88), .QN(n59) );
  NAND2X0 U90 ( .IN1(n89), .IN2(n90), .QN(n86) );
  MUX21X1 U91 ( .IN1(n91), .IN2(n53), .S(\hr_cntr_0/n38 ), .Q(n89) );
  AOI21X1 U92 ( .IN1(n53), .IN2(n52), .IN3(n49), .QN(n91) );
  INVX0 U93 ( .IN(n92), .QN(n85) );
  NAND2X0 U94 ( .IN1(n68), .IN2(n74), .QN(n83) );
  NAND2X0 U95 ( .IN1(n93), .IN2(n94), .QN(n74) );
  INVX0 U96 ( .IN(n95), .QN(n68) );
  NAND3X0 U97 ( .IN1(n96), .IN2(\min_cntr_0/cntr[1] ), .IN3(n97), .QN(n82) );
  NAND2X0 U98 ( .IN1(n98), .IN2(n87), .QN(n96) );
  AND2X1 U99 ( .IN1(n94), .IN2(n62), .Q(n87) );
  OAI221X1 U100 ( .IN1(n95), .IN2(n99), .IN3(n47), .IN4(clk_1sec), .IN5(n100), 
        .QN(\digit_sel_0/N51 ) );
  AOI222X1 U101 ( .IN1(n101), .IN2(n43), .IN3(n102), .IN4(n42), .IN5(n103), 
        .IN6(\min_cntr_0/N51 ), .QN(n100) );
  NAND2X0 U102 ( .IN1(n88), .IN2(n71), .QN(n103) );
  NAND2X0 U103 ( .IN1(n104), .IN2(n97), .QN(n71) );
  INVX0 U104 ( .IN(n98), .QN(n104) );
  NAND3X0 U105 ( .IN1(n148), .IN2(n105), .IN3(n146), .QN(n98) );
  NAND2X0 U106 ( .IN1(\min_cntr_0/cntr[3] ), .IN2(n106), .QN(n105) );
  NAND2X0 U107 ( .IN1(n97), .IN2(n107), .QN(n88) );
  NAND3X0 U108 ( .IN1(n94), .IN2(n99), .IN3(n62), .QN(n107) );
  NAND3X0 U109 ( .IN1(n70), .IN2(n5), .IN3(n108), .QN(n62) );
  NAND2X0 U110 ( .IN1(n147), .IN2(n146), .QN(n108) );
  NAND4X0 U111 ( .IN1(n148), .IN2(n109), .IN3(n110), .IN4(\min_cntr_0/cntr[4] ), .QN(n94) );
  NAND2X0 U112 ( .IN1(n147), .IN2(\min_cntr_0/n42 ), .QN(n109) );
  AND3X1 U113 ( .IN1(\digit_sel_0/n5 ), .IN2(\digit_sel_0/n6 ), .IN3(
        \digit_sel_0/n4 ), .Q(n97) );
  INVX0 U114 ( .IN(n111), .QN(n42) );
  OA21X1 U115 ( .IN1(n49), .IN2(n52), .IN3(\hr_cntr_0/N30 ), .Q(n102) );
  NAND2X0 U116 ( .IN1(n92), .IN2(n53), .QN(n52) );
  NAND3X0 U117 ( .IN1(n112), .IN2(n113), .IN3(n114), .QN(n92) );
  MUX21X1 U118 ( .IN1(n77), .IN2(n115), .S(n50), .Q(n114) );
  NAND2X0 U119 ( .IN1(n77), .IN2(\hr_cntr_0/cntr[1] ), .QN(n115) );
  AND3X1 U120 ( .IN1(\digit_sel_0/n6 ), .IN2(n2), .IN3(\digit_sel_0/n5 ), .Q(
        n43) );
  INVX0 U121 ( .IN(n116), .QN(n101) );
  MUX21X1 U122 ( .IN1(n53), .IN2(n90), .S(n49), .Q(n116) );
  INVX0 U123 ( .IN(n79), .QN(n49) );
  NAND3X0 U124 ( .IN1(n117), .IN2(n118), .IN3(n112), .QN(n79) );
  AO21X1 U125 ( .IN1(\hr_cntr_0/n38 ), .IN2(n81), .IN3(n55), .Q(n118) );
  NAND4X0 U126 ( .IN1(n55), .IN2(\hr_cntr_0/n38 ), .IN3(n112), .IN4(n119), 
        .QN(n90) );
  NOR3X0 U127 ( .IN1(\hr_cntr_0/N30 ), .IN2(mil_time), .IN3(n77), .QN(n119) );
  INVX0 U128 ( .IN(n50), .QN(n55) );
  NAND2X0 U129 ( .IN1(n120), .IN2(n112), .QN(n53) );
  MUX21X1 U130 ( .IN1(n145), .IN2(n9), .S(n121), .Q(n112) );
  MUX21X1 U131 ( .IN1(n122), .IN2(n123), .S(n50), .Q(n120) );
  MUX21X1 U132 ( .IN1(\hr_cntr_0/cntr[3] ), .IN2(\hr_cntr_0/N33 ), .S(n121), 
        .Q(n50) );
  OA21X1 U133 ( .IN1(n77), .IN2(\hr_cntr_0/cntr[1] ), .IN3(n117), .Q(n123) );
  NOR2X0 U134 ( .IN1(n77), .IN2(n117), .QN(n122) );
  INVX0 U135 ( .IN(n113), .QN(n117) );
  MUX21X1 U136 ( .IN1(\hr_cntr_0/cntr[4] ), .IN2(\hr_cntr_0/N34 ), .S(n121), 
        .Q(n113) );
  INVX0 U137 ( .IN(n124), .QN(n121) );
  INVX0 U138 ( .IN(n81), .QN(n77) );
  XNOR2X1 U139 ( .IN1(n124), .IN2(\hr_cntr_0/n37 ), .Q(n81) );
  NAND2X0 U140 ( .IN1(n125), .IN2(n126), .QN(n124) );
  NAND3X0 U141 ( .IN1(n145), .IN2(n127), .IN3(n142), .QN(n126) );
  NAND3X0 U142 ( .IN1(\hr_cntr_0/cntr[2] ), .IN2(\hr_cntr_0/cntr[3] ), .IN3(
        n128), .QN(n127) );
  NAND2X0 U143 ( .IN1(\hr_cntr_0/n38 ), .IN2(n144), .QN(n128) );
  INVX0 U144 ( .IN(mil_time), .QN(n125) );
  AND2X1 U145 ( .IN1(n61), .IN2(n70), .Q(n99) );
  NAND3X0 U146 ( .IN1(n5), .IN2(\min_cntr_0/cntr[4] ), .IN3(n129), .QN(n70) );
  NAND2X0 U147 ( .IN1(n147), .IN2(n130), .QN(n129) );
  OA21X1 U148 ( .IN1(n131), .IN2(n5), .IN3(n93), .Q(n61) );
  AO21X1 U149 ( .IN1(n146), .IN2(\min_cntr_0/cntr[3] ), .IN3(n132), .Q(n93) );
  MUX21X1 U150 ( .IN1(\min_cntr_0/cntr[4] ), .IN2(n110), .S(n148), .Q(n132) );
  NAND3X0 U151 ( .IN1(\min_cntr_0/cntr[1] ), .IN2(\min_cntr_0/cntr[3] ), .IN3(
        \min_cntr_0/cntr[2] ), .QN(n110) );
  INVX0 U152 ( .IN(n133), .QN(n131) );
  MUX21X1 U153 ( .IN1(n134), .IN2(n135), .S(n147), .Q(n133) );
  NOR2X0 U154 ( .IN1(n146), .IN2(\min_cntr_0/cntr[2] ), .QN(n135) );
  NOR2X0 U155 ( .IN1(n130), .IN2(\min_cntr_0/cntr[4] ), .QN(n134) );
  INVX0 U156 ( .IN(n106), .QN(n130) );
  NAND2X0 U157 ( .IN1(\min_cntr_0/n43 ), .IN2(\min_cntr_0/n42 ), .QN(n106) );
  NAND2X0 U158 ( .IN1(n111), .IN2(n47), .QN(\digit_sel_0/N50 ) );
  OR3X1 U159 ( .IN1(n4), .IN2(\digit_sel_0/n5 ), .IN3(n2), .Q(n47) );
  NAND2X0 U160 ( .IN1(n111), .IN2(n95), .QN(\digit_sel_0/N49 ) );
  NAND3X0 U161 ( .IN1(\digit_sel_0/n5 ), .IN2(n4), .IN3(\digit_sel_0/n4 ), 
        .QN(n95) );
  NAND2X0 U162 ( .IN1(\digit_sel_0/n4 ), .IN2(n41), .QN(n111) );
  OAI21X1 U163 ( .IN1(\digit_sel_0/ds_ns[1] ), .IN2(n41), .IN3(n2), .QN(
        \digit_sel_0/N48 ) );
  NOR2X0 U164 ( .IN1(\digit_sel_0/n5 ), .IN2(\digit_sel_0/n6 ), .QN(n41) );
  XNOR2X1 U165 ( .IN1(\digit_sel_0/n5 ), .IN2(n4), .Q(\digit_sel_0/ds_ns[1] )
         );
endmodule

