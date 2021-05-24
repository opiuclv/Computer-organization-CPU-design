module IF_ID( clk, rst, PC_Plus4, Inst, Inst_Reg, PC_Plus4_Reg );

	input [31:0] PC_Plus4, Inst;
	input clk, rst ;
	output reg [31:0] Inst_Reg, PC_Plus4_Reg;

	always@( posedge clk )
	begin
		if ( rst )
		begin
			Inst_Reg = 0;
			PC_Plus4_Reg = 0;			
		end
		else
		begin
			Inst_Reg <= Inst;
			PC_Plus4_Reg <= PC_Plus4;
		end
	end
	
endmodule 