-------------------------------------------------------------------------------
--
-- Title       : controller
-- Design      : liaison
-- Author      : Ole Brumm
-- Company     : Hundremeterskogen Dataservice
--
-------------------------------------------------------------------------------
--
-- File        : controller.vhd
-- Generated   : Mon Feb 24 14:58:29 2014
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
--{entity {controller} architecture {controller}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controller is
	 port(
		 di_ready : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 controll_signals : out STD_LOGIC
	     );
end controller;

--}} End of automatically maintained section

architecture controller of controller is
begin

	 -- enter your statements here --

end controller;
