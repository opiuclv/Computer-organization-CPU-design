`timescale 1ns/1ns
module HiLo( clk, DivAns, HiOut, LoOut, reset );

  input clk ;
  input reset ; //初始化
  input [63:0] DivAns ;//乘法器的答案
  output [31:0] HiOut ;//high
  output [31:0] LoOut ;//low
  reg [63:0] HiLo ;//reg暫存high和low


  always@( posedge clk or reset )
  begin

    if ( reset )
      HiLo = 64'b0 ;

    else
      HiLo = DivAns ;

  end

  assign HiOut = HiLo[63:32] ;
  assign LoOut = HiLo[31:0] ;

endmodule