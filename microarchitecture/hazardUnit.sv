module hazardUnit(input [3:0] Ra,Rb,Rd_EXMEM,Rd_MEMWB,input  [1:0] opTypeMem,opTypeWB,input  [3:0] opCodeMem,opCodeWB,input [23:0] aluResult,Result,input  branchTakenFlag,output Fa,Fb,stall,flush1,flush2,flush3,flush4,flush5,output logic [23:0] Forward1,Forward2);

	logic flushCondition,ldFlag,writtenOnMem,writtenOnWB;
	
	
	assign ldFlag= (opTypeMem==2'b10) & (opCodeMem==4'b0000);
	assign writtenOnMem= !opTypeMem[1] | (opTypeMem==2'b10 & opCodeMem==0);
	assign writtenOnWB= !opTypeWB[1] | (opTypeWB==2'b10 & opCodeWB==0); 
	
	
	assign stall = ((Ra==Rd_EXMEM) & ldFlag) | ((Rb==Rd_EXMEM) & ldFlag);
	assign flushCondition=branchTakenFlag;
	assign flush1=0;
	assign flush2=flushCondition;
	assign flush3=flushCondition;
	assign flush4=flushCondition;
	assign flush5=0;
	assign Fa= (Ra==Rd_EXMEM & writtenOnMem & Ra!=0) | (Ra==Rd_MEMWB & writtenOnWB & Ra!=0);
	assign Fb= (Rb==Rd_EXMEM & writtenOnMem & Rb!=0) | (Rb==Rd_MEMWB & writtenOnWB & Rb!=0);
	always_comb begin
	
		if(Ra==Rd_EXMEM)Forward1=aluResult;
		else Forward1=Result;
	end
	
	
	always_comb begin
		if(Rb==Rd_EXMEM)Forward2=aluResult;
		else Forward2=Result;
	end
	

endmodule 