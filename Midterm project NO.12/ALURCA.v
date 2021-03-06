/*
ALU: 包含 32-bits AND, OR, ADD, SUB, SLT等功能，並以課程講義[1]P.12-P.28
所述之設計方式，使用Gate-Level Modeling 與Data Flow Modeling
(Continuous Assignments)，從Full Adder做起，以Ripple-Carry的進位方式，
連接32 個1-bit ALU Bit Slice，成為32-bit ALU。不能直接用'+' operator，
亦不可使用Always Block 或Procedure Assignment來設計。
本模組為組合邏輯(Combinational Logic)。
*/
`timescale 1ns/1ns
module ALURCA( dataA, dataB, c_in, c_out, Signal, dataOut, reset, invert, less );
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
input invert ;
input c_in, c_out ;
input less ;
output [31:0] dataOut ;

//   Signal ( 6-bits)?
//   AND  : 36
//   OR   : 37
//   ADD  : 32
//   SUB  : 34
//   SLT  : 42
parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;

wire e1, e2, e3, Sum ;

// =========================================================== 改寫 ======================================================== //

	and g1(e1, dataA, dataB); // ALU AND
	or	g2(e2, dataA, dataB); // ALU OR

	xor g3(e3, dataB, invert); // invertB ALU XOR

	FA FA( dataA, e3, c_in, c_out, Sum ); // Full adder
	
    assign dataOut = ( Signal == AND ) ? (e1) :
                     ( Signal == OR ) ? (e2) :
                     ( Signal == ADD ) ? (Sum) :
				     ( Signal == SUB ) ? (Sum) :
					 32'b0 ;

endmodule

// =========================================================== 改寫 ======================================================== //

