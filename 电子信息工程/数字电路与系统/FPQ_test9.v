`timescale 100ns / 10ns
module FPQ_test9 ;
  reg clk_1MHz ;
	reg rst_n ;
	wire [ 1:0 ] active ;
	wire [ 3:0 ] channel ;
	wire [ 8:0 ] seg_LED_1 ;
	wire [ 8:0 ] seg_LED_2 ;
	wire [ 8:1 ] LEDs_n 	;

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
	 
/*	 
  FPQ_top_1TT_2RC uut( .clk_12MHz ( clk_1MHz ), .rst_n( rst_n ),
      .active( active ), .channel( channel ) );
  // for "actice" 00 - none, 01 - H, 10 - L
 */
 
  FPQ_top_1TT_2RC_with_ui uut( .clk_12MHz ( clk_1MHz ), .key_rst_n( rst_n ),
      	.seg_LED_1 ( seg_LED_1 ) , .seg_LED_2 ( seg_LED_2 ) , .LEDs_n ( LEDs_n ) );
      	
  reg test_key_deb_pulse ;
  wire test_rst_n ;
  
  initial begin
    test_key_deb_pulse = 1 ;
    #2000 ;
    test_key_deb_pulse = 0 ;
    #200 ;
    test_key_deb_pulse = 1 ;
    #200 ;
    test_key_deb_pulse = 0 ; 
    #3600 ;
    test_key_deb_pulse = 1 ;  
    #200 ;
    test_key_deb_pulse = 0 ;
    #200 ;
    test_key_deb_pulse = 1 ;   
  end	 
  
  key_debounce  # (	16'd100 ) // 1MHz, 100us 
      uut_key_deb ( .clk( clk_1MHz ),  .rst_n( rst_n ),
          .key_n( test_key_deb_pulse ), 
          .key_pulse_n( test_rst_n ) );
  
endmodule
