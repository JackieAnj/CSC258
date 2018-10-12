vlib work
vlog -timescale 1ns/1ns shiftregister.v
vsim shiftregister
log {/*}
add wave {/*}

# Clock
force {KEY[0]} 0 0, 1 5 -repeat 10

# Case 1 load values in
force {SW[7:0]} 11010001
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
# output  11010001
run 10ns

# Case 2 no shift
force {SW[7:0]} 11010001
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
# output 11010001
run 10ns

# Case 3 ASR
force {SW[7:0]} 11010001
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
# output 11101000
run 10ns

# Case 4 right shift
force {SW[7:0]} 11010001
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
# output 01110100
run 10ns

# Case 5 no shift (again)
force {SW[7:0]} 11010001
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
# output 01110100
run 10ns

# Case 6 load values in
force {SW[7:0]} 01101001
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 1
# output 01101001
run 10ns

