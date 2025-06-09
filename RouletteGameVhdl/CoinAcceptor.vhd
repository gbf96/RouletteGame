library ieee;
use ieee.std_logic_1164.all;

entity CoinAcceptor is 
	port(
		accept:   in std_logic;
		Coin  : in std_logic;
		clk   : in std_logic;
		RESET : in std_logic;
		CoinOut  : out std_logic
	);
end entity;

architecture behavioral of CoinAcceptor is

	type STATE_TYPE is (STATE_WAIT, STATE_ACCEPT);
	signal CurrentState, NextState : STATE_TYPE;

begin

	CurrentState <= STATE_WAIT when RESET = '1' else NextState when rising_edge(clk);

	process(CurrentState, Coin)
	begin
		case CurrentState is
			when STATE_WAIT =>
				if (accept = '1') then
					NextState <= STATE_ACCEPT;
				else
					NextState <= STATE_WAIT;
				end if;
	
			when STATE_ACCEPT =>
				if (Coin = '0') then
					NextState <= STATE_WAIT;
				else
					NextState <= STATE_ACCEPT;
				end if;
				
		end case;
	end process;

	CoinOut <= '1' when (CurrentState = STATE_WAIT and Coin = '1') else '0';
	
end architecture;
