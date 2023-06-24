onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label {system clk} /FPQ_test1/clk
add wave -noupdate -label rst_n /FPQ_test1/rst_n
add wave -noupdate -label {cnt @ div} -radix hexadecimal -childformat {{{/FPQ_test1/uut_div/cnt[15]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[14]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[13]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[12]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[11]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[10]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[9]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[8]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[7]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[6]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[5]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[4]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[3]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[2]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[1]} -radix hexadecimal} {{/FPQ_test1/uut_div/cnt[0]} -radix hexadecimal}} -subitemconfig {{/FPQ_test1/uut_div/cnt[15]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[14]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[13]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[12]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[11]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[10]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[9]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[8]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[7]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[6]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[5]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[4]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[3]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[2]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[1]} {-height 15 -radix hexadecimal} {/FPQ_test1/uut_div/cnt[0]} {-height 15 -radix hexadecimal}} /FPQ_test1/uut_div/cnt
add wave -noupdate -label {cnt_clk ( output cp )} /FPQ_test1/cnt_clk
add wave -noupdate -label {index @ timetable} /FPQ_test1/uut_timetable/index
add wave -noupdate -label {cur_state @ timetable} /FPQ_test1/cur_state
add wave -noupdate -label cur_value -radix hexadecimal /FPQ_test1/cur_value
add wave -noupdate -label cnt_for_TT -radix hexadecimal /FPQ_test1/cnt_for_TT
add wave -noupdate -label cnt_for_RC -radix hexadecimal /FPQ_test1/cnt_for_RC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1912007000 ns} 0} {{Cursor 2} {17780015000 ns} 0}
configure wave -namecolwidth 166
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ns} {21210000100 ns}
