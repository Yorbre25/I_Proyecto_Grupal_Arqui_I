module hazardUnit(input [3:0] Ra,Rb,Rd_EXMEM,Rd_MEMWB,input  [1:0] opType,input  [3:0] opCode,input [31:0] aluResult,Result,input  branchTakenFlag,output Fa,Fb,stall,flush1,flush2,flush3,flush4,flush5,output logic [31:0] Forward1,Forward2);

	logic flushCondition,ldFlag;
	
	
	assign ldFlag= (opType==2'b10) & (opCode==4'b0000);
	assign stall = ((Ra==Rd_EXMEM) & ldFlag) | ((Rb==Rd_EXMEM) & ldFlag);
	assign flushCondition=branchTakenFlag;
	assign flush1=0;
	assign flush2=flushCondition;
	assign flush3=flushCondition;
	assign flush4=flushCondition;
	assign flush5=0;
	assign Fa= (Ra==Rd_EXMEM) | (Ra==Rd_MEMWB);
	assign Fb= (Rb==Rd_EXMEM) | (Rb==Rd_MEMWB);
	always_comb begin
	
		if(Ra==Rd_EXMEM)Forward1=aluResult;
		else Forward1=Result;
	end
	
	
	always_comb begin
		if(Rb==Rd_EXMEM)Forward2=aluResult;
		else Forward2=Result;
	end
	

endmodule 