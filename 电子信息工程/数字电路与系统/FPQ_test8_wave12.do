onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk_1MHz /FPQ_test8/clk_1MHz
add wave -noupdate -label rst_n /FPQ_test8/rst_n
add wave -noupdate -label {bit_clk ( 60ms )} /FPQ_test8/uut/bit_clk
add wave -noupdate -label active -radix binary /FPQ_test8/active
add wave -noupdate -label channel -radix hexadecimal /FPQ_test8/channel
add wave -noupdate -label {cur_value @ timetable} -radix hexadecimal /FPQ_test8/uut/uut_mux/uut_timetable/cur_value
add wave -noupdate -color Magenta -label {state @ rr} /FPQ_test8/uut/uut_mux/uut_rr_FP/state
add wave -noupdate -color Magenta -label {index_L @ rr} /FPQ_test8/uut/uut_mux/uut_rr_FP/index_L
add wave -noupdate -color Yellow -label cur_value_TT -radix hexadecimal -childformat {{{/FPQ_test8/uut/uut_mux/cur_value_TT[7]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[6]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[5]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[4]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[3]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[2]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[1]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_TT[0]} -radix hexadecimal}} -subitemconfig {{/FPQ_test8/uut/uut_mux/cur_value_TT[7]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[6]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[5]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[4]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[3]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[2]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[1]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_TT[0]} {-color Yellow -height 15 -radix hexadecimal}} /FPQ_test8/uut/uut_mux/cur_value_TT
add wave -noupdate -color Yellow -label bool_ready_H /FPQ_test8/uut/uut_mux/bool_ready_H
add wave -noupdate -color Yellow -label ena_n_H /FPQ_test8/uut/uut_mux/ena_n_H
add wave -noupdate -color Yellow -label bool_go_TT /FPQ_test8/uut/bool_go_TT
add wave -noupdate -color Yellow -label pkt_len_TT -radix hexadecimal -childformat {{{/FPQ_test8/uut/pkt_len_TT[7]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[6]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[5]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[4]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[3]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[2]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[1]} -radix hexadecimal} {{/FPQ_test8/uut/pkt_len_TT[0]} -radix hexadecimal}} -subitemconfig {{/FPQ_test8/uut/pkt_len_TT[7]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[6]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[5]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[4]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[3]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[2]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[1]} {-color Yellow -height 15 -radix hexadecimal} {/FPQ_test8/uut/pkt_len_TT[0]} {-color Yellow -height 15 -radix hexadecimal}} /FPQ_test8/uut/pkt_len_TT
add wave -noupdate -label cur_value_RC -radix hexadecimal -childformat {{{/FPQ_test8/uut/uut_mux/cur_value_RC[7]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[6]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[5]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[4]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[3]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[2]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[1]} -radix hexadecimal} {{/FPQ_test8/uut/uut_mux/cur_value_RC[0]} -radix hexadecimal}} -subitemconfig {{/FPQ_test8/uut/uut_mux/cur_value_RC[7]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[6]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[5]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[4]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[3]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[2]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[1]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_mux/cur_value_RC[0]} {-height 15 -radix hexadecimal}} /FPQ_test8/uut/uut_mux/cur_value_RC
add wave -noupdate -label bool_ready_L -expand /FPQ_test8/uut/uut_mux/bool_ready_L
add wave -noupdate -label ena_n_L -expand /FPQ_test8/uut/uut_mux/ena_n_L
add wave -noupdate -label bool_go_RC -expand /FPQ_test8/uut/bool_go_RC
add wave -noupdate -label pkt_len_RC0 -radix hexadecimal -childformat {{{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[7]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[6]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[5]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[4]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[3]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[2]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[1]} -radix hexadecimal} {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[0]} -radix hexadecimal}} -subitemconfig {{/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[7]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[6]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[5]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[4]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[3]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[2]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[1]} {-height 15 -radix hexadecimal} {/FPQ_test8/uut/uut_q_Q16_RC0/pkt_len[0]} {-height 15 -radix hexadecimal}} /FPQ_test8/uut/uut_q_Q16_RC0/pkt_len
add wave -noupdate -color Violet -label {cnt @ RC0} -radix hexadecimal /FPQ_test8/uut/uut_q_Q16_RC0/cnt
add wave -noupdate -label pkt_len_RC1 -radix hexadecimal /FPQ_test8/uut/uut_q_Q16_RC1/pkt_len
add wave -noupdate -color Violet -label {cnt @ RC1} -radix hexadecimal /FPQ_test8/uut/uut_q_Q16_RC1/cnt
add wave -noupdate -label {bool_pkt_new @ TT} /FPQ_test8/uut/uut_q_Q16_TT/bool_new_pkt
add wave -noupdate -label {bool_new_pkt @ RC0} /FPQ_test8/uut/uut_q_Q16_RC0/bool_new_pkt
add wave -noupdate -label {bool_pkt_new @ RC1} /FPQ_test8/uut/uut_q_Q16_RC1/bool_new_pkt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 54
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {432770 ns}
