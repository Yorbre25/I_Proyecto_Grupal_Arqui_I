module loadFlag(input [1:0] opType,input [3:0] opCode,output logic ldFlag);
	assign ldFlag= (opType==2'b10) & (opCode==4'b0000);

endmodule 