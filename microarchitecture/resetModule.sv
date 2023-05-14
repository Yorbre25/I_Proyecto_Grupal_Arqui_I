module resetModule(input rst,flush1,flush2,flush3,flush4,flush5,stall,output rst1,rst2,rst3,rst4,rst5); // IFID IDEX EXMEM MEMWB

	assign rst1=rst | flush1; //pc
	assign rst2=rst | flush2; //IF
	assign rst3=rst | flush3 ; //ID
	assign rst4=rst | flush4| stall; //EX
	assign rst5= rst |flush5; // MEM

endmodule 