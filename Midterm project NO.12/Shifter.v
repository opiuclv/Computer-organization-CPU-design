/*
設計 32-bits Barrel Shifter，以完成邏輯左移運算。並以課程講義[1]P.28 所 描述之設計方式，以 Data Flow Modeling(Continuous Assignments)完成，不 能直接用 '>>'或'<<' operator，亦不可使用 Always Block 或 Procedure Assignment 來設計。
本模組為組合邏輯(Combinational Logic)。
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
    //位移        1       	2    	 	4       	8     	16

/*
=====================================================
下面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/

// =========================================================== 改寫 ======================================================== //

  assign dataTempB0 = dataB[0] ? { 1'b0 , dataA[31:1] }: dataA[31:0];
  assign dataTempB1 = dataB[1] ? { 2'b0, dataTempB0[31:2] }: dataTempB0[31:0] ;
  assign dataTempB2 = dataB[2] ? { 4'b0, dataTempB1[31:4] }: dataTempB1[31:0];
  assign dataTempB3 = dataB[3] ? { 8'b0, dataTempB2[31:8] }: dataTempB2[31:0];
  assign dataTempB4 = dataB[4] ? { 16'b0, dataTempB3[31:16] }:dataTempB3[31:0];
  assign result = ( Signal == SRL ) ? dataTempB4 : 32'b0 ;

  assign dataOut = ( Signal == SRL ) ? dataTempB4 : 32'b0 ;


// =========================================================== 改寫 ======================================================== //

/*
always@( Signal or dataA or dataB or reset )
begin
	if ( reset )
	begin
		temp = 32'b0 ;
	end
/*
reset訊號 如果是reset就做歸0
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
移位器運算
*/
/*
end
assign dataOut = temp ;
*/
/*
=====================================================
上面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/

endmodule