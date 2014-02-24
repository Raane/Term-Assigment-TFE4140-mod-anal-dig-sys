library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
	 port(
		 di_ready : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 control_signals : out STD_LOGIC_VECTOR (8 downto 0)
	     );
end controller;

architecture controller of controller is
begin										

end controller;
