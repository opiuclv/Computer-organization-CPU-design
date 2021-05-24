/*
�� 32-bits �L���ư��k Sequential Restoring Division Hardware�A�� �ĥ� Third Version Sequential Restoring Division Hardware �ӳ]�p�A�аѦҽ� �{���q[2] P.15-P.26�C�i�ϥ� Always Block �� Procedure Assignment �ӳ]�p�A ���i�������j��Φ����]�p�j;�N�Y Division Hardware �����঳ for/while ���ԭz�C
���Ҳլ��`���޿�(Sequential Logic)�A�]�����H Clock �T���P�B�C
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
�W���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================
*/
/*
�w�q�U�ذT��
*/
/*
=====================================================
�U���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
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
reset�T�� �p�G�Oreset�N���k0
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
���k�B��
OUT�������O�n��control���A���O�A�~����⵪�׿�X��HILO�Ȧs��
*/


