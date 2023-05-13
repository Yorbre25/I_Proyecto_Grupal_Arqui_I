module regWriteControl(input [1:0] opType,input [3:0] opCode,Rd,output logic regWrite);
	always_comb begin
		if(Rd==4'b0000)regWrite=0;
		else if(!opType[1])regWrite=1; //operaciones de arit/log con y sin inmediato
		else if(opType==2'b10 && opCode==4'b0000)regWrite=1;
		else regWrite=0;
	end
endmodule 