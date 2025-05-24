library ieee;
use ieee.std_logic_1164.all;

entity SerialControl is
port(
		enRX 		: in std_logic;
		dFlag		: in std_logic;
		clk		: in std_logic;
		pFlag				: in std_logic;
		RXerror		: in std_logic;
		accept		: in std_logic;
		RESET   : in std_logic;
		wr			: out std_logic;
		init			: out std_logic;
		DXval	: out std_logic
);
end entity;

architecture behavioral of SerialControl is

type STATE_TYPE is (STATE_OFF, STATE_WRITE, STATE_WRITE_OFF, STATE_WAIT);

signal CurrentState, NextState : STATE_TYPE;

begin

CurrentState <= STATE_OFF when RESET = '1' else NextState when rising_edge(clk);

GenerateNextState:
process (CurrentState, enRX, dFlag, pFlag, RXerror, accept)
begin
    case CurrentState is
        when STATE_OFF =>
            if (enRX = '0') then 
                NextState <= STATE_WRITE;
            else 
                NextState <= STATE_OFF;
            end if;

        when STATE_WRITE =>
            if (dFlag = '1') then 
                NextState <= STATE_WRITE_OFF;
            else 
                NextState <= STATE_WRITE;
            end if;

        when STATE_WRITE_OFF =>
            if (pFlag = '0') then
                NextState <= STATE_WRITE_OFF;
            elsif (pFlag = '1' and RXerror = '0') then
                NextState <= STATE_OFF;
            else
                NextState <= STATE_WAIT;
            end if;

        when STATE_WAIT =>
            if (accept = '1' and enRX = '1') then 
                NextState <= STATE_OFF;
            else 
                NextState <= STATE_WAIT;
            end if;
    end case;
end process;

init <= '1' when (CurrentState = STATE_OFF and  enRX = '0') else '0';
		
wr <= '1' when (CurrentState = STATE_WRITE and dFlag = '0') else '0';

DXval <= '1' when (CurrentState = STATE_WAIT) else '0';

end behavioral;