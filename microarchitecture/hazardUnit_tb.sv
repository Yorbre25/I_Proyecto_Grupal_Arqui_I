module hazardUnit_tb();
	logic [3:0] Ra,Rb,Rd_EXMEM,Rd_MEMWB;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic [31:0] aluResult,Result,Forward1,Forward2;
	logic branchTakenFlag,Fa,Fb,stall,flush1,flush2,flush3,flush4,flush5;
	hazardUnit myhazardUnit(.Ra(Ra),.Rb(Rb),.Rd_EXMEM(Rd_EXMEM),.Rd_MEMWB(Rd_MEMWB),.opType(opType),.opCode(opCode),.aluResult(aluResult),.Result(Result), .branchTakenFlag(branchTakenFlag),.Fa(Fa),.Fb(Fb),.stall(stall),.flush1(flush1),.flush2(flush2),.flush3(flush3),.flush4(flush4),.flush5(flush5), .Forward1(Forward1),.Forward2(Forward2));
	
	initial begin
	
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b1010;
		Rd_MEMWB=4'b1111;
		opType=2'b00;
		opCode=4'b0010;
		aluResult=10;
		Result=2;
		branchTakenFlag=0;
		
		#10;
		assert(stall==0) $display("stall no realizado cuando no han conflico");
		else $error("stall realizado sin conflicto");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==0) $display("Fa en bajo de forma correcta");
		else $error("Fa en alto incorrectamente");
		
		assert(Fb==0) $display("Fb en bajo de forma correcta");
		else $error("Fb en alto incorrectamente");
		
		
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0001;
		Rd_MEMWB=4'b1111;
		opType=2'b00;
		opCode=4'b0010;
		
		#10;
		assert(stall==0) $display("stall no realizado conflicto con unidad de adelantamiento");
		else $error("stall realizado conflicto con unidad de adelantamiento");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==1) $display("Fa en alto de forma correcta");
		else $error("Fa en bajo incorrectamente");
		
		assert(Fb==0) $display("Fb en bajo de forma correcta");
		else $error("Fb en alto incorrectamente");
		
		assert(Forward1==aluResult) $display("Operador 1 adelantado correctamente");
		else $error("Operador 1 adelantado incorrectamente");
		
		
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b1010;
		Rd_MEMWB=4'b0010;
		opType=2'b00;
		opCode=4'b0010;
		
		#10;
		assert(stall==0) $display("stall no realizado conflicto con unidad de adelantamiento");
		else $error("stall realizado conflicto con unidad de adelantamiento");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		assert(Fa==0) $display("Fa en bajo de forma correcta");
		else $error("Fa en alto incorrectamente");
		
		assert(Fb==1) $display("Fb en alto de forma correcta");
		else $error("Fb en bajo incorrectamente");
		
		assert(Forward2==Result) $display("Operador 2 adelantado correctamente");
		else $error("Operador 2 adelantado incorrectamente");
		
		
		
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opType=2'b10;
		opCode=4'b0000;
		
		#10;
		assert(stall==1) $display("stall realizado correctamente debido a ld imposible de unidad de adelantamiento");
		else $error("stall no realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opType=2'b11;
		opCode=4'b1011;
		branchTakenFlag=0;
		
		#10;
		assert(stall==0) $display("stall no realizado correctamente");
		else $error("stall realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==0) $display("Flush 2 no realizado correctamente");
		else $error("Flush 2 realizado incorrectamente");
		
		assert(flush3==0) $display("Flush 3 no realizado correctamente");
		else $error("Flush 3 realizado incorrectamente");
		
		assert(flush4==0) $display("Flush 4 no realizado correctamente");
		else $error("Flush 4 realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		
		
		#10;
		Ra=4'b0001;
		Rb=4'b0010;
		Rd_EXMEM=4'b0010;
		Rd_MEMWB=4'b1010;
		opType=2'b11;
		opCode=4'b1011;
		branchTakenFlag=1;
		
		#10;
		assert(stall==0) $display("stall no realizado correctamente");
		else $error("stall realizado incorrectamente");
		
		assert(flush1==0) $display("Flush 1 no realizado correctamente");
		else $error("Flush 1 realizado incorrectamente");
		
		assert(flush2==1) $display("Flush 2  realizado correctamente");
		else $error("Flush 2 no realizado incorrectamente");
		
		assert(flush3==1) $display("Flush 3  realizado correctamente");
		else $error("Flush 3 no realizado incorrectamente");
		
		assert(flush4==1) $display("Flush 4 realizado correctamente");
		else $error("Flush 4 no realizado incorrectamente");
		
		assert(flush5==0) $display("Flush 5 no realizado correctamente");
		else $error("Flush 5 realizado incorrectamente");
		#10;
		
	end
endmodule 