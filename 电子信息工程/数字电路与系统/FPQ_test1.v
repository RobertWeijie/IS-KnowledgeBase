`timescale 1us/100ns
module FPQ_test1 ;
  reg clk ;
  initial  begin // clock generator
    clk = 0;
    forever #5 clk = !clk;
  end
  
  reg rst_n ;
  initial	begin
    rst_n = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;
  end
  
  wire [7:0] cur_value ;
	wire [1:0] cur_state ;
	wire cnt_clk ;
  wire [7:0] cnt_for_TT ;
	wire [7:0] cnt_for_RC ;
	
  timetable uut_timetable ( .cnt_clk( cnt_clk ),  // clock for the inner counter
                            .rst_n( rst_n ), 	    // reset input, negative
                            .ena_n( 1'b0 ),       // enable input, negative
                            .cur_value( cur_value ), // the residual value of the inner counter
                            .cur_state( cur_state ) ); // the current state
  divider #(16'd500) uut_div ( .clk( clk ),       // system clock 100kHz ( period is 10us )
                             .rst_n( rst_n ),   // reset input, negative
                             .cp ( cnt_clk ) ); // when CNT_NUM = 16'd500, 5ms @ 100kHz 
  cur_value_translator uut_trans ( .cur_value( cur_value ), 
                                   .cur_state( cur_state ),
                                   .cnt_for_TT( cnt_for_TT ),
                                   .cnt_for_RC( cnt_for_RC ) );

endmodule