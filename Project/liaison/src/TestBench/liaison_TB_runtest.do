SetActiveLib -work
comp -include "$dsn\src\liaison.vhd" 
comp -include "$dsn\src\TestBench\liaison_TB.vhd" 
asim TESTBENCH_FOR_liaison 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg di_ready
wave -noreg mp_data
wave -noreg do_ready
wave -noreg voted_data
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\liaison_TB_tim_cfg.vhd" 
# asim TIMING_FOR_liaison 
