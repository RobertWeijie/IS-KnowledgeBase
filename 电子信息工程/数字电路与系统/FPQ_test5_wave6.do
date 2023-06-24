onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk /FPQ_test5/clk
add wave -noupdate -label rst_n /FPQ_test5/rst_n
add wave -noupdate -label trig_TT /FPQ_test5/trig_TT
add wave -noupdate -label bool_ready_H /FPQ_test5/bool_ready_H
add wave -noupdate -label ena_n_H /FPQ_test5/ena_n_H
add wave -noupdate -label bool_go_H /FPQ_test5/bool_go_H
add wave -noupdate -label trig_RC /FPQ_test5/trig_RC
add wave -noupdate -label index_L -radix hexadecimal /FPQ_test5/uut_rr_FP/index_L
add wave -noupdate -label bool_ready_L -expand /FPQ_test5/bool_ready_L
add wave -noupdate -label ena_n_L -expand /FPQ_test5/ena_n_L
add wave -noupdate -label bool_go_L -expand /FPQ_test5/bool_go_L
add wave -noupdate -label {state @ rr_FP} /FPQ_test5/uut_rr_FP/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {2644700 ns} 0}
configure wave -namecolwidth 139
configure wave -valuecolwidth 51
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
WaveRestoreZoom {2625900 ns} {3019700 ns}
