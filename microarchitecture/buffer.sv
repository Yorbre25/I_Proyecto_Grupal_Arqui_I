module buffer #(parameter Buffer_size=32)(input rst,clk,en,input [Buffer_size-1:0] bufferInput,output logic [Buffer_size-1:0] bufferOut);
	logic [Buffer_size-1:0] state;
	
	always_ff @(negedge clk)begin
		if(rst) state[Buffer_size-1:0]=0;
		else begin
			if(en)state=bufferInput;
		end
	end
	always_ff @(posedge clk)begin
		bufferOut=state;
	end


endmodule 