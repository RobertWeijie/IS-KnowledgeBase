//`define BOOL_JUST_FOR_SIMU 1

module FPQ_top_1TT_2RC_with_ui // with user interfaces
(
	input clk_10MHz ,
	input key_rst_n ,
	output TT,    //数据状态灯
	output RC_0,
	output RC_1,	
	
	output [ 1:0 ] Mode,    //当前孔隙状态灯
   
	output [7:0]SEG_s,  //数码管
	output [3:0]COM_s, //四位选择
	output [7:0]SEG,  //数码管
	output [3:0]COM //四位选择
);

  parameter SEG_A = 0 ;   //    -a
  parameter SEG_B = 1 ;   // f|    |b
  parameter SEG_C = 2 ;   //    -g
  parameter SEG_D = 3 ;   // e|    |c
  parameter SEG_E = 4 ;   //    -d   . dp
  parameter SEG_F = 5 ;   
  parameter SEG_G = 6 ;
  parameter SEG_DP = 7 ;
 
	wire [ 1:0 ] active ; // 00 - none, 01 - H, 10 - L
	wire [ 3:0 ] channel ;

	wire [ 7:0 ] pkt_len_TT ;
	wire [ 15:0 ] pkt_len_RC ;
	wire bool_go_TT ;
	wire [ 1:0 ] bool_go_RC ;
	wire bit_clk ;
	
	wire [ 7:0 ] packet_length ;
	
	wire [ 7:0 ] cur_value;
	
`ifndef BOOL_JUST_FOR_SIMU
	key_debounce deb_rst( .clk( clk_10MHz ), .rst_n( 1'b1 ), .key_n( key_rst_n ), .key_pulse_n( rst_n ) );
`else
	assign rst_n = key_rst_n ;
`endif	
	
	FPQ_mux_1TT_2RC uut_mux ( .clk_10MHz( clk_10MHz ) , .rst_n( rst_n ) ,
		.pkt_len_TT ( pkt_len_TT ) ,
		.pkt_len_RC ( pkt_len_RC ) ,
		.bool_go_TT ( bool_go_TT ) ,
		.bool_go_RC ( bool_go_RC ) ,
		.active  ( active ) , 
		.channel ( channel ) , 
		.bit_clk ( bit_clk ) ,
		.cur_state ( Mode ) ,
		.cur_value (cur_value)
		);
		
	wire bool_new_pkt_TT ;
	wire [ 1:0 ]	bool_new_pkt_RC ;	
	
	 q_Q16_negedge #( 0 ) uut_q_Q16_TT ( .cnt_clk( bit_clk ), .rst_n( rst_n ),
        .go( bool_go_TT ),
        .pkt_len( pkt_len_TT ),
        .bool_new_pkt( bool_new_pkt_TT ) );          

	 q_Q16_negedge #( 2 ) uut_q_Q16_RC0 ( .cnt_clk( bit_clk ), .rst_n( rst_n ),
        .go( bool_go_RC[ 0 ] ),
        .pkt_len( pkt_len_RC[ 7:0 ] ),
        .bool_new_pkt( bool_new_pkt_RC[ 0 ] ) );     		

	 q_Q16_negedge #( 10 ) uut_q_Q16_RC1 ( .cnt_clk( bit_clk ), .rst_n( rst_n ),
        .go( bool_go_RC[ 1 ] ),
        .pkt_len( pkt_len_RC[ 15:8 ] ),
        .bool_new_pkt( bool_new_pkt_RC[ 1 ] ) );  
        
  wire flash_clk ;
  
  div_half uut_div_10ms ( .clk( bit_clk ), .rst_n( rst_n ) , .cp( flash_clk ) );
  
  // wire temp_clk ;
  // div_16 #( 10 ) uut_div_50ms ( .clk( bit_clk ), .rst_n( rst_n ) , .cp( temp_clk ) );
  // div_16 #( 10 ) uut_div_500ms ( .clk( temp_clk ), .rst_n( rst_n ) , .cp( flash_clk ) );
  
//  FPQ_disp_q_head uut_disp_q_head_TT ( 	.rst_n ( rst_n ),
//      .flash_clk( flash_clk ), .bool_new_pkt( bool_new_pkt_TT ) ,
//      .pkt_len( pkt_len_TT ), 
//      .bar_LED ( { seg_LED_2[ SEG_A ], seg_LED_1[ SEG_A ] } ) );
//
//  FPQ_disp_q_head uut_disp_q_head_RC0 ( 	.rst_n ( rst_n ),
//      .flash_clk( flash_clk ), .bool_new_pkt( bool_new_pkt_RC[ 0 ] ) ,
//      .pkt_len( pkt_len_RC[ 7:0 ] ), 
//      .bar_LED ( { seg_LED_2[ SEG_G ], seg_LED_1[ SEG_G ] } ) );
//
//  FPQ_disp_q_head uut_disp_q_head_RC1 ( 	.rst_n ( rst_n ),
//      .flash_clk( flash_clk ), .bool_new_pkt( bool_new_pkt_RC[ 1 ] ) ,
//      .pkt_len( pkt_len_RC[ 15:8 ] ), 
//      .bar_LED ( { seg_LED_2[ SEG_D ], seg_LED_1[ SEG_D ] } ) );
      
  wire  TT_LED_n ;
  wire [ 0:1 ] RC_LED_n ; 
      
  FPQ_disp_state_by_meter uut_disp_state ( .active( active ), 
      .channel( channel[ 0 ] ),
      .pkt_len_TT( pkt_len_TT ) , .pkt_len_RC( pkt_len_RC ) ,
	
	       .TT_LED_n( TT_LED_n ) ,
			 .RC_LED_n( RC_LED_n ),
			 .packet_length(packet_length)  
	       
	      );
		  
	
	
	//not gate1 ( seg_LED_2[ SEG_B ], forbid_LED_n );
	//assign seg_LED_2 [ SEG_C ] = seg_LED_2 [ SEG_B ] ;
	
	not gate2 ( TT, TT_LED_n );
	not gate3 ( RC_0 , RC_LED_n[ 0 ] );
	not gate4 ( RC_1 , RC_LED_n[ 1 ] );
	LED_Nixietube i1(.Sys_CLK(clk_10MHz),.Data_Bin(cur_value),.EN(1'b1),.COM(COM_s),.SEG(SEG_s));
	LED_Nixietube i2(.Sys_CLK(clk_10MHz),.Data_Bin(packet_length),.EN(1'b1),.COM(COM),.SEG(SEG));
	
      		
endmodule
