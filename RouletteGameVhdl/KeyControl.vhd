library ieee;
use ieee.std_logic_1164.all;

entity KeyControl is
port(
		Kpress 		: in std_logic;
		CLK		: in std_logic;
		Kack				: in std_logic;
		RESET   : in std_logic;
		Kscan			: out std_logic;
		Kval	: out std_logic
);
end entity;

architecture behavioral of KeyControl is

type STATE_TYPE is (STATE_SCAN, STATE_PROCESS, STATE_WAIT);

signal CurrentState, NextState : STATE_TYPE;

begin

-- Flip-Flop's 
CurrentState <= STATE_SCAN when RESET = '1' else NextState when rising_edge(clk);

-- Generate Next State 
GenerateNextState:
process (CurrentState, Kack, Kpress)
	begin
		case CurrentState is
			when STATE_SCAN		=>	if (Kpress = '1') then 
												NextState <= STATE_PROCESS;
											else 
												NextState <= STATE_SCAN;
											end if;
											
			when STATE_PROCESS	=>	if (Kack = '1') then 
												NextState <= STATE_WAIT;
											else 
												NextState <= STATE_PROCESS;
											end if;
											
			when STATE_WAIT		=>	if (Kpress = '0' and Kack = '0') then
												NextState <= STATE_SCAN;
											else
												NextState <= STATE_WAIT;
											end if;
											
		end case;
	end process;
	
-- Generate outputs
Kval <= '1' when (CurrentState = STATE_PROCESS) else '0';
		
Kscan <= '1' when (CurrentState = STATE_SCAN) else '0';

end behavioral;