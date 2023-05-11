module instructionDecode_tb();
	logic clk,rst,en,WE;
	logic [31:0] inst;
	logic [23:0] WD;
	logic [122:0] bufferOut;
	logic [3:0] Rd;
	
	instructionDecode myInstructionDecode(.clk(clk),.rst(rst),.en(en),.inst(inst),.WE(WE),.Rd(Rd),.WD(WD),.bufferOut(bufferOut));
	always begin
		#10;
		clk=!clk;
	end
	initial begin
		clk=1;
		rst=1;
		en=1;
		inst=32'b00100000010010101000000000000000; // not r1,r10 ## rb=r2
		WE=0;
		Rd=0;
		WD=0;
		#10; //negedge
		
		#10; //posedge
		rst=0;
		
		#10; //negedge
		
		
		#10; //posedge
		inst=32'b01010110100110000000000000001111; // div r10,r6,#15
		
		#10; //negedge
		assert(bufferOut[116:112]==5'b00001) $display("Test Aritmetico sin inmediato pasado");
		else $error("Test Aritmetico sin inmediato pasado fallado");
		
		assert(bufferOut[111:108]==4'b1000) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		
		assert(bufferOut[107:104]==4'b0010) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		
		
		assert(bufferOut[79:76]==4'b1010) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		
		
		assert(bufferOut[51:48]==4'b0001) $display("Rd verificado correctamente");
		else $error("Rd fallado");
		
		
		
		
		#10; //posedge
		inst=32'b10000011110000010000000000000000; // ld r15,[r0+r4]
		
		#10; //negedge
		assert(bufferOut[116:112]==5'b10001) $display("Test Aritmetico con inmediato pasado");
		else $error("Test Aritmetico con inmediato fallado");
		
		assert(bufferOut[111:108]==4'b0101) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		
		assert(bufferOut[107:104]==4'b0110) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		
		
		assert(bufferOut[23:0]==24'b000000000000000000001111) $display("Inmediato  verificado correctamente");
		else $error("Inmediato fallado fallado");
		
		assert(bufferOut[51:48]==4'b1010) $display("Rd verificado correctamente");
		else $error("Rd fallado");
		
		
		#10; //posedge
		inst=32'b11010000000000000000000000011010; //bg #26      11010
		
		#10;//negedge
		assert(bufferOut[116:112]==5'b00011) $display("Test de memoria pasado");
		else $error("Test de memoria fallado");
		
		assert(bufferOut[111:108]==4'b0010) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		
		
		assert(bufferOut[107:104]==4'b0000) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		
		
		assert(bufferOut[79:76]==4'b0100) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		
		
		assert(bufferOut[51:48]==4'b1111) $display("Rd verificado correctamente");
		else $error("Rd fallado");
		
		
		
		
		#10; //posedge
		inst=0; // sub r0,r0,r0
		
		#10; //negedge
		assert(bufferOut[116:112]==5'b11000) $display("Test salto pasado");
		else $error("Test salto fallado");
		
		assert(bufferOut[111:108]==4'b0010) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		

		assert(bufferOut[23:0]==24'b000000000000000000011010) $display("Inmediato salto branch  verificado correctamente");
		else $error("Inmediato salto branch fallado fallado");
		
		
		#10; //posedge
		
		#10; //negedge
		assert(bufferOut[116:112]==5'b00000) $display("No operation test pasado");
		else $error("No operation test fallado");
		
		assert(bufferOut[111:108]==4'b0000) $display("Opcode verificado correctamente");
		else $error("Verificacion opCode fallado");
		
		#50;
		
	end
endmodule 