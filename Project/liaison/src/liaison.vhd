library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity liaison is
	 port(
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 di_ready : in STD_LOGIC;
		 mp_data : in STD_LOGIC_VECTOR(3 downto 0);
		 do_ready : out STD_LOGIC;
		 voted_data : out STD_LOGIC
	     );
end liaison;

architecture liaison of liaison is
begin
	onebitvoter: entity work.onebitvoter
	port map(
	clk => clk,
	reset => reset,
	md_data => md_data,
	voted_data => voted_data_bit,
	status => status
	);
	
	controller: entity work.controller
		port map(
			clk => clk,
			reset => reset,
			di_ready => di_ready,
			controll_signals
		);
		
	registers: entity work.registers
		port map(
		clk => clk,
		reset => reset,
		voted_data_bit => voted_data_bit,
		status => status,
		controll_signals => controll_signals,
		ECC => ECC,
		voted_data_out => voted_data_out,
		status_out => status_out
		);
		
	ECC: entity	work.ECC
		port map(
		voted_data_out => voted_data_out,
		status_out => status_out,
		ECC => ECC
		);

end liaison;
