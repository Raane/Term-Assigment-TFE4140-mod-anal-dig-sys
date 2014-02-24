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
begin										

end controller;
