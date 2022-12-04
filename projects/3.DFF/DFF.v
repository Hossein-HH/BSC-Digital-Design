module DFF (input d,
             input rstn,
             input clk,
             output reg q);
    always @ (posedge clk or negedge rstn)
       if (!rstn)
          q <= 0;
       else
          q <= d;
endmodule

module tb_DFF;
	reg clk;
	reg d;
	reg rstn;
	reg [2:0] delay;
integer i;

	DFF DFF0 ( .d(d),
		   .rstn (rstn),
		   .clk (clk),
                   .q (q));
	
	always #10 clk = ~clk;

	initial begin
	 	clk <= 0;
		d <= 0;
		rstn <= 0;

		#15
		d <= 1;
		#10
			rstn <= 1;

		for (i = 0; i < 5; i = i+1)
			begin
			delay = $random;
			#(delay) d <= i;
			end
		end
endmodule
			




























 