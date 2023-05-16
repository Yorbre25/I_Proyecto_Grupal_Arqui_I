module flagRegister(input rst,input [1:0] opType, input [3:0] opCode,input [1:0] newFlags,output [1:0] currentFlag);

	logic [1:0] flags;
	logic writtenRegister;
	
	assign writtenRegister= (opType==2'b00 & opCode==4'b0100) | (opType==2'b01 & opCode==4'b0100);
	always_ff @(*) begin
		if(rst)flags=0;
		else begin
			if(writtenRegister) begin
				flags=newFlags;
			end
		end
		
	end
	assign currentFlag=flags;

endmodule 