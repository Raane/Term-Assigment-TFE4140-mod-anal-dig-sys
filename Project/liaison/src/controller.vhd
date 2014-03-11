library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
	 port(
		 di_ready : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 do_ready : out STD_LOGIC;
		 control_signals : out STD_LOGIC_VECTOR(9 downto 0);
		 voted_data_selector : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end controller;

architecture controller of controller is
											   	   			 
	
	-- Next-signals used for clock updates
	signal next_control_signals: std_logic_vector(9 downto 0);
	signal next_vdsi: std_logic_vector(3 downto 0);
	signal next_do_ready: std_logic;
	
	signal do_ready_internal: std_logic; -- For internal use of do_ready 
	signal control_signals_internal : STD_LOGIC_VECTOR(9 downto 0);	-- For internal use of control_signals
	signal vdsi : STD_LOGIC_VECTOR(3 downto 0); -- For internal use of voted_data_selector (shortened to vdsi, i for internal)	
	
begin
	
	-- Setting component output from internal output signals
	do_ready <= do_ready_internal;
	control_signals <= control_signals_internal;
	voted_data_selector <= vdsi;
	
	-- Setting current output
	clock_tick : process(clk)
	begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			control_signals_internal <= "0000000000";
			vdsi <= "0111"; -- 0111 is the first output, from V7 
			do_ready_internal <= '0';		 
		else					
			-- Updating the controller's output values
			-- based on current selected next-values
			control_signals_internal <= next_control_signals;
			vdsi <= next_vdsi;	 
			do_ready_internal <= next_do_ready;	
		end if;
		
		
	end if;
	end process;
			
	-- Selects register for storing input among voted data, status data and ECC data, 
	-- and also activates do_ready after 8 cycles
	handle_input : process(di_ready, control_signals_internal)
		variable nd_variable : std_logic; -- Used to set next_do_ready
	begin
		nd_variable := '0';
		
		case control_signals_internal is
			when "0000000000" =>
				if (di_ready = '1') then  -- di_ready works only when system is idle, with value "0000000000"
					next_control_signals <= "0010000000"; -- store as bit 7	
				else 
					next_control_signals <= "0000000000"; -- Stay idle, di_ready has not yet hit in
				end if;													
			when "0010000000" =>
				next_control_signals <= "0001000000"; -- store as bit 6
			when "0001000000" =>
				next_control_signals <= "0000100000"; -- store as bit 5
			when "0000100000" =>
				next_control_signals <= "0000010000"; -- store as bit 4
			when "0000010000" =>
				next_control_signals <= "0000001000"; -- store as bit 3
			when "0000001000" =>
				next_control_signals <= "0000000100"; -- store as bit 2
			when "0000000100" =>
				next_control_signals <= "0000000010"; -- store as bit 1
			when "0000000010" =>
				nd_variable := '1'; -- Setting do_ready 8 cycles after di_ready has initiated storing. Otherwise, keep do_ready at 0
				next_control_signals <= "0000000001"; -- store as bit 0
			when "0000000001" =>
				next_control_signals <= "0100000000"; -- store status
			when "0100000000" =>
				next_control_signals <= "1000000000"; -- update ECC-registers 
			when others => -- Done running through register storing. Do nothing until di_ready has been set again.
				next_control_signals <= "0000000000"; 
		end case;							 
		next_do_ready <= nd_variable;
	end process;
	
	-- Selects output from the different registers, one at a time
	-- default when idle is register v7
	handle_output : process (vdsi, do_ready_internal)
	begin			
		case vdsi is											  
			when "0111" =>
				if (do_ready_internal = '1') then 
					next_vdsi <= "0110"; -- set output from liaison to voted data bit 6
				else
					next_vdsi <= "0111"; -- Idle, do_ready is not 1, keep output on voted data bit 7
				end if;
			when "0110" =>
				next_vdsi <= "0101"; -- set output from liaison to voted data bit 5
			when "0101" =>
				next_vdsi <= "0100"; -- set output from liaison to voted data bit 4
			when "0100" =>
				next_vdsi <= "0011"; -- set output from liaison to voted data bit 3
			when "0011" =>
				next_vdsi <= "0010"; -- set output from liaison to voted data bit 2
			when "0010" =>
				next_vdsi <= "0001"; -- set output from liaison to voted data bit 1
			when "0001" =>
				next_vdsi <= "0000"; -- set output from liaison to voted data bit 0
			when "0000" =>
				next_vdsi <= "1010"; -- set output from liaison to status bit 2
			when "1010" =>
				next_vdsi <= "1001"; -- set output from liaison to status bit 1
			when "1001" =>
				next_vdsi <= "1000"; -- set output from liaison to status bit 0
			when "1000" =>
				next_vdsi <= "1110"; -- set output from liaison to ECC bit 3
			when "1110" =>
				next_vdsi <= "1101"; -- set output from liaison to ECC bit 2
			when "1101" =>
			   	next_vdsi <= "1100"; -- set output from liaison to ECC bit 1
			when "1100" =>
				next_vdsi <= "1011"; -- set output from liaison to ECC bit 0
			when others =>
				next_vdsi <= "0111"; 
				-- Reached when vdsi = "01111". Cycle is at end, setting output at voted data bit 7.
				-- Using "When others" in case of glitch as well, though other values should never be reached.
				-- Ideally, do_ready should have been set to 1 at the same time for max throughput
		end case;
							  
	end process;
	  
	
end controller;