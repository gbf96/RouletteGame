library ieee;
use ieee.std_logic_1164.all;

entity RingBufferControl is 
    port (
        DAV     : in  std_logic;
        CTS     : in  std_logic;
        Full    : in  std_logic;
        Empty   : in  std_logic;
        clk     : in  std_logic;
        RESET   : in  std_logic;

        DAC     : out std_logic;
        incPut  : out std_logic;
        incGet  : out std_logic;
        putget  : out std_logic;
        Wr      : out std_logic; 
        Wreg    : out std_logic  
    );
end entity;

architecture behavioral of RingBufferControl is

    type STATE_TYPE is (
        STATE_IDLE,
        STATE_WRITE,
        STATE_WAIT_DAV_LOW,
        STATE_READ,
        STATE_inc_READ
    );

    signal CurrentState, NextState : STATE_TYPE;

begin

    CurrentState <= STATE_IDLE when RESET = '1' else NextState when rising_edge(clk);

    process (CurrentState, DAV, CTS, Full, Empty)
    begin
        case CurrentState is
            when STATE_IDLE =>
                if (DAV = '1' and Full = '0') then 
                     NextState <= STATE_WRITE;
                elsif (CTS = '1' and Empty = '0') then 
                    NextState <= STATE_READ;
                else
                    NextState <= STATE_IDLE;
                end if;

            when STATE_WRITE =>
                  NextState <= STATE_WAIT_DAV_LOW;
						
            when STATE_WAIT_DAV_LOW =>
                if DAV = '0' then
                    NextState <= STATE_IDLE;
                else
                    NextState <= STATE_WAIT_DAV_LOW;
                end if;

            when STATE_READ =>
                    NextState <= STATE_inc_READ;
						  
				when STATE_inc_READ =>
                    NextState <= STATE_IDLE;
                
                    

        end case;
    end process;

    putget <= '1' when (CurrentState = STATE_WRITE or CurrentState = STATE_WAIT_DAV_LOW or (CurrentState = STATE_IDLE and DAV = '1' and Full = '0')) else '0';

    DAC     <= '1' when (CurrentState = STATE_WAIT_DAV_LOW ) else '0';
    incPut <= '1' when (CurrentState = STATE_WAIT_DAV_LOW and DAV = '0') else '0';
	 
	 incGet <= '1' when (CurrentState = STATE_inc_READ) else '0';
	 Wreg   <= '1' when (CurrentState = STATE_READ) else '0';

    Wr      <= '1' when (CurrentState = STATE_WRITE) else '0';

end behavioral;
