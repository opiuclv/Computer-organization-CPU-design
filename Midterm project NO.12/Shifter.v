/*
�]�p 32-bits Barrel Shifter�A�H�����޿襪���B��C�åH�ҵ{���q[1]P.28 �� �y�z���]�p�覡�A�H Data Flow Modeling(Continuous Assignments)�����A�� �ઽ���� '>>'��'<<' operator�A�礣�i�ϥ� Always Block �� Procedure Assignment �ӳ]�p�C
���Ҳլ��զX�޿�(Combinational Logic)�C
*/

`timescale 1ns/1ns
module Shifter( dataA, dataB, Signal, dataOut, reset );
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output [31:0] dataOut ;


reg [31:0] temp ;

parameter SRL = 6'b000010;

  wire [31:0] dataTempB0,dataTempB1,dataTempB2,dataTempB3,dataTempB4 ;
    //�첾        1       	2    	 	4       	8     	16

/*
=====================================================
�U���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================
*/

// =========================================================== ��g ======================================================== //

  assign dataTempB0 = dataB[0] ? { 1'b0 , dataA[31:1] }: dataA[31:0];
  assign dataTempB1 = dataB[1] ? { 2'b0, dataTempB0[31:2] }: dataTempB0[31:0] ;
  assign dataTempB2 = dataB[2] ? { 4'b0, dataTempB1[31:4] }: dataTempB1[31:0];
  assign dataTempB3 = dataB[3] ? { 8'b0, dataTempB2[31:8] }: dataTempB2[31:0];
  assign dataTempB4 = dataB[4] ? { 16'b0, dataTempB3[31:16] }:dataTempB3[31:0];
  assign result = ( Signal == SRL ) ? dataTempB4 : 32'b0 ;

  assign dataOut = ( Signal == SRL ) ? dataTempB4 : 32'b0 ;


// =========================================================== ��g ======================================================== //

/*
always@( Signal or dataA or dataB or reset )
begin
	if ( reset )
	begin
		temp = 32'b0 ;
	end
/*
reset�T�� �p�G�Oreset�N���k0
*/
/*
	else
	begin
		case ( Signal )
		SRL:
		begin
			temp = dataA >> dataB ;
		end
		default: temp = 32'b0 ;	
	
		endcase
	end
/*
���쾹�B��
*/
/*
end
assign dataOut = temp ;
*/
/*
=====================================================
�W���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================
*/

endmodule