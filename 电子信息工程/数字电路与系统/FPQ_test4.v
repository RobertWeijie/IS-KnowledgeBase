`timescale 1us/100ns
module FPQ_test4 ;
  localparam CONST_LEN = 8'd4 ;
  reg clk ;
  reg [7:0] cur_value ;
  wire [7:0] pkt_len ;
  reg ena_n ;
  wire bool_go ;
  
  initial  begin // clock generator
    clk = 0;
    forever #5 clk = !clk;
  end
  
  reg rst_n ;
  initial	begin
    rst_n = 1;
    #10 rst_n = 0;
    #10 rst_n = 1;
    #100
    cur_value = 4 ;
    #2000
    cur_value = 16 ;
    #2000
    cur_value = 4 ;
    #2000
    cur_value = 2 ;
    #2000
    cur_value = 0 ;
  end
  
  q_server #(2'b11) uut_q_s ( .cur_value( cur_value ), .pkt_len( pkt_len ), 
                            .clk( clk ), .rst_n( rst_n ),
                            .ena_n( ena_n ), 
                            .bool_ready( bool_ready ),
                            .bool_go( bool_go ) );
                            
  q_Q16 #( 3 ) uut_q_Q16( .cnt_clk( clk ),   // offset = 3
                          .rst_n( rst_n ),
                          .go( bool_go ),
                          .pkt_len( pkt_len ) );   
                          
  reg shifter1, shifter2 ;                         

  always @( negedge rst_n or posedge clk )
    if( ! rst_n ) begin
      cur_value <= CONST_LEN ;
      shifter1 <= 0 ;
      shifter2 <= 0 ;
    end
    else begin
      shifter1 <= bool_ready ;
      shifter2 <= shifter1 ;
      if( shifter2 ) ena_n <= 1'b0 ;
      else ena_n <= 1'b1 ;
  end

endmodule