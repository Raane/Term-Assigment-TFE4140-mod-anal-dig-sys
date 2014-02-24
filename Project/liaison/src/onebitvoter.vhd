-------------------------------------------------------------------------------
--
-- Title       : onebitvoter
-- Design      : liaison
-- Author      : Ole Brumm
-- Company     : Hundremeterskogen Dataservice
--
-------------------------------------------------------------------------------
--
-- File        : onebitvoter.vhd
-- Generated   : Mon Feb 24 14:56:57 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {onebitvoter} architecture {onebitvoter}}

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

--}} End of automatically maintained section

architecture onebitvoter of onebitvoter is
begin

	 -- enter your statements here --

end onebitvoter;
