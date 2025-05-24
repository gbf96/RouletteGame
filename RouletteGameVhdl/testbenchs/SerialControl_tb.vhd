library ieee;
use ieee.std_logic_1164.all;

entity SerialControl_tb is
end entity;

architecture tb of SerialControl_tb is

    component SerialControl
        port(
            enRX    : in std_logic;
            dFlag   : in std_logic;
            clk     : in std_logic;
            pFlag   : in std_logic;
            RXerror : in std_logic;
            accept  : in std_logic;
            RESET   : in std_logic;
            wr      : out std_logic;
            init    : out std_logic;
            DXval   : out std_logic
        );
    end component;

    signal enRX, dFlag, clk, pFlag, RXerror, accept, RESET : std_logic := '0';
    signal wr, init, DXval : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: SerialControl
        port map (
            enRX    => enRX,
            dFlag   => dFlag,
            clk     => clk,
            pFlag   => pFlag,
            RXerror => RXerror,
            accept  => accept,
            RESET   => RESET,
            wr      => wr,
            init    => init,
            DXval   => DXval
        );

    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        RESET <= '1';
        wait for 2 * CLK_PERIOD;
        RESET <= '0';
		  wait for 2 * CLK_PERIOD;
		  
        enRX <= '0';
        wait for CLK_PERIOD;

        dFlag <= '0';
        wait for 2 * CLK_PERIOD;

        dFlag <= '1';
        wait for CLK_PERIOD;

        pFlag <= '0';
        wait for CLK_PERIOD;

        pFlag <= '1';
        RXerror <= '1';
        wait for CLK_PERIOD;

        enRX <= '1';
        accept <= '0';
        wait for 2 * CLK_PERIOD;

        accept <= '1';
        wait for CLK_PERIOD;

        wait for 2 * CLK_PERIOD;

        wait;
    end process;

end architecture;
