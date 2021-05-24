 
module ALU32( dout, a, b, sel, reset ) ;

  //parameter AND = 6'b100100; // 36
  //parameter OR  = 6'b100101; // 37
  //parameter ADD = 6'b100000; // 32
  //parameter SUB = 6'b100010; // 34
  //parameter SLT = 6'b101010; // 42
   
  parameter ADD = 3'b010;
  parameter SUB = 3'b110;
  parameter AND = 3'b000;
  parameter OR  = 3'b001;
  parameter SLT = 3'b111;
	
  output [31:0] dout ;
  input reset ;
  input [31:0] a, b ;
  //input [5:0] sel ;
  input [2:0] sel ;  
  wire inv ,overflow ;
  wire [31:0] c_in, temp ;
  

  assign c_in[0] = ( sel == SUB || sel == SLT ) ? 1 : 0 ;
  assign inv = ( sel == SUB || sel == SLT ) ? 1 : 0 ;

  ALU alu1( .result( temp[0] ), .c_out( c_in[1] ), .a( a[0] ), .b( b[0] ), .c_in( c_in[0] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu2( .result( temp[1] ), .c_out( c_in[2] ), .a( a[1] ), .b( b[1] ), .c_in( c_in[1] ), .sel( sel ), .inv( inv ) ) ;  
  
  ALU alu3( .result( temp[2] ), .c_out( c_in[3] ), .a( a[2] ), .b( b[2] ), .c_in( c_in[2] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu4( .result( temp[3] ), .c_out( c_in[4] ), .a( a[3] ), .b( b[3] ), .c_in( c_in[3] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu5( .result( temp[4] ), .c_out( c_in[5] ), .a( a[4] ), .b( b[4] ), .c_in( c_in[4] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu6( .result( temp[5] ), .c_out( c_in[6] ), .a( a[5] ), .b( b[5] ), .c_in( c_in[5] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu7( .result( temp[6] ), .c_out( c_in[7] ), .a( a[6] ), .b( b[6] ), .c_in( c_in[6] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu8( .result( temp[7] ), .c_out( c_in[8] ), .a( a[7] ), .b( b[7] ), .c_in( c_in[7] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu9( .result( temp[8] ), .c_out( c_in[9] ), .a( a[8] ), .b( b[8] ), .c_in( c_in[8] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu10( .result( temp[9] ), .c_out( c_in[10] ), .a( a[9] ), .b( b[9] ), .c_in( c_in[9] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu11( .result( temp[10] ), .c_out( c_in[11] ), .a( a[10] ), .b( b[10] ), .c_in( c_in[10] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu12( .result( temp[11] ), .c_out( c_in[12] ), .a( a[11] ), .b( b[11] ), .c_in( c_in[11] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu13( .result( temp[12] ), .c_out( c_in[13] ), .a( a[12] ), .b( b[12] ), .c_in( c_in[12] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu14( .result( temp[13] ), .c_out( c_in[14] ), .a( a[13] ), .b( b[13] ), .c_in( c_in[13] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu15( .result( temp[14] ), .c_out( c_in[15] ), .a( a[14] ), .b( b[14] ), .c_in( c_in[14] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu16( .result( temp[15] ), .c_out( c_in[16] ), .a( a[15] ), .b( b[15] ), .c_in( c_in[15] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu17( .result( temp[16] ), .c_out( c_in[17] ), .a( a[16] ), .b( b[16] ), .c_in( c_in[16] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu18( .result( temp[17] ), .c_out( c_in[18] ), .a( a[17] ), .b( b[17] ), .c_in( c_in[17] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu19( .result( temp[18] ), .c_out( c_in[19] ), .a( a[18] ), .b( b[18] ), .c_in( c_in[18] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu20( .result( temp[19] ), .c_out( c_in[20] ), .a( a[19] ), .b( b[19] ), .c_in( c_in[19] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu21( .result( temp[20] ), .c_out( c_in[21] ), .a( a[20] ), .b( b[20] ), .c_in( c_in[20] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu22( .result( temp[21] ), .c_out( c_in[22] ), .a( a[21] ), .b( b[21] ), .c_in( c_in[21] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu23( .result( temp[22] ), .c_out( c_in[23] ), .a( a[22] ), .b( b[22] ), .c_in( c_in[22] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu24( .result( temp[23] ), .c_out( c_in[24] ), .a( a[23] ), .b( b[23] ), .c_in( c_in[23] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu25( .result( temp[24] ), .c_out( c_in[25] ), .a( a[24] ), .b( b[24] ), .c_in( c_in[24] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu26( .result( temp[25] ), .c_out( c_in[26] ), .a( a[25] ), .b( b[25] ), .c_in( c_in[25] ), .sel( sel ), .inv( inv ) ) ;

  ALU alu27( .result( temp[26] ), .c_out( c_in[27] ), .a( a[26] ), .b( b[26] ), .c_in( c_in[26] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu28( .result( temp[27] ), .c_out( c_in[28] ), .a( a[27] ), .b( b[27] ), .c_in( c_in[27] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu29( .result( temp[28] ), .c_out( c_in[29] ), .a( a[28] ), .b( b[28] ), .c_in( c_in[28] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu30( .result( temp[29] ), .c_out( c_in[30] ), .a( a[29] ), .b( b[29] ), .c_in( c_in[29] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu31( .result( temp[30] ), .c_out( c_in[31] ), .a( a[30] ), .b( b[30] ), .c_in( c_in[30] ), .sel( sel ), .inv( inv ) ) ;
  
  ALU alu32( .result( temp[31] ), .c_out( overflow ), .a( a[31] ), .b( b[31] ), .c_in( c_in[31] ), .sel( sel ), .inv( inv ) ) ;
  
  assign dout = ( reset ) ? 0 : 
  
                ( ( sel == SLT ) && ( temp[31] == 1 ) ) ? 1 : 
				( ( sel == SLT ) && ( temp[31] == 0 ) ) ? 0 : 
				
				temp ;
  
endmodule  