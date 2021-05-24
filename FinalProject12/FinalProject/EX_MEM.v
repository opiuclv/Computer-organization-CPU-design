module EX_MEM( clk, rst, WB,     MEM,     ALUOut,  Reg_rd,    WD_In, 
				         WB_Reg, MEM_Reg, ALU_Reg, Reg_RegRd, WD_Out );
					
	input clk, rst;
	input [1:0] WB;
	input [1:0] MEM;
	input [4:0] Reg_rd;
	input [31:0] ALUOut, WD_In;
	output reg [1:0] WB_Reg;
	output reg [1:0] MEM_Reg;
	output reg [4:0] Reg_RegRd;
	output reg [31:0] ALU_Reg, WD_Out;

	always@( posedge clk )
	begin
		if ( rst )
		begin
			WB_Reg = 0;
			MEM_Reg = 0;
			ALU_Reg = 0;
			WD_Out = 0;
			Reg_RegRd = 0;
		end
		else
		begin
			WB_Reg 		<= WB;
			MEM_Reg 	<= MEM;
			ALU_Reg 	<= ALUOut;
			Reg_RegRd	<= Reg_rd;
			WD_Out 		<= WD_In;	
		end
	end
	
endmodule