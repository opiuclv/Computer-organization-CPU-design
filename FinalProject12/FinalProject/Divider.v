/*
為 32-bits 無號數除法 Sequential Restoring Division Hardware，須 採用 Third Version Sequential Restoring Division Hardware 來設計，請參考課 程講義[2] P.15-P.26。可使用 Always Block 或 Procedure Assignment 來設計， 但【不接受迴圈形式的設計】;意即 Division Hardware 內不能有 for/while 等敘述。
本模組為循序邏輯(Sequential Logic)，因此須以 Clock 訊號同步。
*/


`timescale 1ns/1ns
module Divider( clk, dataA, dataB, Signal, dataOut, reset );
input clk ;
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
output reg [63:0] dataOut ;

//   Signal ( 6-bits)?
//   DIVU  : 27

reg signed [63:0] tempDA ;
reg [63:0] tempDB ;
reg [31:0] quotient ;
reg [63:0] temp ;
parameter DIVU = 6'b011011;
parameter OUT = 6'b111111;

	reg [6:0] count_for_CLK ;
	reg startCLK ;

	always@( posedge clk or reset )
	begin
		if ( reset )
		begin
			tempDA <= 64'b0 ;
			tempDB <= 64'b0 ;
			quotient <= 32'b0 ;	
			startCLK <= 1'b0;
		end
		else
		begin
			if ( DIVU )
			begin
				count_for_CLK <= 7'b0 ;
				tempDA <= {32'b0, dataA} ;
				tempDB <= {dataB, 32'b0} ;
				quotient <= 32'b0 ;
				startCLK <= 1'b1;
			end

			if ( startCLK )
			begin
				if ( count_for_CLK == 33 )
				begin
					dataOut[63:32] = quotient;
					dataOut[31:0] = tempDA[31:0] ;
					startCLK = 1'b0;
				end
				else if ( count_for_CLK < 33 )
				begin
					tempDA = tempDA - tempDB ;
					if ( tempDA >= 0 )
					begin
						quotient = {quotient[30:0], 1'b1} ;
					end
					else
					begin
						tempDA = tempDA + tempDB ;
						quotient = {quotient[30:0], 1'b0} ;
					end
					
					tempDB = {1'b0, tempDB[63:1]} ;
				end
				count_for_CLK = count_for_CLK + 1 ;			
			end
		end
	end
	

endmodule
/*
=====================================================
上面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/
/*
定義各種訊號
*/
/*
=====================================================
下面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/

/*
always@( posedge clk or reset )
begin
        if ( reset )
        begin
                temp = 32'b0 ;
                startCLK <= 1'b0;
        end
/*
reset訊號 如果是reset就做歸0
*/

/*
        else
        begin
		case ( Signal )
  		DIVU:
		begin

		end
  		OUT:
		begin
			 temp[63:32] = dataA / dataB ;
			 temp[31:0]= dataA % dataB ;
			#330 ;
		end
		endcase
        end
*/
/*
除法運算
OUT的部分是要等control給你指令你才能夠把答案輸出到HILO暫存器
*/


