module branchTaken_tb();

	logic [1:0] opType;
	logic [3:0] opCode;
	logic [1:0] flags;
	logic branchTakenFlag;
	
	
	branchTaken myBranchTakenFlag(.opType(opType),.opCode(opCode),.flags(flags),.branchTakenFlag(branchTakenFlag));
	
	
	initial begin
		#10;
		opType=2'b00;
		opCode=4'b0010;
		flags=2'b00;
		#10;
		assert(branchTakenFlag==0) $display("Bandera de salto en bajo en operacion aritmetica sin inmediato");
		else $error("Bandera de salto en alto en operacion aritmetica sin inmediato");
		
		#10;
		opType=2'b01;
		#10;
		opCode=4'b1000;
		assert(branchTakenFlag==0) $display("Bandera de salto en bajo en operacion aritmetica con inmediato");
		else $error("Bandera de salto en alto en operacion aritmetica con inmediato");
		
		#10;
		
		opType=2'b10;
		opCode=4'b0011;
		#10;
		assert(branchTakenFlag==0) $display("Bandera de salto en bajo en operacion de memoria");
		else $error("Bandera de salto en alto en operacion de memoria");
		
		#10;
		
		opType=2'b11;
		opCode=4'b0000;
		flags=2'b11;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto tomada en salto incondicional");
		else $error("Bandera de salto no tomada en salto incondicional");
		
		#10;
		opCode=4'b0001;
		flags=2'b01;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto tomada en be con banderas 01");
		else $error("Bandera de salto no tomada en be con banderas 01");
		
		#10;
		opCode=4'b0001;
		flags=2'b00;
		#10;
		assert(!branchTakenFlag) $display("Bandera de salto no tomada en be con banderas 00");
		else $error("Bandera de salto tomada en be con banderas 00");
		
		
		#10;
		opCode=4'b0010;
		flags=2'b00;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto tomada en bne con banderas 00");
		else $error("Bandera de salto no tomada en bne con banderas 00");
		
		#10;
		opCode=4'b0010;
		flags=2'b11;
		#10;
		assert(!branchTakenFlag) $display("Bandera de salto no tomada en bne con banderas 11");
		else $error("Bandera de salto tomada en bne con banderas 11");
		
		
		#10;
		opCode=4'b0011;
		flags=2'b00;
		#10;
		assert(!branchTakenFlag) $display("Bandera de salto no tomada en ble con banderas 00");
		else $error("Bandera de salto tomada en ble con banderas 00");
		
		
		#10;
		opCode=4'b0011;
		flags=2'b01;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto  tomada en ble con banderas 01");
		else $error("Bandera de salto no tomada en ble con banderas 01");
		
		
		#10;
		opCode=4'b0011;
		flags=2'b10;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto  tomada en ble con banderas 10");
		else $error("Bandera de salto no tomada en ble con banderas 10");
		
		#10;
		opCode=4'b0011;
		flags=2'b11;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto  tomada en ble con banderas 11");
		else $error("Bandera de salto no tomada en ble con banderas 11");
		
		
		#10;
		opCode=4'b0100;
		flags=2'b00;
		#10;
		assert(branchTakenFlag) $display("Bandera de salto  tomada en bg con banderas 00");
		else $error("Bandera de salto no tomada en ble con banderas 00");
		
		
		#10;
		opCode=4'b0100;
		flags=2'b01;
		#10;
		assert(!branchTakenFlag) $display("Bandera de salto no tomada en bg con banderas 01");
		else $error("Bandera de salto tomada en ble con banderas 01");
		
		
		
		#10;
		opCode=4'b0100;
		flags=2'b10;
		#10;
		assert(!branchTakenFlag) $display("Bandera de salto no tomada en bg con banderas 10");
		else $error("Bandera de salto tomada en ble con banderas 10");
		
		
		#10;
		opCode=4'b0100;
		flags=2'b11;
		#10;
		assert(!branchTakenFlag) $display("Bandera de salto no tomada en bg con banderas 11");
		else $error("Bandera de salto tomada en ble con banderas 11");
		
		
		#10;
		$finish();
		
	end

endmodule 