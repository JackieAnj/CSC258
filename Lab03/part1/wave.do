vlib work
vlog -timescale 1ns/1ns 7to1.v
vsim mux
log {/*}
add wave {/*}

force {SW[0]} 0 0, 1 10 -repeat 20
force {SW[1]} 0 0, 1 20 -repeat 40
force {SW[2]} 0 0, 1 30 -repeat 60
force {SW[3]} 0 0, 1 40 -repeat 80
force {SW[4]} 0 0, 1 50 -repeat 100
force {SW[5]} 0 0, 1 60 -repeat 120
force {SW[6]} 0 0, 1 70 -repeat 140


force {SW[7]} 0 0, 1 20 -repeat 40
force {SW[8]} 0 0, 1 40 -repeat 80
force {SW[9]} 0 0, 1 80 -repeat 160
run 1000ns
