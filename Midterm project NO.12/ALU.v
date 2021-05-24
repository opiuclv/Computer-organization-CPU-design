/*
ALU: 包含 32-bits AND, OR, ADD, SUB, SLT等功能，並以課程講義[1]P.12-P.28
所述之設計方式，使用Gate-Level Modeling 與Data Flow Modeling
(Continuous Assignments)，從Full Adder做起，以Ripple-Carry的進位方式，
連接32 個1-bit ALU Bit Slice，成為32-bit ALU。不能直接用'+' operator，
亦不可使用Always Block 或Procedure Assignment來設計。
本模組為組合邏輯(Combinational Logic)。
*/


`timescale 1ns/1ns
module ALU( dataA, dataB, Signal, dataOut, reset );
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
input [5:0] Signal ;
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


// output [31:0] cout ;

// input	c_in, c_out, Sum ;

/*
定義各種訊號
*/

/*
=====================================================
下面為模擬範例，程式撰寫請遵照老師上課說明的方法來寫
=====================================================
*/

// =========================================================== 改寫 ======================================================== //

reg	[31:0]	a, b;


output [31:0] dataOut ;

wire [31:0] c_in, temp ;

assign less = 32'b0 ;


// ===========================================================

  input [6:0] Signal ;  
  wire invert ,overflow ;

  assign c_in[0] = ( Signal == SUB ) ? 1 : 0 ;
  assign invert = ( Signal == SUB ) ? 1 : 0 ;

  ALURCA alu1( .dataOut( temp[0] ), .c_out( c_in[1] ), .dataA( a[0] ), .dataB( b[0] ), .c_in( c_in[0] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu2( .dataOut( temp[1] ), .c_out( c_in[2] ), .dataA( a[1] ), .dataB( b[1] ), .c_in( c_in[1] ), .Signal( Signal ), .invert( invert ) ) ;  
  
  ALURCA alu3( .dataOut( temp[2] ), .c_out( c_in[3] ), .dataA( a[2] ), .dataB( b[2] ), .c_in( c_in[2] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu4( .dataOut( temp[3] ), .c_out( c_in[4] ), .dataA( a[3] ), .dataB( b[3] ), .c_in( c_in[3] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu5( .dataOut( temp[4] ), .c_out( c_in[5] ), .dataA( a[4] ), .dataB( b[4] ), .c_in( c_in[4] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu6( .dataOut( temp[5] ), .c_out( c_in[6] ), .dataA( a[5] ), .dataB( b[5] ), .c_in( c_in[5] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu7( .dataOut( temp[6] ), .c_out( c_in[7] ), .dataA( a[6] ), .dataB( b[6] ), .c_in( c_in[6] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu8( .dataOut( temp[7] ), .c_out( c_in[8] ), .dataA( a[7] ), .dataB( b[7] ), .c_in( c_in[7] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu9( .dataOut( temp[8] ), .c_out( c_in[9] ), .dataA( a[8] ), .dataB( b[8] ), .c_in( c_in[8] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu10( .dataOut( temp[9] ), .c_out( c_in[10] ), .dataA( a[9] ), .dataB( b[9] ), .c_in( c_in[9] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu11( .dataOut( temp[10] ), .c_out( c_in[11] ), .dataA( a[10] ), .dataB( b[10] ), .c_in( c_in[10] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu12( .dataOut( temp[11] ), .c_out( c_in[12] ), .dataA( a[11] ), .dataB( b[11] ), .c_in( c_in[11] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu13( .dataOut( temp[12] ), .c_out( c_in[13] ), .dataA( a[12] ), .dataB( b[12] ), .c_in( c_in[12] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu14( .dataOut( temp[13] ), .c_out( c_in[14] ), .dataA( a[13] ), .dataB( b[13] ), .c_in( c_in[13] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu15( .dataOut( temp[14] ), .c_out( c_in[15] ), .dataA( a[14] ), .dataB( b[14] ), .c_in( c_in[14] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu16( .dataOut( temp[15] ), .c_out( c_in[16] ), .dataA( a[15] ), .dataB( b[15] ), .c_in( c_in[15] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu17( .dataOut( temp[16] ), .c_out( c_in[17] ), .dataA( a[16] ), .dataB( b[16] ), .c_in( c_in[16] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu18( .dataOut( temp[17] ), .c_out( c_in[18] ), .dataA( a[17] ), .dataB( b[17] ), .c_in( c_in[17] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu19( .dataOut( temp[18] ), .c_out( c_in[19] ), .dataA( a[18] ), .dataB( b[18] ), .c_in( c_in[18] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu20( .dataOut( temp[19] ), .c_out( c_in[20] ), .dataA( a[19] ), .dataB( b[19] ), .c_in( c_in[19] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu21( .dataOut( temp[20] ), .c_out( c_in[21] ), .dataA( a[20] ), .dataB( b[20] ), .c_in( c_in[20] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu22( .dataOut( temp[21] ), .c_out( c_in[22] ), .dataA( a[21] ), .dataB( b[21] ), .c_in( c_in[21] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu23( .dataOut( temp[22] ), .c_out( c_in[23] ), .dataA( a[22] ), .dataB( b[22] ), .c_in( c_in[22] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu24( .dataOut( temp[23] ), .c_out( c_in[24] ), .dataA( a[23] ), .dataB( b[23] ), .c_in( c_in[23] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu25( .dataOut( temp[24] ), .c_out( c_in[25] ), .dataA( a[24] ), .dataB( b[24] ), .c_in( c_in[24] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu26( .dataOut( temp[25] ), .c_out( c_in[26] ), .dataA( a[25] ), .dataB( b[25] ), .c_in( c_in[25] ), .Signal( Signal ), .invert( invert ) ) ;

  ALURCA alu27( .dataOut( temp[26] ), .c_out( c_in[27] ), .dataA( a[26] ), .dataB( b[26] ), .c_in( c_in[26] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu28( .dataOut( temp[27] ), .c_out( c_in[28] ), .dataA( a[27] ), .dataB( b[27] ), .c_in( c_in[27] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu29( .dataOut( temp[28] ), .c_out( c_in[29] ), .dataA( a[28] ), .dataB( b[28] ), .c_in( c_in[28] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu30( .dataOut( temp[29] ), .c_out( c_in[30] ), .dataA( a[29] ), .dataB( b[29] ), .c_in( c_in[29] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu31( .dataOut( temp[30] ), .c_out( c_in[31] ), .dataA( a[30] ), .dataB( b[30] ), .c_in( c_in[30] ), .Signal( Signal ), .invert( invert ) ) ;
  
  ALURCA alu32( .dataOut( temp[31] ), .c_out( overflow ), .dataA( a[31] ), .dataB( b[31] ), .c_in( c_in[31] ), .Signal( Signal ), .invert( invert ) ) ;
  
  assign dataOut = ( reset ) ? 0 :
                   ( Signal == SLT ) ? 1: 
				   ( Signal == SLT ) ? 0: 
				   temp ; 
	
endmodule

// =========================================================== 改寫 ======================================================== //



/*

always@( dataA or dataB or Signal or reset )
begin
        if ( reset )
        begin
                temp = 32'b0 ;
        end 
*/
/*
reset訊號 如果是reset就做歸0
*/
/*
        else
        begin
		case ( Signal )
		AND:
		begin
			temp = dataA & dataB ;
		end
		OR:
		begin
			temp = dataA | dataB ;
		end
		ADD:
		begin
			temp = dataA + dataB ;
		end
		SUB:
		begin
			temp = dataA - dataB ;
		end
		SLT:
		begin
			if ( dataA < dataB )
				temp = 1 ;
			else
				temp = 0 ;
		end
		default: temp = 32'b0 ;	
	
		endcase
	end
*/
/*
上面這個case是在做訊號處理
分別根據傳進來的signal來做不同的運算
然後放進暫存器
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
