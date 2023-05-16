`timescale 1ns/1ps

module instructionFetch_tb();

	logic clk,rst1,rst2;
	logic en1,en2,branchFlag;
	logic [23:0] branchAddr;
	logic [55:0] bufferOut;
	instructionFetch myInstructionFetch(.clk(clk),.rst1(rst1), .rst2(rst2), .en1(en1), .en2(en2),.branchFlag(branchFlag),.branchAddr(branchAddr),.bufferOut(bufferOut));
	
	
	always begin
		#10;
		clk=!clk;
		
	end
	
	initial begin
	
		clk=1;
		rst1=1;
		rst2=1;
		en1=1;
		en2=1;
		branchFlag=0;
		branchAddr=16;
		#10; //negedge
		
		#10;//posedge

		rst1=0;
		rst2=0;
		#10; //negedge

		#10;//posedge
		// test 0
		$display("Data: %b", bufferOut);
		assert(bufferOut[55:24] == 32'b01001100010000000000000001001010) $display("Instruccion 1 leida correctamente");
		else $error("Error al leer instruccion 1");
		#10; //negedge
		
		#10; //posedge
		$display("Data: %b", bufferOut);
		assert(bufferOut[55:24] == 32'b10000000010001000000000000000000) $display("Instruccion 2 leida correctamente");
		else $error("Error al leer instruccion 2");
		#20;
		branchFlag=1;
		branchAddr=0;
		en1=0;
		en2=0;
		#10;//negedge
		
		#10;//posedge
		en1=1;
		en2=1;
		
		#10;//negedge
		
		#10; //posedge
		branchAddr=12;
		
		#10; //negedge
		
		#10;//posedge

		branchFlag=0;
		#10;//negedge
		#10;//posedge
		$display("Data: %b", bufferOut);
		assert(bufferOut[55:24] == 32'b11010000000000111111111111110100) $display("Instrución después de salto (4) leída correctamente");
		else $error("Error en salto de linea");
		
		#100;
		$finish();
		
	end

endmodule 