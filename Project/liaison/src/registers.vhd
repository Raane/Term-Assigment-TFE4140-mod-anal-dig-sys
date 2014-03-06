library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity registers is
	 port(
		 voted_data_bit : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 status : in STD_LOGIC_VECTOR(2 downto 0);
		 control_signals : in STD_LOGIC_VECTOR(9 downto 0);
		 ECC_signal : in STD_LOGIC_VECTOR(3 downto 0);
		 voted_data_out : out STD_LOGIC_VECTOR(7 downto 0);
		 status_out : out STD_LOGIC_VECTOR(2 downto 0);
		 ECC_out : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end registers;

architecture registers of registers is

signal voted_data_reg: STD_LOGIC_VECTOR (7 downto 0);
signal status_reg: STD_LOGIC_VECTOR (2 downto 0);
signal ECC_reg: STD_LOGIC_VECTOR (3 downto 0);

begin	
	
-- Connect the registers to the outputs
process(voted_data_reg, status_reg, ECC_reg)
begin
	voted_data_out <= voted_data_reg;
	status_out <= status_reg;
	ECC_out <= ECC_reg; 
end process;
	
-- Add registers for storage of data
process(clk)
begin
	if rising_edge(clk) then
		if(reset='1') then
			voted_data_reg <= "00000000";
			status_reg <= "000";
			ECC_reg <= "0000";
		else
			if control_signals(0) = '1' then
				voted_data_reg(0) <= voted_data_bit;
			end if;
			if control_signals(1) = '1' then
				voted_data_reg(1) <= voted_data_bit;
			end if;
			if control_signals(2) = '1' then
				voted_data_reg(2) <= voted_data_bit;
			end if;
			if control_signals(3) = '1' then
				voted_data_reg(3) <= voted_data_bit;
			end if;
			if control_signals(4) = '1' then
				voted_data_reg(4) <= voted_data_bit;
			end if;
			if control_signals(5) = '1' then
				voted_data_reg(5) <= voted_data_bit;
			end if;
			if control_signals(6) = '1' then
				voted_data_reg(6) <= voted_data_bit;
			end if;
			if control_signals(7) = '1' then
				voted_data_reg(7) <= voted_data_bit;
			end if;
			if control_signals(8) = '1' then
				status_reg <= status;
			end if;
			if control_signals(9) = '1' then
				ECC_reg <= ECC_signal;
			end if;
		end if;
	end if;	
end process;
end registers;