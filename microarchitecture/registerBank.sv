module registerBank #(parameter Index_size=4,parameter width=32)(input clk,rst, input [Index_size-1:0] Ra, Rb ,Rd, input WE,input [width-1:0] WD,output logic [width-1:0] RD1,RD2);
	logic [2**Index_size-1:0] [width-1:0] register;
	
	
	
	
	
	always_ff @(posedge clk) begin
		RD1=register[Ra];
		RD2=register[Rb];
	end
	

	always_ff @(negedge clk or posedge rst) begin
	  if(rst) begin
		register[2*Index_size-1:0]=0;
	  end
	  else begin
		if(WE & Rd!=0) register[Rd]=WD;
	  end
	end


endmodule 