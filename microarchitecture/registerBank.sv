module registerBank #(parameter Index_size=4,parameter width=32)(input clk,rst, input [Index_size-1:0] Ra, Rb,Rc ,Rd, input WE,input [width-1:0] WD,output logic [width-1:0] RD1,RD2,RD3);
	logic [2**Index_size-1:0] [width-1:0] register;
	
	
	
	
	

	assign RD1=register[Ra];
	assign RD2=register[Rb];
	assign RD3=register[Rc];
	
	

	always_ff @(negedge clk or posedge rst) begin
	  if(rst) begin
		register[2**Index_size-1:0]=0;
	  end
	  else begin
		if(WE & Rd!=0) register[Rd]=WD;
	  end
	end


endmodule 