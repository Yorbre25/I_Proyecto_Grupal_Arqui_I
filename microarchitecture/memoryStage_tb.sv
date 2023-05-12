`timescale 1ns/1ns
module memoryStage_tb();
	logic clk,rst,en,memWrite,memToReg,regWrite;
	logic [1:0] opType;
	logic [3:0] opCode;
	logic [23:0] address1,address2;
	logic [3:0] Rc,switches;
	logic [23:0] writeData,q;
	logic [35:0] gpio1,gpio2,bufferOut;
	

	memoryStage myMemoryStage(.clk(clk),.rst(rst),.en(en),.opType(opType),.opCode(opCode),.address1(address1),
	.address2(address2),.memWrite(memWrite),.memToReg(memToReg),.regWrite(regWrite),
	.Rc(Rc),.writeData(writeData),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.q(q),.bufferOut(bufferOut));
	
	
	always begin
	
		#10;
		clk=!clk;
	end
	
	initial begin
	
		
		clk=1;
		rst=1;
		en=0;
		memWrite=0;
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
		
		#10; //negedge
		
		#10;//posedge
		rst=0;
		en=1;
		memWrite=1;
		
		#10; //negedge (escribe buffer entrada)
		
		
		#10; //posedge (lee buffer entrada)
		
		
		#10; //negedge (escribe memoria, se lee memoria  y escribe en buffer)
		
		#10; //posedge (se lee buffer salida)
		
		
		#10; //negedge (delay de lectura necesario para simulacion)
		assert(bufferOut[35:28]=={opType,opCode,memToReg,regWrite}) $display("Banderas correctas");
		else $error("banderas incorrectas");
		
		assert(bufferOut[23:0]==writeData) $display("salida de memoria correcta");
		else $error("Salida de memoria incorrecta");
		
		#10;
		
		
		
	
	end

	endmodule 