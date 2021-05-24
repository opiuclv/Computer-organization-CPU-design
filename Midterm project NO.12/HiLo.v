/*
�����k���p�⧹��A�x�s�p�⵲�G�� 64-bit �Ȧs���CQuotient �s�� Lo �Ȧs���ARemainder �s��� Hi.�Ȧs���C
���Ҳլ��`���޿�(Sequential Logic)�A�]�����H Clock �T���P�B�C
*/

`timescale 1ns/1ns
module HiLo( clk, DivAns, HiOut, LoOut, reset );
input clk ;
input reset ;
input [63:0] DivAns ;
output [31:0] HiOut ;
output [31:0] LoOut ;

reg [63:0] HiLo ;

/*
=====================================================
�U���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================
*/
always@( posedge clk or reset )
begin
  if ( reset )
  begin
    HiLo = 64'b0 ;
  end
/*
reset�T�� �p�G�Oreset�N���k0
*/
  else
  begin
    HiLo = DivAns ;
  end
/*
��ǤJ�����k���צs�_��
*/
end

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;
/*
=====================================================
�W���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================
*/
endmodule