library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity registers is
	 port(
		 voted_data_bit : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 status : in STD_LOGIC_VECTOR(2 downto 0);
		 control_signals : in STD_LOGIC_VECTOR(8 downto 0);
		 ECC_signal : in STD_LOGIC_VECTOR(7 downto 0);
		 voted_data_out : out STD_LOGIC_VECTOR(7 downto 0);
		 status_out : out STD_LOGIC_VECTOR(2 downto 0)
	     );
end registers;

architecture registers of registers is
begin

end registers;
