library ieee;
use ieee.std_logic_1164.all;

entity LCDDispatcher is 
	port(
		Din   : in std_logic_vector(4 downto 0);
		Dval  : in std_logic;
		clk   : in std_logic;
		RESET : in std_logic;
		Dout  : out std_logic_vector(4 downto 0);
		Wrl   : out std_logic;
		done  : out std_logic
	);
end entity;

architecture behavioral of LCDDispatcher is

	type STATE_TYPE is (STATE_WAIT, STATE_WRITE,STATE_DONE);
	signal CurrentState, NextState : STATE_TYPE;

begin

	-- Flip-Flop de Estado
	CurrentState <= STATE_WAIT when RESET = '1' else NextState when rising_edge(clk);

	-- Geração do próximo estado
	process(CurrentState, Dval)
	begin
		case CurrentState is
			when STATE_WAIT =>
				if Dval = '1' then
					NextState <= STATE_WRITE;
				else
					NextState <= STATE_WAIT;
				end if;

			when STATE_WRITE =>
					NextState <= STATE_DONE;
			when STATE_DONE	=>
				if Dval = '0' then
					NextState <= STATE_WAIT;
				else
					NextState <= STATE_DONE;
				end if;
		end case;
	end process;

	-- Saídas
	Dout <= Din;

	Wrl  <= '1' when (CurrentState = STATE_WRITE) else '0';
	done <= '1' when (CurrentState = STATE_DONE) else '0';

end architecture;
