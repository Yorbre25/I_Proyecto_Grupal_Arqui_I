`timescale 1ns/1ns
module memoryStage_tb();
	logic clk,rst,en,memWrite,memToReg,regWrite;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic [23:0] address1,address2;
	logic [3:0] Rc,switches;
	logic [23:0] writeData,q;
	logic [35:0] gpio1,gpio2;
	logic [59:0] bufferOut;
	
	logic [60:0] bufferInput,out;

	memoryStage myMemoryStage(.clk(clk),.rst(rst),.en(en),.opType(out[57:56]),.opCode(out[55:52]),.address1(out[51:28]),
	.address2(address2),.memWrite(out[60]),.memToReg(out[59]),.regWrite(out[58]),
	.Rc(out[27:24]),.writeData(out[23:0]),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.q(q),.bufferOut(bufferOut));
	
	
	buffer #(.Buffer_size(61)) myBuffer(.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(out));
	
	
	assign bufferInput={memWrite,memToReg,regWrite,opType,opCode,address1,Rc,writeData};
	
	always begin
	
		#10;
		clk=!clk;
	end
	
	initial begin
	
		
		clk=1;
		rst=1;
		en=0;
		memWrite=1;
		memToReg=0;
		regWrite=0;
		opType=2;
		opCode=9;
		address1=500;
		address2=0;
		Rc=12;
		switches=4'b1101;
		writeData=35;
		gpio1=23;
		
		#10; //negedge(escribe buffer de entrada)
		rst=0;
		en=1;

		
		#10;//posedge (escribe a memoria)
		
		
		#10; //negedge (escribe buffer de salida)
		memWrite=0;
		memToReg=0;
		regWrite=0;
		opType=1;
		opCode=4;
		address1=700;
		address2=0;
		Rc=12;
		switches=4'b1101;
		writeData=90;
		gpio1=23;
		
		#10; //posedge (lectura prueba)
		
		
		assert(bufferOut[59:52]==8'b10100100) $display("Banderas correctas");
		else $error("banderas incorrectas");
		
		assert(bufferOut[47:24]==35) $display("salida de memoria correcta en escritura actual");
		else $error("Salida de memoria incorrecta");
		
		assert(bufferOut[23:0]==500) $display("Address de salida correcta de instrucion salida en estapa");
		else $error("Address salida incorrecta");
		#10; //negede
		
		
		#10;//posedge
		assert(bufferOut[59:52]==8'b01010000) $display("Banderas correctas");
		else $error("banderas incorrectas");
		
		
		#10; //negedge
		address1=500;
		
		#10;//posedge
		
		
		#10;// negedge
		
		#10; //posedge
		assert(bufferOut[47:24]==35) $display("salida de memoria escrita en previa instrucion correcta");
		else $error("salida de memoria escrita en previa instrucion incorrecta");
		#10;
		
		
	
	end

	endmodule 