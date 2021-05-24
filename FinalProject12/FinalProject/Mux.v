module Mux( ALUOut, HiOut, LoOut, Shifter, signal, dataOut );
			
  input[31:0] ALUOut; //ALU的答案
  input [31:0] HiOut ;
  input [31:0] LoOut ;
  input [31:0] Shifter ;
  input [2:0] signal ;
  output [31:0] dataOut ;

  wire [31:0] temp ;

    parameter ADD = 3'b010;
    parameter SUB = 3'b110;
    parameter AND = 3'b000;
    parameter OR  = 3'b001;
    parameter SLT = 3'b111;
	
	parameter SRL = 3'b011;
	
	// symbolic constants for ALU Out MUX Selection
	parameter MFHI = 2'b10;
	parameter MFLO = 2'b01;

  assign temp = ( ( signal == AND ) || ( signal == OR ) || ( signal == ADD ) || ( signal == SUB ) || ( signal == SLT ) ) ? ALUOut :        		  
                ( signal == MFHI ) ? HiOut :
                ( signal == MFLO ) ? LoOut :
			    ( signal == SRL )  ? Shifter :
                32'b0 ;     
			  
  assign dataOut = temp;		  
			  
			  
endmodule