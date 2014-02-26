library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity liaison_tb is
end liaison_tb;

architecture TB_ARCHITECTURE of liaison_tb is
	-- Component declaration of the tested unit
	component liaison
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		di_ready : in STD_LOGIC;
		mp_data : in STD_LOGIC_VECTOR(3 downto 0);
		do_ready : out STD_LOGIC;
		voted_data : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal di_ready : STD_LOGIC;
	signal mp_data : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal do_ready : STD_LOGIC;
	signal voted_data : STD_LOGIC;

	-- Add your code here ...

begin
	
   	stim_proc: process
   	begin
		-- Set inputs to 0
		di_ready <= '0';
		mp_data <= "1111";
		reset <= '0';
		wait for 10 ns;
		reset <= '1';
		wait for 10 ns;
		reset <= '0';
		wait for 10 ns;
		di_ready <= '1';
		wait for 10 ns;
		di_ready <= '0';
		wait for 30 ns;
		mp_data <= "0000";
		wait for 150 ns;
		mp_data <= "0001";
		di_ready <= '1';
		wait for 10 ns;
		di_ready <= '0';
		
		wait;
   	end process;
		   
	-- Unit Under Test port map
	UUT : liaison
		port map (
			clk => clk,
			reset => reset,
			di_ready => di_ready,
			mp_data => mp_data,
			do_ready => do_ready,
			voted_data => voted_data
		);

   -- This drive the clock
   clk_process :process
   begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
   end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_liaison of liaison_tb is
	for TB_ARCHITECTURE
		for UUT : liaison
			use entity work.liaison(liaison);
		end for;
	end for;
end TESTBENCH_FOR_liaison;

