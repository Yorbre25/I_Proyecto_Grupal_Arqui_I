module branchTaken(input [1:0] opType,input [3:0] opCode,input [1:0] flags,output logic branchTakenFlag); //flags 1: negative 0:zero

	always_comb begin
		case({opType,opCode})
		
			6'b110000: branchTakenFlag=1;
			6'b110001: branchTakenFlag= flags[0];
			6'b110010: branchTakenFlag= !flags[0];
			6'b110011: branchTakenFlag= flags[0] | flags[1];
			6'b110100: branchTakenFlag= !flags[0] & !flags[1];
			default: branchTakenFlag=0;
		
		
		endcase
	
	end
endmodule 