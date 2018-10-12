vlib work
vlog -timescale 1ns/1ns rate.v
vsim slowcounter
log {/*}
add wave {/*}
force {KEY[0]} 0 0, 1 2
run 2ns

force {KEY[0]} 0 0, 1 2
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 4ns
# test 1 full speed
force {KEY[0]} 0 0, 1 2
force {SW[1]} 0
force {SW[0]} 0
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 30ns

force {KEY[0]} 0 0, 1 2
run 2ns

# test 2 1Hz
force {KEY[0]} 0 0, 1 2
force {SW[1]} 0
force {SW[0]} 1
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 100ns

# test 3 0.5Hz
force {KEY[0]} 0 0, 1 2
force {SW[1]} 1
force {SW[0]} 0
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 100ns

# test 4 0.25Hz
force {KEY[0]} 0 0, 1 2
force {SW[1]} 1
force {SW[0]} 1
force {CLOCK_50} 0 0, 1 2 -repeat 4
run 100ns
