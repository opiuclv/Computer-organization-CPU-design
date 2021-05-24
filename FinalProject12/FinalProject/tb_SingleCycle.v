/*
	Title: MIPS Single Cycle CPU Testbench
	Author: Selene (Computer System and Architecture Lab, ICE, CYCU) 
*/

// `timescale 1ns/1ns

module tb_SingleCycle();

	reg clk, rst;
	
	// ²£¥Í®É¯ß¡A¶g´Á¡G10ns
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		/*
			«ü¥O¸ê®Æ°O¾ÐÅé¡AÀÉ¦W"instr_mem.txt, data_mem.txt"¥i¦Û¦æ­×§ï
			¨C¤@¦æ¬°1 Byte¸ê®Æ¡A¥H¨â­Ó¤Q¤»¶i¦ì¼Æ¦rªí¥Ü
			¥B¬°Little Endian½s½X
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// ³]©w¼È¦s¾¹ªì©l­È¡A¨C¤@¦æ¬°¤@µ§¼È¦s¾¹¸ê®Æ
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc );
		if ( CPU.opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.rfile_wd );
			if ( CPU.funct == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.funct == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.funct == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.funct == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
		end
		else if ( CPU.opcode == 6'd35 ) $display( "%d, LW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd43 ) $display( "%d, SW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd4 ) $display( "%d, BEQ\n", $time/10-1 );
		else if ( CPU.opcode == 6'd2 ) $display( "%d, J\n", $time/10-1 );
	end
	
	mips_single CPU( clk, rst );

endmodule
