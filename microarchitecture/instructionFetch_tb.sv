`timescale 1ns/1ps

module instructionFetch_tb();

	logic clk,rst,en,branchFlag;
	logic [31:0] branchAddr,instruction,pc;
	
	instructionFetch myInstructionFetch(.clk(clk),.rst(rst),.en(en),.branchFlag(branchFlag),.branchAddr(branchAddr),.instruction(instruction),.pc(pc));
	
	
	always begin
		#10;
		clk=!clk;
		
	end
	
	initial begin
	
		clk=1;
		rst=1;
		en=1;
		branchFlag=0;
		branchAddr=16;
		#10; //negedge
		
		#10;//posedge
		rst=0;
		#60; //posedge
		branchFlag=1;
		branchAddr=0;
		en=0;
		#10;//negedge
		
		#10;//posedge
		en=1;
		
		#10;//negedge
		
		#10; //posedge
		branchAddr=12;
		
		#10; //negedge
		
		#10;//posedge
		branchFlag=0;
		
		#100;
		$finish();
		
	end

endmodule 