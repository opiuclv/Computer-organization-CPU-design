/*
���H Data Flow Modeling �]�p�C
���Ҳլ��զX�޿�(Combinational Logic)�C
*/

`timescale 1ns/1ns
module MUX( ALUOut, HiOut, LoOut, Shifter, Signal, dataOut );
input [31:0] ALUOut ;
input [31:0] HiOut ;
input [31:0] LoOut ;
input [31:0] Shifter ;
input [5:0] Signal ;
output [31:0] dataOut ;


// input [31:0] temp ;

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;

parameter SRL = 6'b000010;

parameter DIVU= 6'b011011;
parameter MFHI= 6'b010000;
parameter MFLO= 6'b010010;
/*
�w�q�U�ذT��
*/
/*
=====================================================
�U���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================

*/

// ============================��g==========================================

assign temp = (Signal == AND ) ? (ALUOut) :
			 (Signal == OR ) ? (ALUOut) :
			 (Signal == ADD ) ? (ALUOut) :
			 (Signal == SUB ) ? (ALUOut) :
			 (Signal == SLT ) ? (ALUOut) :
			 (Signal == MFHI ) ? (HiOut) :
			 (Signal == MFLO ) ? (LoOut) :
			 (Signal == SRL ) ? (Shifter) :

    temp ;

endmodule

// ============================��g==========================================



/*

always@( ALUOut or HiOut or LoOut or Shifter or Signal )
begin

	case ( Signal )
	AND:
	begin
		temp = ALUOut ;
	end
	OR:
	begin
		temp = ALUOut ;
	end
	ADD:
	begin
		temp = ALUOut ;
	end
	SUB:
	begin
		temp = ALUOut ;
	end
	SLT:
	begin
		temp = ALUOut ;
	end
	MFHI:
	begin
		temp = HiOut ;
	end
	MFLO:
	begin
		temp = LoOut ;
	end
*/
/*
===========
   ���n
===========
MFHI�MMFLO
�o��D���O�@�w�n�[�i��
�o�O��HILO�Ȧs�����ȿ�X�����O
�ЧO�ѰO
===========
   ���n
===========
*/
/*
	SRL:
	begin
		temp = Shifter ;
	end
	default: temp = 32'b0 ;	
	
	endcase
/*
�W���o��case�O�b���T���B�z
���O�ھڶǶi�Ӫ�signal�ӿ�ܤ��P����J�ӷ�
�M���i�Ȧs���A��X
*/
/*
end
assign dataOut = temp ;
/*
=====================================================
�W���������d�ҡA�{�����g�п�ӦѮv�W�һ�������k�Ӽg
=====================================================
*/
/*
endmodule
*/