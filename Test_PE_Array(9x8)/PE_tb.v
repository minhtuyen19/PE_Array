`timescale 10ps/1ps
module PE_tb();
    parameter Data_width = 32;
    reg iClk;
    reg iRest_n;
    reg enable_w;

    reg Run;

    //reg data from
    reg [Data_width - 1: 0] Weight_f_top;
    reg [Data_width - 1: 0] Psum_f_top;
    reg [Data_width - 1: 0] Ifmap_f_left;

    //wire data to
    wire [Data_width - 1: 0] Ifmap_t_right;
    wire [Data_width - 1: 0] Psum_t_down;

    PE_fpu # (
        .Data_width(Data_width)
    )
    U1 (
        .iClk(iClk),
        .iRest_n(iRest_n),
        .enable_w(enable_w),
        .Run(Run),
        .Weight_f_top(Weight_f_top),
        .Psum_f_top(Psum_f_top),
        .Ifmap_f_left(Ifmap_f_left),
        .Ifmap_t_right(Ifmap_t_right),
        .Psum_t_down(Psum_t_down)
    );

    initial begin
        iClk = 1'b0;
        iRest_n = 1'b0;
        Psum_f_top = 32'b0;
        Run = 1'b0;
        forever begin
            #10 iClk = ~iClk;
        end
    end

    initial begin

        enable_w = 1'b0;
        #10 begin
            iRest_n = 1'b1;
            enable_w = 1'b1;
            Run = 1'b1;
        end
		  #10
		  Weight_f_top = 32'b10111101000000011101011000010100;
		  Ifmap_f_left = 32'b10111101101011001000100100010110;
		  Psum_f_top 	= 32'b00111100101110110111001100100100;
		  #10
		  Weight_f_top = 32'b10111011100111111010011100110000;
		  Ifmap_f_left = 32'b00111101000010101011100111110000;
		  Psum_f_top 	= 32'b00111101110001110011101100010010;
		  
    end

endmodule 
