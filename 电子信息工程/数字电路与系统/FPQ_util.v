/*
	MODULE : div_half
	MODULE : divider
	MODULE : div_16
	MODULE : key_debounce
	MODULE : meter_log2_rank8_max95
	MOUDLE : mux4
 */

module div_half
(
  input clk,
  input rst_n,
  output cp
); 
  reg toggle ;
  assign cp = toggle ;
  always @ ( posedge clk or negedge rst_n )
    if( ! rst_n ) begin
      toggle <= 1'b0 ;
    end
    else if ( toggle == 1'b1 ) begin
      toggle <= toggle ^ 1'b1 ;
    end      
    else toggle <= toggle ^ 1'b1 ;  //？？？
endmodule

///////////////////////////////////////////////////////////////////////////////

module divider 
#( parameter [15:0] CNT_NUM = 16'd50000 ) 	// 5ms @ 10MHz
(
	input clk, 			// system clock
	input rst_n, 		// reset input, negative
	output reg cp 		// output clock pulse
);
	reg [15:0] cnt ;
	
	always @( posedge clk or negedge rst_n )
		if( ! rst_n ) begin
			cnt <= 16'd0 ;
			cp <= 1'b0 ;
		end
		else if ( cnt == CNT_NUM -1 ) begin
			cnt <= 16'd0 ;
			cp <= 1'b1 ;
		end
		else begin
			cnt <= cnt + 16'd1 ;
			cp <= 1'b0 ;
		end
endmodule

///////////////////////////////////////////////////////////////////////////////

module div_16 
#( parameter [3:0] CNT_NUM = 4'd8 )
(
	input clk, 		
	input rst_n,
	output reg cp 
);
	reg [ 3:0 ] cnt ;
	
	always @( posedge clk or negedge rst_n )
		if( ! rst_n ) begin
			cnt <= 4'd0 ; 			cp <= 1'b0 ;
		end
		else if ( cnt == CNT_NUM -1 ) begin
			cnt <= 4'd0 ;			cp <= 1'b1 ;
		end
		else begin
			cnt <= cnt + 4'd1 ; cp <= 1'b0 ;
		end
endmodule

///////////////////////////////////////////////////////////////////////////////

module key_debounce 
# (	parameter CNT_NUM = 16'd33333 ) // 10MHz, 6.67ms 
(
	clk,		// system clock
	rst_n, 		// reset input, negative
	key_n,		// button input, negative
	key_state,	// debounce state output
	key_pulse, 	// at negedge of key_state with a clk period width pos impluse
	key_pulse_n // at negedge of key_state with a clk period width neg impluse
);
	input clk, rst_n , key_n ;
	output key_state  ;	
	reg key_state ;
	output key_pulse , key_pulse_n ;
	
	localparam REG_NUM = 5 ;	// REG_NUM = 2*VOTE_NUM -1
	localparam VOTE_NUM = 3 ; 
	localparam REG_SUM_WIDTH = 3 ;
	localparam REG_INIT = 5'b11111 ;

	localparam S_IDLE = 1'b0, S_ACTIVE = 1'b1 ;
	reg state ;
	reg [ 15:0 ] cnt ;
	
	reg [ 1: REG_NUM ] shift_reg ;
	reg [ REG_SUM_WIDTH-1 : 0 ] sum ;
	
	wire key_an ;		// pulse when key_n changed
	reg out_reg ; 		// lock the change of key_state
	
	// Register shift_reg, lock key_n to next clk
	always @( posedge clk or negedge rst_n ) begin
		if ( ! rst_n ) shift_reg <= REG_INIT ;
		else shift_reg = { key_n , shift_reg [ 1 : REG_NUM-1 ] } ;
    end
	integer i ;
	always @( shift_reg ) begin
		sum = shift_reg[1] ;
		for ( i = 2 ; i <= REG_NUM ; i=i+1 ) begin
			sum = sum + shift_reg[i];
		end
	end
	
	// Detect the edge of key_n
	assign key_an = ( shift_reg[1] == key_n ) ? 1'b0 : 1'b1 ;
	
	// FSM : S_IDLE -> S_ACTIVE when key_an = 1 ;
	//       S_ACTIVE -> S_IDLE when cnt reaches to CNT_NUM
	always @( posedge clk or negedge rst_n )
		if( ! rst_n ) begin
			state <= S_IDLE ;
			key_state <= 1'b1 ;
		end
		else begin
			case( state )
				S_IDLE : begin
					if ( key_an ) begin 
						state <= S_ACTIVE ;
						cnt <= 0 ;
					end
				end
				S_ACTIVE : begin
					// Count the number of clk pulses when an edge of key_n occurs
					if ( cnt == CNT_NUM - 1 ) begin
						state <= S_IDLE ;
						// Make a decision by samples
						if ( sum >= VOTE_NUM ) key_state <= 1'b1 ;
						else key_state <= 1'b0 ;
					end
					else cnt <= cnt + 16'd1 ; 
				end
			endcase
		end
		
	always @( posedge clk or negedge rst_n )
		if( !rst_n ) out_reg = 1 ;
		else out_reg = key_state ;
	assign key_pulse = (! key_state ) && ( out_reg != key_state ) ;	
	assign key_pulse_n = ~key_pulse ;
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module meter_log2_rank8_max95
(
	input [ 7:0 ] num ,
	output reg [ 7:0 ] rank,
	output [ 7:0 ] rank_n
);

	always @ ( num )
		if ( num >= 8'd96 ) rank = 8'b1111_1111 ;
		else if ( num >= 8'd64 ) rank = 8'b0111_1111 ;
		else if ( num >= 8'd32 ) rank = 8'b0011_1111 ;
		else if ( num >= 8'd16 ) rank = 8'b0001_1111 ;
		else if ( num >= 8'd8 ) rank = 8'b0000_1111 ;
		else if ( num >= 8'd4 ) rank = 8'b0000_0111 ;
		else if ( num >= 8'd2 ) rank = 8'b0000_0011 ;
		else if ( num >= 8'd1 ) rank = 8'b0000_0001 ;
		else rank = 8'b0000_0000 ;	 // num == 8'd0
	
	assign rank_n = ~rank ;
	
endmodule

///////////////////////////////////////////////////////////////////////////////

module mux4
# ( parameter N = 8 )
(
	input [ 1:0 ] addr ,
	input [ N-1:0 ] in0 ,
	input [ N-1:0 ] in1 ,
	input [ N-1:0 ] in2 ,
	input [ N-1:0 ] in3 ,
	output reg [ N-1:0 ] out
);

	always @ ( addr or in0 or in1 or in2 or in3 ) 
		case ( addr )
			2'b00 : out = in0 ;
			2'b01 : out = in1 ;
			2'b10 : out = in2 ;
			2'b11 : out = in3 ;
		endcase
		
endmodule
	