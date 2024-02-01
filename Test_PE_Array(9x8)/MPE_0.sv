	module MPE_0 #(
    parameter DATA_WIDTH = 32
)
(
    input i_clk,
    input i_rest_n,
    input weight_en,
    input i_left_en,
    input i_right_en,

	input [DATA_WIDTH - 1 : 0] i_fmap_f_left,
    input [DATA_WIDTH - 1 : 0] weight_f_top,
    input [DATA_WIDTH - 1 : 0] psum_f_top,
    output reg [DATA_WIDTH - 1 : 0] i_fmap_t_right,
    output  [DATA_WIDTH - 1 : 0] psum_t_down

);  
    reg [DATA_WIDTH - 1 : 0] weight;
    reg [DATA_WIDTH - 1 : 0] i_left;
//    reg  [DATA_WIDTH - 1 : 0] psum;
    wire [DATA_WIDTH - 1 : 0] multiplication;
	 
    always@(posedge i_clk, negedge i_rest_n) begin
        if(!i_rest_n)begin
            weight <= 32'h0;
        end
        else if(weight_en)begin
            weight <= weight_f_top;
        end
    end
    always@(posedge i_clk, negedge i_rest_n) begin
            if(!i_rest_n)begin
                i_left <= 32'h0;
            end
            else if(i_left_en)begin
                i_left <= i_fmap_f_left;
            end
    end
    always@(posedge i_clk, negedge i_rest_n)begin
            if(!i_rest_n)begin
                i_fmap_t_right <= 32'h0;
            end
            else if(i_right_en)begin
                i_fmap_t_right <= i_fmap_f_left;
            end
				else i_fmap_t_right <= i_fmap_t_right;
    end
    

	 
	 
	 FPU_mul mul(
			.clk(i_clk),
			.areset(1'b0),
			.a(i_left),
			.b(weight),
			.q(multiplication)
		);
	 FPU_add_sub add(
			.clk(i_clk),
			.areset(1'b0),
			.a(multiplication),
			.b(psum),
			.q(psum_t_down)
			
		);
				

endmodule 