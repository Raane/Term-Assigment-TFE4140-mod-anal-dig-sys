SetActiveLib -work
comp -include "$dsn\src\ecc.vhd" 
comp -include "$dsn\src\TestBench\ecc_TB.vhd" 
asim TESTBENCH_FOR_ecc 
wave 
wave -noreg voted_data_out
wave -noreg status_out
wave -noreg ECC_signal
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\ecc_TB_tim_cfg.vhd" 
# asim TIMING_FOR_ecc 
