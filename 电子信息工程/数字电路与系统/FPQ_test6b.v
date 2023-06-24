`timescale 1us/100ns
module FPQ_test6b ;
  reg clk ;
	reg rst_n ;
	//
	wire bool_ready_H ;
	wire bool_go_H ;
	wire [ 1 : 0 ] bool_ready_L ;
	wire [ 1 : 0 ] bool_go_L ;
	wire bool_ready_RC2 ;
	wire bool_go_RC2 ;
	//
	wire ena_n_H ;
	wire [ 1 : 0 ] ena_n_L ;
	wire ena_n_RC2 ;
	//
	wire [1:0] active ; // 00 - none, 01 - H, 10 - L
	wire [3:0] channel ;
	//
	reg [ 1 : 0 ] trig_RC ;
	reg [ 1 : 0 ] ctrl_keep_RC ;
	reg [ 1 : 0 ] ctrl_op_RC ;
	reg [ 1 : 0 ] ctrl_rdy_remain_RC ;	
	//
	round_robin_FP #(3) uut_rr_FP ( .clk( clk ), .rst_n( rst_n ),
	                   .bool_ready_H ( bool_ready_H ),
	                   .bool_go_H ( bool_go_H ),
	                   .bool_ready_L ( { bool_ready_RC2 , bool_ready_L } ),
	                   .bool_go_L    ( { bool_go_RC2 , bool_go_L } ),
	                   .ena_n_H ( ena_n_H ),
	                   .ena_n_L      ( { ena_n_RC2 , ena_n_L } ),
	                   .active ( active ),
	                   .channel ( channel ) );
	                   
  localparam [1:0] P_PCF = 2'b00 ;
  localparam [1:0] P_TT  = 2'b01 ;
  localparam [1:0] P_RC  = 2'b11 ;
  localparam [1:0] P_BE  = 2'b10 ;
  
  reg [7:0] cur_value_TT ;
  wire [7:0] pkt_len_TT ;
  
  reg [7:0 ] cur_value_RC2 ;
  wire [7:0] pkt_len_RC2 ;
  
	                   
  q_server_3_states #( P_TT ) uut_q_s_TT ( .cur_value( cur_value_TT ), .pkt_len( pkt_len_TT ), 
                            .clk( clk ), .rst_n( rst_n ),
                            .ena_n( ena_n_H ), 
                            .bool_ready( bool_ready_H ),
                            .bool_go( bool_go_H ) );	

   q_Q16_negedge #( 0 ) uut_q_Q16_TT ( .cnt_clk( clk ),   // offset = 0
                          .rst_n( rst_n ),
                          .go( bool_go_H ),
                          .pkt_len( pkt_len_TT ) );                      

  q_server_3_states #( P_RC ) uut_q_s_RC2 ( .cur_value( cur_value_RC2 ), .pkt_len( pkt_len_RC2 ), 
                            .clk( clk ), .rst_n( rst_n ),
                            .ena_n( ena_n_RC2 ), 
                            .bool_ready( bool_ready_RC2 ),
                            .bool_go( bool_go_RC2 ) );	

   q_Q16_negedge #( 2 ) uut_q_Q16_RC2 ( .cnt_clk( clk ),   // offset = 2
                          .rst_n( rst_n ),
                          .go( bool_go_RC2 ),
                          .pkt_len( pkt_len_RC2 ) );     

  initial  begin // clock generator
    clk = 0;
    forever #5 clk = !clk;
  end
  
  initial	begin
   rst_n = 1;
   #10 rst_n = 0;
	 #20 trig_RC = 2'b00 ;
   #10 rst_n = 1;
	 #20 ;
	 cur_value_TT = 4 ;
	 cur_value_RC2 = 0 ;
	 ctrl_keep_RC = 2'b11 ;
	 ctrl_op_RC = 2'b11 ;
	 ctrl_rdy_remain_RC = 2'b11 ;	 
   #40 ;
   #100 ;
   trig_RC [ 0 ] = ! trig_RC [ 0 ] ;
   #400 ;
   cur_value_TT = 0 ;
   #10 ;
   cur_value_RC2 = 8 ;
   #10 ;
   trig_RC [ 1] = ! trig_RC [ 1 ] ;
   #180 ;
   cur_value_RC2 = 4 ;
   #150 ;
   cur_value_RC2 = 2 ;
   #150 ;
   cur_value_RC2 = 0 ;
   cur_value_TT = 8 ;
   #2900 ;
   cur_value_TT = 3 ; 
   #1000 ;
   cur_value_TT = 5 ;
   #1000 ;
   cur_value_TT = 0 ;
   #1010 ;
   cur_value_RC2 = 8 ;
   #490 ; cur_value_RC2 = 7 ;
   #500 ; cur_value_RC2 = 6 ;
   #500 ; cur_value_RC2 = 5 ;
   #500 ; cur_value_RC2 = 4 ;
   #500 ; cur_value_RC2 = 3 ;
   #500 ; cur_value_RC2 = 2 ;
   #500 ; cur_value_RC2 = 1 ;
   #500 ; cur_value_RC2 = 0 ;   
    // TO BE CONTINUE       
  end

  ready_go_emulator #( 12'h018 ) emu_RC2 ( .clk( clk ), 
                    .rst_n ( rst_n ), .trigger ( trig_RC [ 0 ] ) ,
                    .type_keep  ( ctrl_keep_RC [ 0 ] ), 
                    .type_op    ( ctrl_op_RC [ 0 ] ), 
                    .type_rdy_remain ( ctrl_rdy_remain_RC [ 0 ] ),
                    .bool_ready( bool_ready_L [ 0 ] ),
                    .ena_n ( ena_n_L [ 0 ] ),
                    .bool_go ( bool_go_L [ 0 ] ) );
                    
  ready_go_emulator #( 12'h00c ) emu_RC1 ( .clk( clk ), 
                    .rst_n ( rst_n ), .trigger ( trig_RC [ 1 ] ) ,
                    .type_keep  ( ctrl_keep_RC [ 1 ] ), 
                    .type_op    ( ctrl_op_RC [ 1 ] ), 
                    .type_rdy_remain ( ctrl_rdy_remain_RC [ 1 ] ),
                    .bool_ready( bool_ready_L [ 1 ] ),
                    .ena_n ( ena_n_L [ 1 ] ),
                    .bool_go ( bool_go_L [ 1 ] ) ); 

  wire bool_no_confilict ;
  assign bool_no_confilict = ~( (bool_go_H)&(bool_go_L[0]) | 
                                (bool_go_H)&(bool_go_L[1]) |
                                (bool_go_L[0])&(bool_go_L[1]) );

endmodule