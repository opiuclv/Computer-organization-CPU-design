
module Shifter( a, b, op, result ) ;

  input [31:0] a;
  input [4:0] b ;
  input [2:0] op;
  
  output [31:0] result;
  
  wire [31:0] tempB0,tempB1,tempB2,tempB3,tempB4 ;
    //位移        1       2     4       8     16

  parameter SRL = 3'b011;
    
  assign tempB0 = b[0] ? { 1'b0 , a[31:1] }: a[31:0];
    // 如果右移1位元 將b第1~31個位元保留 在左側插入1b'0 沒有位移保持原始資料
  assign tempB1 = b[1] ? { 2'b0, tempB0[31:2] }: tempB0[31:0] ;
    // 如果右移2位元 將tempB0第2~31個位元保留 在左側插入2b'0 沒有位移保持原始資料
  assign tempB2 = b[2] ? { 4'b0, tempB1[31:4] }: tempB1[31:0];
    // 如果右移4位元 將tempB1第4~31個位元保留 在左側插入4b'0 沒有位移保持原始資料
  assign tempB3 = b[3] ? { 8'b0, tempB2[31:8] }: tempB2[31:0];
    // 如果右移8位元 將tempB2第8~31個位元保留 在左側插入8b'0 沒有位移保持原始資料
  assign tempB4 = b[4] ? { 16'b0, tempB3[31:16] }:tempB3[31:0];
    // 如果右移16位元 將tempB3第16~31個位元保留 在左側插入16b'0 沒有位移保持原始資料
    
  assign result = ( op == SRL ) ? tempB4 : 32'b0 ;
 
endmodule
