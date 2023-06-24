`timescale 100ns / 10ns
module FPQ_test8 ;
  reg clk_1MHz ;
	reg rst_n ;
	wire [ 1:0 ] active ;
	wire [ 3:0 ] channel ;

  // Because of 12MHz being difficult to simu, instead of 1MHz
  initial  begin 
    clk_1MHz = 0;
    forever #5 clk_1MHz = ! clk_1MHz ;
  end

  initial	begin
     rst_n = 1;
     #10 rst_n = 0;
     #10 rst_n = 1;
	   #20 ;
	 end
	 
  FPQ_top_1TT_2RC uut( .clk_12MHz ( clk_1MHz ), .rst_n( rst_n ),
      .active( active ), .channel( channel ) );
  // for "actice" 00 - none, 01 - H, 10 - L
  
endmodule
