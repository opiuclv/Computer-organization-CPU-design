module mips_pipelined( clk, rst, en );
	input clk, rst, en;
	
	// instruction bus
	wire[31:0] instr, instr_out;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rt_out, rd, rd_out, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, zeroextend_immed, EX_immed, EX_immed_out, b_offset;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn, rfile_wn_out, rfile_wn_out2;
    wire [31:0] rfile_rd1, rd1_out, alu_a, rfile_rd2, rd2_out, rd2_out2, rfile_wd, alu_b,
				alu_out, alu_out_out, alu_out_out2, b_tgt, b_tgt_out, pc_next,
                pc, pc_incr, pc_incr_out, pc_incr_out2, dmem_rdata, dmem_rdata_out, jump_addr, branch_addr;

	// control signals
    wire RegWrite, RegWrite_out, RegWrite_out2, RegWrite_out3, Branch, Branch_out, Branch_out2, PCSrc,
		 RegDst, RegDst_out, MemtoReg, MemtoReg_out, MemtoReg_out2, MemtoReg_out3, MemRead, MemRead_out,
		 MemRead_out2, MemWrite, MemWrite_out, MemWrite_out2, ALUSrc, ALUSrc_out, Zero, Zero_out, Jump, sll, Ori ;
    wire [1:0] ALUOp, ALUOp_out;
    wire [3:0] Operation;
	
	
    assign opcode = instr_out[31:26];
    assign rs = instr_out[25:21];
    assign rt = instr_out[20:16];
    assign rd = instr_out[15:11];
    //assign shamt = instr_out[10:6];
    assign funct = EX_immed_out[5:0];
    assign immed = instr_out[15:0];
    assign jumpoffset = instr_out[25:0];
	
	// branch offset shifter
    assign b_offset = EX_immed_out << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_incr_out[31:28], jumpoffset <<2 };

	// module instantiations
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(branch_addr), .d_out(pc) );
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) ); //    extend ****************************************************
	
	zero_extend ZeroExt( .immed_in(immed), .ext_immed_out(zeroextend_immed) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );

    add32 BRADD( .a(pc_incr_out2), .b(b_offset), .result(b_tgt) );

    //alu ALU( .ctl(Operation), .a(rfile_rd1), .b(alu_b), .result(alu_out), .zero(Zero) );
    TotalALU ALU( .clk(clk), .dataA(alu_a), .dataB(alu_b), .Signal(Operation), .Output(alu_out), .reset(rst), .zero(Zero) );
	
    and BR_AND(PCSrc, Branch, Zero_out);

    mux2 #(5) RFMUX( .sel(RegDst_out), .a(rt_out), .b(rd_out), .y(rfile_wn) );

    mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt_out), .y(branch_addr) );
	
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );
	
    mux2 #(32) ALUbMUX( .sel(ALUSrc_out), .a(rd2_out), .b(EX_immed_out), .y(alu_b) );

   	mux2 #(32) ALUaMUX( .sel(sll), .a(rd1_out), .b(EX_immed_out), .y(alu_a) );
	
    mux2 #(32) WRMUX( .sel(MemtoReg_out3), .a(alu_out_out2), .b(dmem_rdata_out), .y(rfile_wd) );

	mux2 #(32) ORIMUX( .sel(Ori), .a(extend_immed), .b(zeroextend_immed), .y(EX_immed) );
	
    control_single CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), .Ori(Ori) );

    alu_ctl ALUCTL( .ALUOp(ALUOp_out), .Funct(funct), .ALUOperation(Operation), .sll(sll) );
	

	reg_file RegFile( .clk(clk), .RegWrite(RegWrite_out3), .RN1(rs), .RN2(rt), .WN(rfile_wn_out2), 
					  .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );

	memory DatMem( .clk(clk), .MemRead(MemRead_out2), .MemWrite(MemWrite_out2), .wd(rd2_out2), 
				   .addr(alu_out_out), .rd(dmem_rdata) );	   
				   
	// pipelined
	IF_ID if_id( .clk(clk), .rst(rst), .en(en), .pc_incr_in(pc_incr), .pc_incr_out(pc_incr_out), .instr_in(instr), .instr_out(instr_out) ) ;
	
	ID_EX id_ex( .clk(clk), .rst(rst), .en(en), .rd1_in(rfile_rd1), .rd1_out(rd1_out), .rd2_in(rfile_rd2), .rd2_out(rd2_out),
				 .extend_immed_in(EX_immed), .extend_immed_out(EX_immed_out), .pc_incr_in(pc_incr_out), .pc_incr_out(pc_incr_out2),
				 .rt_in(rt), .rt_out(rt_out), .rd_in(rd), .rd_out(rd_out), .ALUOp_in(ALUOp), .ALUOp_out(ALUOp_out),
			     .RegDst_in(RegDst), .RegDst_out(RegDst_out), .ALUSrc_in(ALUSrc), .ALUSrc_out(ALUSrc_out), .Branch_in(Branch), .Branch_out(Branch_out),
			     .MemRead_in(MemRead), .MemRead_out(MemRead_out), .MemWrite_in(MemWrite), .MemWrite_out(MemWrite_out),
				 .RegWrite_in(RegWrite), .RegWrite_out(RegWrite_out), .MemtoReg_in(MemtoReg), .MemtoReg_out(MemtoReg_out) ) ;
	
	EX_MEM ex_mem( .clk(clk), .rst(rst), .en(en), .b_tgt_in(b_tgt), .b_tgt_out(b_tgt_out), .alu_out_in(alu_out), .alu_out_out(alu_out_out),
				   .rd2_in(rd2_out), .rd2_out(rd2_out2), .rfile_wn_in(rfile_wn), .rfile_wn_out(rfile_wn_out), .zero_in(Zero), .zero_out(Zero_out),
				   .Branch_in(Branch_out), .Branch_out(Branch_out2), .MemRead_in(MemRead_out), .MemRead_out(MemRead_out2), .MemWrite_in(MemWrite_out),
				   .MemWrite_out(MemWrite_out2), .RegWrite_in(RegWrite_out), .RegWrite_out(RegWrite_out2), .MemtoReg_in(MemtoReg_out), .MemtoReg_out(MemtoReg_out2) ) ;

	MEM_WB mem_wb( .clk(clk), .rst(rst), .en(en), .dmem_rdata_in(dmem_rdata), .dmem_rdata_out(dmem_rdata_out), .alu_out_in(alu_out_out), .alu_out_out(alu_out_out2),
				   .rfile_wn_in(rfile_wn_out), .rfile_wn_out(rfile_wn_out2), .RegWrite_in(RegWrite_out2), .RegWrite_out(RegWrite_out3),
				   .MemtoReg_in(MemtoReg_out2), .MemtoReg_out(MemtoReg_out3) ) ;
endmodule
