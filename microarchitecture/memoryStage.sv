module memoryStage(input clk,rst,en,input [1:0] opType,input [3:0] opCode,input [23:0] address1,address2,input memWrite,memToReg,regWrite,input [3:0] Rc,input [23:0] writeData,input [3:0] switches,input [35:0] gpio1,output [35:0] gpio2,output [23:0] q,output [59:0] bufferOut);



	logic [23:0] qa;
	logic [59:0] bufferInput;
	dataMemory myDataMemory(.clk(clk),.rst(rst),.memWrite(memWrite),.address1(address1[18:0]),.address2(address2[18:0]),.data1(writeData),.data2({24{1'b0}}),.switches(switches),.gpio1(gpio1),.gpio2(gpio2),.qa(qa),.qb(q));
	
	
	buffer #(.Buffer_size(60)) myBuffer(.rst(rst),.clk(clk),.en(en),.bufferInput(bufferInput),.bufferOut(bufferOut));
	
	assign bufferInput={opType,opCode,memToReg,regWrite,Rc,qa,address1};
endmodule 