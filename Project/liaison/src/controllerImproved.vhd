library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
	 port(
		 di_ready : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 do_ready : out STD_LOGIC;
		 control_signals : out STD_LOGIC_VECTOR(9 downto 0);
		 voted_data_selector : out STD_LOGIC_VECTOR(4 downto 0)
	     );
end controller;

architecture controllerImproved of controller is
	
	signal counter: integer range 0 to 8 := 0;	   			 
	
	-- Next-signals used for clock updates
	signal next_control_signals: std_logic_vector(9 downto 0);
	signal next_voted_data_selector: std_logic_vector(4 downto 0);
	signal next_do_ready: std_logic;-- := '0';
	
	signal do_ready_internal: std_logic; -- For internal use of do_ready
	
begin
	
	do_ready <= do_ready_internal;
	
	clock_tick : process(clk)
	begin
	if (rising_edge(clk)) then
		if (reset = '1') then
			control_signals <= "0000000000";
			voted_data_selector <= "00000";
			counter <= -10;
			do_ready_internal <= '0';		 
		else					
			-- Updating the controller's output values
			-- based on current selected next-values
			control_signals <= next_control_signals;
			voted_data_selector <= next_voted_data_selector;
			counter <= next_counter;
			do_ready_internal <= next_do_ready;	
		end if;
		
		
	end if;
	end process;
	
	-- Sets next counter value
	--count : process(counter)
--	begin
--		case counter is
--			when 0 =>
--				if (di_ready = '1')	then
--					next_counter <= counter+1;
--				else
--					next_counter <= 0;
--				end if;
--			when 10 =>
--				next_counter <= 0;
--			when others =>
--				next_counter <= counter+1;
--			
--		end case;
--	end process;

	-- Selects register for input, and also activates do_ready after 8 cycles
	handle_input : process(di_ready, control_signals)
	begin
		case control_signals is
			when "0000000000" =>
				if (di_ready = '1') then
					next_control_signals <= "0010000000"; -- store as bit 7	
				else 
					next_control_signals <= "0000000000"; -- Stay idle
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
				next_do_ready <= '1'; -- Setting do_ready 8 cycles after di_ready has initiated storing
				next_control_signals <= "0000000001"; -- store as bit 0
			when "0000000001" =>
				next_control_signals <= "0100000000"; -- store status
			when "0100000000" =>
				next_control_signals <= "1000000000"; -- update ECC-registers 
			when others => -- Done running through register storing. Do nothing until di_ready has been set again
				next_control_signals <= "0000000000"; 
		end case;							 
		
	end process;
	
	-- Setting next_do_ready to 0. Usually happens after do_ready has been set to '1', so that it will be set to '0' in next cycle.
	shut_off_do_ready : process(do_ready)
	begin
		next_do_ready <= '0';
	end process;
	
	
	-- Activating or incrementing counter
	--counting : process (di_ready, counter)
--	begin
--		if (di_ready = '1') or (counter>-10) then
--			
--			end if;
--	
--	end process;
	
	-- Activating or incrementing di_counter
	di_counting : process (di_ready, di_counter, reset)
	begin
		
	-- Active reset
	if (reset = '1') then
		next_di_counter <= 0;
		
	-- di_ready is set to 1 (usually when di_counter is 0, initilizing it),
	-- or di_counter is already active
	elsif (di_ready = '1') or (di_counter > 0) then
		-- Check if counter has reached end
		if di_counter = 10 then
			next_di_counter <= 0;
		else
			next_di_counter <= di_counter+1;
		end if;
	--else
		--next_di_counter <= 0;
	end if;
	end process;
	
	-- Activating or incrementing do_counting
	do_counting : process (do_ready_internal, do_counter, reset)
	begin
	
	-- Active reset
	if (reset = '1') then
		next_do_counter <= 0;
		
	-- do_ready is set to 1 (usually when do_counter is 0, initilizing it),
	-- or do_counter is already active
	elsif (do_ready_internal = '1') or (do_counter > 0) then
		-- Check if counter has reached end
		if do_counter = 14 then
			next_do_counter <= 0;
		else
			next_do_counter <= do_counter+1;
		end if;
	--else
		--next_do_counter <= 0;
	end if;
	
	end process;
	
	
	set_input_and_do_ready: process(next_di_counter)
	variable do_ready_variable : std_logic;
	begin
		-- NOTE: Reset in process di_counting, causing next_di_counter to be 0,
		-- should trigger reset in this process as well by setting outputs to
		-- 0 and "0000000000" due to next_di_counter being 0
		
		-- When starting up, control_signals is "0000000000"
		-- Since one clock cycle is needed for the 1-bit voter to vote and set y-output
		-- First output y is ready as same time as first register for storing,
		-- and control_signals is "0000000001", storing on v0 should work,
		-- and moving the flags in control_signals by one per clock cycle while
		-- y is being updated per clock cycle should work
		
		-- next_di_counter is always +1 more than current di_counter,
		-- therefore case starts with 1
		-- exception: When di_counter reaches 10, next_di_counter is 0
		do_ready_variable := '0';
		
		
		case next_di_counter is
			when 1 => 
				next_control_signals <= "0010000000"; -- store as bit 7
			when 2 =>
				next_control_signals <= "0001000000"; -- store as bit 6
			when 3 =>
				next_control_signals <= "0000100000"; -- store as bit 5
			when 4 =>
				next_control_signals <= "0000010000"; -- store as bit 4
			when 5 =>
				next_control_signals <= "0000001000"; -- store as bit 3
			when 6 =>
				next_control_signals <= "0000000100"; -- store as bit 2
			when 7 =>
				next_control_signals <= "0000000010"; -- store as bit 1
			when 8 =>
				do_ready_variable := '1'; -- Setting do_ready 8 cycles after di_ready has initiated storing
				next_control_signals <= "0000000001"; -- store as bit 0
			when 9 =>
				next_control_signals <= "0100000000"; -- store status
			when 10 =>
				next_control_signals <= "1000000000"; -- update ECC-registers
			when others => -- Done running through register storing. Do nothing until di_ready has been set again
				next_control_signals <= "0000000000"; 
		end case;
		next_do_ready <= do_ready_variable;
		
	end process;
	
	set_output: process(next_do_counter)
	begin
		
		-- NOTE: Reset in process do_counting, causing next_do_counter to be 0,
		-- should trigger reset in this process as well by setting output to
		-- "00000"
		
		-- Idea for counting same as in previous process above
		-- but next_voted_data_selector should be "00000" when counter is not active
		-- This makes reading data immediatly possible.
		case next_do_counter is
			-- next_voted_data_selector should already be "00000"
			-- reading input from v0
			when 00 =>
				next_voted_data_selector <= "00111"; -- set output from liaison to voted data bit 7, should be set already at beginning of counting
			when 01 =>
				next_voted_data_selector <= "00110"; -- set output from liaison to voted data bit 6
			when 02 =>
				next_voted_data_selector <= "00101"; -- set output from liaison to voted data bit 5
			when 03 =>
				next_voted_data_selector <= "00100"; -- set output from liaison to voted data bit 4
			when 04 =>
				next_voted_data_selector <= "00011"; -- set output from liaison to voted data bit 3
			when 05 =>
				next_voted_data_selector <= "00010"; -- set output from liaison to voted data bit 2
			when 06 =>
				next_voted_data_selector <= "00001"; -- set output from liaison to voted data bit 1
			when 07 =>
				next_voted_data_selector <= "00000"; -- set output from liaison to voted data bit 0
			when 08 =>
				next_voted_data_selector <= "01010"; -- set output from liaison to status bit 2
			when 09 =>
				next_voted_data_selector <= "01001"; -- set output from liaison to status bit 1
			when 10 =>
				next_voted_data_selector <= "01000"; -- set output from liaison to status bit 0
			when 11 =>
				next_voted_data_selector <= "10010"; -- set output from liaison to ECC bit 3
			when 12 =>
				next_voted_data_selector <= "10001"; -- set output from liaison to ECC bit 2
			when 13 =>
			   	next_voted_data_selector <= "10000"; -- set output from liaison to ECC bit 1
			when 14 =>
				next_voted_data_selector <= "01111"; -- set output from liaison to ECC bit 0
			when others =>
				-- Do nothing. Should in theory not be reached.
		end case;
		
	end process;
	
end controllerImproved;