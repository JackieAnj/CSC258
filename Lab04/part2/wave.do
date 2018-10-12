vlib work
vlog -timescale 1ns/1ns alu.v
vsim simulate
log {/*}
add wave {/*}

# Test 1 Case 1
# A: 6
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
# Function input
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (0111)
run 10ns

# Test 2 Case 1
# A: 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (0100)
run 10ns

# Test 3 Case 2
# A: 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (1011)
run 10ns

# Test 4 Case 2
# A: 3
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (1000)
run 10ns

# Test 5 Case 3
# A: 6
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
# Function input
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (1011)
run 10ns

# Test 6 Case 3
# A: 3
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (1000)
run 10ns

# Test 7 Case 4
# A: 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (01110011)
run 10ns

# Test 8 Case 4
# A: 3
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (01110110)
run 10ns

# Test 9 Case 5
# A: 6
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
# Function input
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (00000001)
run 10ns

# Test 10 Case 5
# A: 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
# Function input
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (00000000)
run 10ns

# Test 11 Case 6
# A: 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (01100101)
run 10ns

# Test 12 Case 6
# A: 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (00110101)
run 10ns

# Test 13 Case 7
# A 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0,1 5
# reset_n input
force {SW[9]} 1
# Output (01100101)
run 10ns

# Test 14 Case 7
# A: 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (00110101)
run 10ns


# Test 15 Case 8
# A: 3
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (00110101)
run 10ns

# Test 16 Case 8
# A 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 1
# Output (01100101)
run 10ns

# Test 17 Case 8
# A 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 0
# Output (00000000)
run 10ns

# Test 18 Case 2
# A 5
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
# Function input
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
# clock input
force {KEY[0]} 0 0, 1 5
# reset_n input
force {SW[9]} 0
# Output (01100101)
run 10ns

