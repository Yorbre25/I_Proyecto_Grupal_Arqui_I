module MainConnection(
	///////// FPGA /////////
      input              FPGA_CLK1_50,
      input              FPGA_CLK2_50,
      input              FPGA_CLK3_50,



      ///////// HDMI /////////
      inout              HDMI_I2C_SCL,
      inout              HDMI_I2C_SDA,
      inout              HDMI_I2S,
      inout              HDMI_LRCLK,
      inout              HDMI_MCLK,
      inout              HDMI_SCLK,
      output             HDMI_TX_CLK,
      output      [23:0] HDMI_TX_D,
      output             HDMI_TX_DE,
      output             HDMI_TX_HS,
      input              HDMI_TX_INT,
      output             HDMI_TX_VS,


      ///////// KEY /////////
      input       [1:0]  KEY,
		input [35:0] gpio1,
		input [3:0] switches,
		output [35:0] gpio2
		
		
);

reg [17:0] offset;
wire [7:0] q;

processor processor(.rst(switches[0]),
	.clk(FPGA_CLK1_50), 
	.gpio1(gpio1),
	.parallelAddress(parallelAddress),
	.switches(switches),
	.gpio2(gpio2),
	.q(q));
	
DE10_Nano_HDMI_TX hdmi(



      ///////// FPGA /////////
      .FPGA_CLK1_50(FPGA_CLK1_50),
      .FPGA_CLK2_50(FPGA_CLK2_50),
      .FPGA_CLK3_50(FPGA_CLK3_50),
		
		.offset(offset),
		.color(q),



      ///////// HDMI /////////
      .HDMI_I2C_SCL(HDMI_I2C_SCL),
      .HDMI_I2C_SDA(HDMI_I2C_SDA),
      .HDMI_I2S(HDMI_I2S),
      .HDMI_LRCLK(HDMI_LRCLK),
      .HDMI_MCLK(HDMI_MCLK),
      .HDMI_SCLK(HDMI_SCLK),
      .HDMI_TX_CLK(HDMI_TX_CLK),
      .HDMI_TX_D(HDMI_TX_D),
      .HDMI_TX_DE(HDMI_TX_DE),
      .HDMI_TX_HS(HDMI_TX_HS),
      .HDMI_TX_INT(HDMI_TX_INT),
      .HDMI_TX_VS(HDMI_TX_VS),



      ///////// KEY /////////
      .KEY(KEY)

);

endmodule
