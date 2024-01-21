`timescale 1 ps/1 ps
module controller_tb();

    parameter DATA_WIDTH = 32;
    parameter KERNEL_SIZE = 9;
    parameter NUM_KERNEL = 64;

    reg clk;
    reg rst_n;
    reg [DATA_WIDTH*KERNEL_SIZE - 1 : 0]i_image;
    wire [DATA_WIDTH - 1 : 0] o_image [0 : NUM_KERNEL];




    PEArray # (
        .DATA_WIDTH(DATA_WIDTH),
        .KERNEL_SIZE(KERNEL_SIZE),
        .NUM_KERNEL(NUM_KERNEL)
    ) DUT (

        .clk(clk),
        .rst_n(rst_n),
        .i_image(i_image),
        .o_image(o_image)
    );

	 initial begin
			clk = 0;
			forever #5 clk = !clk;
	 end
	
	initial begin
		rst_n = 1'b0;

		#10
		rst_n = 1'b1;

        //Input
        i_image = 288'hBDAC8916_BB9FA730_3DD99A1B_3E0D4FFB_3DFA1D08_3DB9172E_BB9FA730_BD8C0629_BDED8EF1;
		
        #10
        i_image = 288'hBE78D32E_BE6891B7_BE9CEC84_BE94CBC9_BE8CAB0E_BEB54EB6_BEE6131A_BF075B62_BF1FBD94;
		#200 $finish;
		
		

	end

    
endmodule


