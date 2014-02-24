library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity registers is
	 port(
		 voted_data_bit : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 status_bus : in STD_LOGIC_VECTOR(2 downto 0);
		 controll_signals : in STD_LOGIC_VECTOR(8 downto 0);
		 ECC : in STD_LOGIC_VECTOR(7 downto 0);
		 voted_data_bus_out : out STD_LOGIC_VECTOR(7 downto 0);
		 status_bus_out : out STD_LOGIC_VECTOR(2 downto 0)
	     );
end registers;

architecture registers of registers is
begin

end registers;
