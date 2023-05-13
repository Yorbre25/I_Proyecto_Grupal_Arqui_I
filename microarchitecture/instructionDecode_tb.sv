module instructionDecode_tb();
	logic clk,rst,en,WE;
	logic [31:0] inst,WD;
	logic [148:0] bufferOut;
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
		assert(bufferOut[148:144]==5'b00001) $display("Aritmetic Logic Test without an immediante passed");
		else $error("Aritmetic Logic Test without an immediante failed");
		
		assert(bufferOut[143:140]==4'b1000) $display("Op code proccessed propertly");
		else $error("Op code failed");
		
		assert(bufferOut[139:136]==4'b0010) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		
		
		assert(bufferOut[103:100]==4'b1010) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		
		
		assert(bufferOut[67:64]==4'b0001) $display("Rd verificado correctamente");
		else $error("Rd fallado");
		
		
		
		
		#10; //posedge
		inst=32'b10000011110000010000000000000000; // ld r15,[r0+r4]
		
		#10; //negedge
		assert(bufferOut[148:144]==5'b10001) $display("Aritmetic Logic Test with an immediante passed");
		else $error("Aritmetic Logic Test with an immediante failed");
		
		assert(bufferOut[143:140]==4'b0101) $display("Op code proccessed propertly");
		else $error("Op code failed");
		
		assert(bufferOut[139:136]==4'b0110) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		
		
		assert(bufferOut[31:0]==32'b00000000000000000000000000001111) $display("Inmediato  verificado correctamente");
		else $error("Inmediato fallado fallado");
		
		assert(bufferOut[67:64]==4'b1010) $display("Rd verificado correctamente");
		else $error("Rd fallado");
		
		
		#10; //posedge
		inst=32'b11010000000000000000000000011010; //bg #26      11010
		
		#10;//negedge
		assert(bufferOut[148:144]==5'b00011) $display("Memory test passed");
		else $error("Memory test failed");
		
		assert(bufferOut[143:140]==4'b0010) $display("Op code proccessed propertly");
		else $error("Op code failed");
		
		
		assert(bufferOut[139:136]==4'b0000) $display("Ra verificado correctamente");
		else $error("Ra fallado");
		
		
		assert(bufferOut[103:100]==4'b0100) $display("Rb verificado correctamente");
		else $error("Rb fallado");
		
		
		assert(bufferOut[67:64]==4'b1111) $display("Rd verificado correctamente");
		else $error("Rd fallado");
		
		
		
		
		#10; //posedge
		inst=0; // sub r0,r0,r0
		
		#10; //negedge
		assert(bufferOut[148:144]==5'b11000) $display("Branch test passed");
		else $error("Branch test failed");
		
		assert(bufferOut[143:140]==4'b0010) $display("Op code proccessed propertly");
		else $error("Op code failed");
		

		assert(bufferOut[31:0]==32'b00000000000000000000000000011010) $display("Inmediato salto branch  verificado correctamente");
		else $error("Inmediato salto branch fallado fallado");
		
		
		#10; //posedge
		
		#10; //negedge
		assert(bufferOut[148:144]==5'b00000) $display("No operation test passed");
		else $error("No operation test failed");
		
		assert(bufferOut[143:140]==4'b0000) $display("Op code proccessed propertly");
		else $error("Op code failed");
		
		#50;
		
	end
endmodule 