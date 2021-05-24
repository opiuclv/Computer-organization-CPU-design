module ID_EX( clk, rst, WB,     MEM,     EX,     dataA,     dataB,     immed_in,     Reg_rt,    Reg_rd, 
				        WB_Reg, MEM_Reg, EX_Reg, dataA_Reg, dataB_Reg, immed_in_Reg, Reg_RegRt, Reg_RegRd );
	input clk, rst;
	input [1:0] WB;
	input [1:0] MEM;
	input [3:0] EX;
	input [4:0] Reg_rt, Reg_rd;
	input [31:0] dataA, dataB, immed_in;
	output reg [1:0] WB_Reg;
	output reg [1:0] MEM_Reg;
	output reg [3:0] EX_Reg;
	output reg [4:0] Reg_RegRt, Reg_RegRd;
	output reg [31:0] dataA_Reg, dataB_Reg, immed_in_Reg;

	always@( posedge clk )
	begin
		if ( rst )
		begin
			WB_Reg = 0; 
			MEM_Reg = 0;
			EX_Reg = 0;
			dataA_Reg = 0;
			dataB_Reg = 0;
			immed_in_Reg = 0;
			Reg_RegRt = 0;
			Reg_RegRd = 0;
		end
		else
		begin
			WB_Reg			<= WB;
			MEM_Reg			<= MEM;
			EX_Reg			<= EX;
			dataA_Reg		<= dataA;
			dataB_Reg 		<= dataB;
			immed_in_Reg 	<= immed_in;
			Reg_RegRt 		<= Reg_rt;
			Reg_RegRd 		<= Reg_rd;
		end
	end

endmodule