library ieee;
use ieee.std_logic_1164.all;

entity OutputBufferControl is
    port(
        LOAD   : in std_logic;    
        ACK    : in std_logic;    
        CLK    : in std_logic;
        RESET  : in std_logic;
        Wreg   : out std_logic;   
        OBfree : out std_logic;   
        Dval   : out std_logic    
    );
end entity;

architecture behavioral of OutputBufferControl is

    type STATE_TYPE is (STATE_OBFREE, STATE_WREG, STATE_DVAL);
    signal CurrentState, NextState : STATE_TYPE;

begin

    CurrentState <= STATE_OBFREE when RESET = '1' else NextState when rising_edge(CLK);

    process(CurrentState, LOAD, ACK)
    begin
        case CurrentState is
            when STATE_OBFREE =>
                if LOAD = '1' then
                    NextState <= STATE_WREG;
                else
                    NextState <= STATE_OBFREE;
                end if;

            when STATE_WREG =>
                NextState <= STATE_DVAL;

            when STATE_DVAL =>
                if ACK = '1' then
                    NextState <= STATE_OBFREE;
                else
                    NextState <= STATE_DVAL;
                end if;
        end case;
    end process;

    OBfree <= '1' when CurrentState = STATE_OBFREE else '0';
    Wreg   <= '1' when CurrentState = STATE_WREG else '0';
    Dval   <= '1' when CurrentState = STATE_DVAL else '0';

end architecture;
