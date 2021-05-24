module MEM_WB( clk, rst, WB,     Memout,  ALUOut,  Reg_rd, 
					     WB_Reg, Mem_Reg, ALU_Reg, Reg_RegRd );

	input clk, rst;
	input [1:0] WB;
	input [4:0] Reg_rd;
	input [31:0] Memout, ALUOut;
	output reg [1:0] WB_Reg;
	output reg [31:0] Mem_Reg, ALU_Reg;
	output reg [4:0] Reg_RegRd;

	always@( posedge clk )
	begin
		if ( rst )
		begin
			WB_Reg = 0;
			Mem_Reg = 0;
			ALU_Reg = 0;
			Reg_RegRd = 0;
		end
		else
		begin
			WB_Reg <= WB;
			Mem_Reg <= Memout;
			ALU_Reg <= ALUOut;
			Reg_RegRd <= Reg_rd;		
		end
	end

endmodule