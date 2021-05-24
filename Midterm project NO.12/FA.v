`timescale 1ns/1ns
module FA( dataA, dataB, c_in, c_out, Sum );

input [31:0] dataA ;
input [31:0] dataB ;

input	c_in, c_out, Sum ;
wire	e1, e2, e3 ; 

// =================Full Adder===================== //

xor g1(e1, dataA, dataB);
and g2(e2, dataA, dataB);
and g3(e3, e1, c_in);
or	g4(c_out,e2, e3);
xor  g5(Sum, e1, c_in);

// =================Full Adder===================== //


endmodule