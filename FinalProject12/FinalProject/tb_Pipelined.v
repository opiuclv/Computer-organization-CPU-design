/*
	Title: MIPS Pipelined CPU Testbench
	Editor: J4S0N.H
*/
module tb_Pipelined();
	reg clk, rst;
	
	// ���ͮɯߡA�g���G10ns
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		/*
			���O��ưO����A�ɦW"instr_mem.txt, data_mem.txt"�i�ۦ�ק�
			�C�@�欰1 Byte��ơA�H��ӤQ���i��Ʀr���
			�B��Little Endian�s�X
		*/
		$readmemh("instr_mem_1.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// �]�w�Ȧs����l�ȡA�C�@�欰�@���Ȧs�����
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc );
		if ( CPU.instr_IF[31:26] == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.rfile_wd );
			if ( CPU.instr_IF[5:0] == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.instr_IF[5:0] == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.instr_IF[5:0] == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.instr_IF[5:0] == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.instr_IF[5:0] == 6'd42 ) $display( "%d, SLT\n", $time/10-1 );
			else if ( CPU.instr_IF[5:0] == 6'd00 ) $display( "%d, SLL\n", $time/10-1);
			else if ( CPU.instr_IF[5:0] == 6'd08 ) $display( "%d, JR\n", $time/10-1);
			else if ( CPU.instr_IF[5:0] == 6'd27 ) $display( "%d, DIVU\n", $time/10-1);
			else if ( CPU.instr_IF[5:0] == 6'd16 ) $display( "%d, MFHI\n", $time/10-1);
			else if ( CPU.instr_IF[5:0] == 6'd18 ) $display( "%d, MFLO\n", $time/10-1);
		end
		else if ( CPU.instr_IF[31:26] == 6'd35 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.instr_IF[31:26] == 6'd43 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.instr_IF[31:26] == 6'd04 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.instr_IF[31:26] == 6'd02 ) $display( "%d, J\n", $time/10-1 );
		else if ( CPU.instr_IF[31:26] == 6'd12 ) $display( "%d, ANDI\n", $time/10-1 );
	end
	
	mips_single CPU( clk, rst );
	
endmodule
