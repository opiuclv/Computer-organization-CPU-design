/*
ALU: �]�t 32-bits AND, OR, ADD, SUB, SLT���\��A�åH�ҵ{���q[1]P.12-P.28
�ҭz���]�p�覡�A�ϥ�Gate-Level Modeling �PData Flow Modeling
(Continuous Assignments)�A�qFull Adder���_�A�HRipple-Carry���i��覡�A
�s��32 ��1-bit ALU Bit Slice�A����32-bit ALU�C���ઽ����'+' operator�A
�礣�i�ϥ�Always Block ��Procedure Assignment�ӳ]�p�C
���Ҳլ��զX�޿�(Combinational Logic)�C
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

// =========================================================== ��g ======================================================== //

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

// =========================================================== ��g ======================================================== //
