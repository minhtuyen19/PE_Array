
`timescale 10 ps/1 ps
module tb();
	parameter DATA_WIDTH = 32;
   parameter NUMBER_PE_COL = 8; //number PE in a row
	parameter NUMBER_PE_ROW = 9; //number PE in a col
	 
    reg i_clk;
    reg i_rest_n;
	reg weight_en;
	reg [NUMBER_PE_ROW - 1 : 0] i_left_en [NUMBER_PE_COL - 1 : 0]; //[9]a[8]
	reg [NUMBER_PE_ROW - 1 : 0] i_right_en [NUMBER_PE_COL - 1 : 0];
	
	reg [DATA_WIDTH - 1 : 0] i_fmap_f_left [NUMBER_PE_ROW - 1 : 0];
	reg [DATA_WIDTH*NUMBER_PE_ROW - 1 : 0] weight_f_top[NUMBER_PE_COL - 1 : 0];  //[32x9]

	reg [DATA_WIDTH - 1 : 0] psum_f_top [NUMBER_PE_COL - 1 : 0];
	wire [DATA_WIDTH - 1 : 0] psum_t_down [NUMBER_PE_COL - 1 : 0];


	reg [DATA_WIDTH - 1 : 0]mem1[NUMBER_PE_ROW - 1 : 0];
	reg [DATA_WIDTH*NUMBER_PE_ROW - 1 : 0]mem2[NUMBER_PE_COL - 1 : 0];
	integer i, j, m;
 
	PE_fpu #(
		.DATA_WIDTH(DATA_WIDTH),
		.NUMBER_PE_COL(NUMBER_PE_COL),
		.NUMBER_PE_ROW(NUMBER_PE_ROW)
	) DUT (
		.i_clk(i_clk),
		.i_rest_n(i_rest_n),
		.weight_en(weight_en),
		.i_left_en(i_left_en),
		.i_right_en(i_right_en),
		.i_fmap_f_left(i_fmap_f_left),
		.weight_f_top (weight_f_top),
		.psum_f_top(psum_f_top),
		.psum_t_down(psum_t_down)
	);

	initial begin
		i_clk = 0;
		forever #5 i_clk = !i_clk;
	end

	initial begin
		for(m = 0; m < NUMBER_PE_COL; m = m + 1)begin
			psum_f_top[m] = 32'h0;
		end
	end

	initial begin
		i_rest_n = 1'b0;
		weight_en = 1'b0;
		for(i = 0; i < 9; i = i + 1)begin
			for(j = 0; j < 8; j = j + 1)begin
				i_left_en[i][j] = 1'b0;
				i_right_en[i][j] = 1'b0;
			end
		end


	#10 
	i_rest_n = 1'b1;
	weight_en = 1'b1;

	$readmemh("weight8x9_hex.txt", mem2);
	$readmemh("input8x9_hex.txt", mem1);
	$display("Start test");
	for(i = 0; i < 8; i = i + 1)begin
		weight_f_top[i] = mem2[i];
	end

	#10
	for(i = 0; i < 9; i = i+1)begin
		#10
		for(j = 0; j < 9; j = j+1)begin
			#10
			i_fmap_f_left[i] = mem1[i*9+j];
		end
	end
	#200 $finish;
	end
endmodule 