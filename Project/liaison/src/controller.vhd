library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
	 port(
		 di_ready : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 control_signals : out STD_LOGIC_VECTOR (9 downto 0);
		 voted_data_selector: out STD_LOGIC_VECTOR (2 downto 0);
		 do_ready: out STD_LOGIC
	     );
end controller;

architecture controller of controller is
	-- Interwall for di_ready and do_ready: 19 clock cycles
	-- (8 voted data, 3 status data, 8 parity bits)

	-- Counter is used to control outputs, 
	-- like when to activate do_ready, 
	-- selecting register cells for storing inputs,
	-- selecting which cell to give current output etc.
	constant counter_end: integer := 50;
	signal counter: integer range 0 to counter_end; 
begin
	
	
	clock_tick : process(clk)
	begin
	if (rising_edge(clk)) then
		-- Reset sets all to 0
		if (reset='1') then 
			control_signals <= "0000000000";
			voted_data_selector <= "000";
			do_ready <= '0';
			counter <= 0;
		else
			-- di_ready is set to 1 (usually when counter is 0)
			-- initializes counter and sets first register for saving
			if (di_ready == '1') then
				counter <= 1;
			-- 
			elsif (
				
		end if;
	end if;
	
	end process;
	
	set_input_read: process(counter)
	begin
		case counter is
			when 
		
		
	end process;
	
	
end controller;
