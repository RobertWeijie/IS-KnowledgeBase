onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FPQ_test2/clk
add wave -noupdate /FPQ_test2/rst_n
add wave -noupdate -radix hexadecimal /FPQ_test2/cur_value
add wave -noupdate -radix hexadecimal /FPQ_test2/pkt_len
add wave -noupdate /FPQ_test2/bool_ready
add wave -noupdate /FPQ_test2/shifter1
add wave -noupdate /FPQ_test2/shifter2
add wave -noupdate /FPQ_test2/bool_go
add wave -noupdate -radix hexadecimal /FPQ_test2/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1 us}
