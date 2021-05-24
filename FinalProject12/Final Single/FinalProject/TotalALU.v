
module TotalALU( dataA, dataB, Signal, Output, reset, zero );
input reset ;
input [31:0] dataA ;
input [31:0] dataB ;
//input [5:0] Signal ;
input [2:0] Signal ;
output [31:0] Output ;
output zero ;

/*
Signal : 6-bit Value(Decimal)
 ---------------------
 AND : 36
 OR : 37
 ADD : 32
 SUB : 34
 SLT : 42
 SRL : 02
 MULTU : 25
 --------------------- 
*/

//parameter AND = 6'b100100;
//parameter OR  = 6'b100101;
//parameter ADD = 6'b100000;
//parameter SUB = 6'b100010;
//parameter SLT = 6'b101010;

//parameter SRL = 6'b000010;

//parameter MULTU = 6'b011001;
//parameter MFHI= 6'b010000;
//parameter MFLO= 6'b010010;

parameter ADD = 3'b010;
parameter SUB = 3'b110;
parameter AND = 3'b000;
parameter OR  = 3'b001;
parameter SLT = 3'b111;
parameter SRL = 3'b011;
// symbolic constants for ALU Out MUX Selection
parameter MFHI = 2'b10;
parameter MFLO = 2'b01;


/*
定義各種訊號
*/
//============================
wire [2:0]  SignaltoALU ;
wire [2:0]  SignaltoSHT ;
wire [2:0]  SignaltoMULT ;
wire [2:0]  SignaltoMUX ;
wire [31:0] ALUOut, HiOut, LoOut, ShifterOut ;
wire [31:0] dataOut ;
wire [4:0] shamt ;

assign shamt = dataA[10:6] ;

/*
定義各種接線
*/
//============================
// control要改

ALU32 ALU32( dataOut, dataA, dataB, Signal, reset );
Shifter Shifter( dataB, shamt, Signal, ShifterOut );
Mux Mux( ALUOut,HiOut, LoOut, ShifterOut, Signal, dataOut );

/*
建立各種module
*/
assign zero = ( dataOut == 32'd0 ) ? 1 : 0 ;
assign Output = dataOut ;


endmodule