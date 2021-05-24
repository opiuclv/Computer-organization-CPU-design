
module ALU( result, c_out, a, b, c_in, sel, inv ) ;


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
	

  output result, c_out ;
  input a, b, c_in, inv ;
  //input [5:0] sel ;
  input [2:0] sel ;
  wire ans, temp_out ;
  wire tempB ;
  wire c_and, c_or ;
  
  
  assign tempB = ( inv ) ? (~b) : b ; //如果inv是0就不變不是就加一個負號
  
  fulladd  fulladd( .a(a) , .b(tempB), .c_in(c_in), .c_out(temp_out), .sum(ans) ) ;
  
  and( c_and, a, b ) ;
  or( c_or, a, b ) ;
  
  assign result = ( sel == AND ) ? c_and : // ( a & b )
                  ( sel == OR )  ? c_or : // ( a | b )
                  ( sel == ADD || sel == SUB || sel == SLT ) ? ans : 0 ;
				  
  assign c_out = ( sel == ADD || sel == SUB || sel == SLT ) ? temp_out : 0 ;				
				
  
endmodule    