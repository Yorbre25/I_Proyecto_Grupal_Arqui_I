module memWriteControl(input [1:0] opType, input [3:0] opCode,output logic memWrite);

	always_comb begin
	
		if(opType==2'b10 && opCode==4'b0001)memWrite=1'b1;
		else memWrite=1'b0;
	end
endmodule 