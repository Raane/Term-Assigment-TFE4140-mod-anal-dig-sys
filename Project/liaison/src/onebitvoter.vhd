library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity onebitvoter is
	 port(
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 md_data : in STD_LOGIC_VECTOR(3 downto 0);
		 voted_data_bit : out STD_LOGIC;
		 status : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end onebitvoter;

architecture onebitvoter of onebitvoter is
begin

end onebitvoter;
