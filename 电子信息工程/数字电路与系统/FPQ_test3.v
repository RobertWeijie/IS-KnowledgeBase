`timescale 1us/100ns
module FPQ_test3 ;
  reg clk ;
  wire [7:0] pkt_len ;
  reg bool_go ;
  reg rst_n ;
  
  q_Q16 #( 3 ) uut_q_Q16( .cnt_clk( clk ), 
                          .rst_n( rst_n ),
                          .go( bool_go ),
                          .pkt_len( pkt_len ) );
                          
  initial  begin // clock generator
    clk = 0;
    forever #5 clk = !clk;
  end
  
  initial	begin
    rst_n = 1; 
    #10 rst_n = 0;
    #10 rst_n = 1;
  end
  
  always @ ( posedge clk or negedge rst_n )
    if( !rst_n ) bool_go <= 1'b1 ;
    else if( bool_go == 1'b0 ) bool_go <= 1'b1 ;  
    else if( bool_go == 1'b1 && pkt_len == 0 ) bool_go <= 1'b0 ;

endmodule