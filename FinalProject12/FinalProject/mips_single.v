//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_single( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr_IF, instr_ID;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt_ID, rd_ID, rt_EX, rd_EX, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed_ID, extend_immed_EX, sign_extend_immed , b_offset;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn_EX, rfile_wn_MEM, rfile_wn_WB;
    wire [31:0] rfile_rd1_ID, rfile_rd2_ID, rfile_rd1_EX, rfile_rd2_EX, rfile_rd2_MEM, rfile_wd, alu_b, alu_out_EX, alu_out_MEM, alu_out_WB, b_tgt, pc_br_jump, pc_next,
                pc, dmem_rdata_MEM, dmem_rdata_WB, jump_addr, branch_addr;
	wire [31:0] pc_plus4_IF, pc_plus4_ID, alu_result ;			

	// control signals
	wire RegDst_ID, ALUSrc_ID, MemRead_ID, MemWrite_ID, RegWrite_ID, MemtoReg_ID;
	wire RegDst_EX, ALUSrc_EX;
	wire MemWrite_MEM, MemRead_MEM;
	wire RegWrite_WB, MemtoReg_WB;
	wire PCSrc, Zero, Jumpr, SignOrUnsign, Branch, Jump ;
    wire [1:0] ALUOp_ID, ALUOp_EX ;
    wire [2:0] Operation;
	
	wire [3:0] EX_1, EX_2;
	wire [1:0] MEM_1, MEM_2, MEM_3;
	wire [1:0] WB_1, WB_2, WB_3, WB_4;
		
    assign opcode = instr_ID[31:26];
    assign rs = instr_ID[25:21];
    assign rt_ID = instr_ID[20:16];
    assign rd_ID = instr_ID[15:11];
    assign shamt = extend_immed_EX[10:6];
    assign funct = extend_immed_EX[5:0];
    assign immed = instr_ID[15:0];
    assign jumpoffset = instr_ID[25:0];
	
	assign EX_1 = {ALUOp_ID, RegDst_ID, ALUSrc_ID};
	assign MEM_1 = {MemWrite_ID, MemRead_ID};
	assign WB_1 = {RegWrite_ID, MemtoReg_ID};
	
	assign ALUOp_EX  = EX_2[3:2];
	assign RegDst_EX = EX_2[1];
	assign ALUSrc_EX = EX_2[0];
	assign MemWrite_MEM = MEM_3[1];
	assign MemRead_MEM  = MEM_3[0];
	assign RegWrite_WB = WB_4[1];
	assign MemtoReg_WB = WB_4[0];
	
	// branch offset shifter
    assign b_offset = extend_immed_ID << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_plus4_ID[31:28], jumpoffset <<2 };

	// module instantiations
	
	IF_ID IF_ID_Reg( .clk(clk), .rst(rst), .PC_Plus4(pc_plus4_IF), .Inst(instr_IF), .Inst_Reg(instr_ID), .PC_Plus4_Reg(pc_plus4_ID) );
	
	ID_EX ID_EX_Reg( .clk(clk), .rst(rst), .WB(WB_1), .MEM(MEM_1), .EX(EX_1), .dataA(rfile_rd1_ID), .dataB(rfile_rd2_ID), .immed_in(extend_immed_ID), 
	.Reg_rt(rt_ID), .Reg_rd(rd_ID), .WB_Reg(WB_2), .MEM_Reg(MEM_2), .EX_Reg(EX_2), .dataA_Reg(rfile_rd1_EX), .dataB_Reg(rfile_rd2_EX), 
	.immed_in_Reg(extend_immed_EX), .Reg_RegRt(rt_EX), .Reg_RegRd(rd_EX) );
	
	EX_MEM EX_MEM_Reg( .clk(clk), .rst(rst), .WB(WB_2),     .MEM(MEM_2),     .ALUOut(alu_out_EX),  .Reg_rd(rfile_wn_EX),    .WD_In(rfile_rd2_EX), 
				                             .WB_Reg(WB_3), .MEM_Reg(MEM_3), .ALU_Reg(alu_out_MEM), .Reg_RegRd(rfile_wn_MEM), .WD_Out(rfile_rd2_MEM) );
	MEM_WB MEM_WB_Reg( .clk(clk), .rst(rst), .WB(WB_3),     .Memout(dmem_rdata_MEM),  .ALUOut(alu_out_MEM),  .Reg_rd(rfile_wn_MEM), 
					                         .WB_Reg(WB_4), .Mem_Reg(dmem_rdata_WB), .ALU_Reg(alu_out_WB), .Reg_RegRd(rfile_wn_WB) );
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(sign_extend_immed) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_plus4_IF) );

    add32 BRADD( .a(pc_plus4_ID), .b(b_offset), .result(b_tgt) );

    TotalALU ALU( .Signal(Operation), .dataA(rfile_rd1_EX), .dataB(alu_b), .Output(alu_result), .zero(Zero), .reset( rst ), .shamt( shamt ) );

    and BR_AND(PCSrc, Branch, Zero);

    mux2 #(5) RFMUX( .sel(RegDst_EX), .a(rd_EX), .b(rt_EX), .y(rfile_wn_EX) );

    mux2 #(32) PCMUX( .sel(PCSrc), .a(b_tgt), .b(pc_plus4_IF), .y(branch_addr) );
	
	mux2 #(32) JMUX( .sel(Jump), .a(jump_addr), .b(branch_addr), .y(pc_br_jump) );
	
    mux2 #(32) ALUMUX( .sel(ALUSrc_EX), .a(extend_immed_EX), .b(rfile_rd2_EX), .y(alu_b) );

    mux2 #(32) WRMUX( .sel(MemtoReg_WB), .a(alu_out_WB), .b(dmem_rdata_WB), .y(rfile_wd) );
	
	mux2 #(32) JRMUX( .sel(Jumpr), .a(rfile_rd1_EX), .b(pc_br_jump), .y(pc_next) );

    control_single CTL(.opcode(opcode), .RegDst(RegDst_ID), .ALUSrc(ALUSrc_ID), .MemtoReg(MemtoReg_ID), 
                          .RegWrite(RegWrite_ID), .MemRead(MemRead_ID), .MemWrite(MemWrite_ID), .Branch(Branch), 
                          .Jump(Jump), .ALUOp(ALUOp_ID));

    alu_ctl ALUCTL( .ALUOp(ALUOp), .Funct(funct), .ALUOperation(Operation), .Jumpr( Jumpr ) );
	

	reg_file RegFile( .clk(clk), .RegWrite(RegWrite_WB), .RN1(rs), .RN2(rt_ID), .WN(rfile_wn_WB), 
					  .WD(rfile_wd), .RD1(rfile_rd1_ID), .RD2(rfile_rd2_ID) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr_IF) );

	memory DatMem( .clk(clk), .MemRead(MemRead_MEM), .MemWrite(MemWrite_MEM), .wd(rfile_rd2_MEM), 
				   .addr(alu_out_MEM), .rd(dmem_rdata_MEM) );		   
				   
endmodule
