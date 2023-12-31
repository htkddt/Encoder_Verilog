onerror {quit -f}
vlib work
vlog -work work Bai_1.vo
vlog -work work Bai_1.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Bai_1_vlg_vec_tst
vcd file -direction Bai_1.msim.vcd
vcd add -internal Bai_1_vlg_vec_tst/*
vcd add -internal Bai_1_vlg_vec_tst/i1/*
add wave /*
run -all
