library ieee;
use ieee.std_logic_1164.all;

entity ParityCheck_tb is
end entity;

architecture behavior of ParityCheck_tb is

    component ParityCheck
        port (
            CLK  : in std_logic;
            Data : in std_logic;
            init : in std_logic;
            Err  : out std_logic
        );
    end component;

    signal CLK  : std_logic := '0';
    signal Data : std_logic := '0';
    signal init : std_logic := '0';
    signal Err  : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: ParityCheck
        port map (
            CLK  => CLK,
            Data => Data,
            init => init,
            Err  => Err
        );

    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    stim_proc: process
    begin
        init <= '1';
        wait for CLK_PERIOD;
        init <= '0';

        Data <= '1'; wait for CLK_PERIOD;
        Data <= '0'; wait for CLK_PERIOD;
        Data <= '1'; wait for CLK_PERIOD;
		  Data <= '1'; wait for CLK_PERIOD;
		  Data <= '1'; wait for CLK_PERIOD;
		  Data <= '0'; wait for CLK_PERIOD;

        init <= '1'; wait for CLK_PERIOD;
        init <= '0';

        Data <= '1'; wait for CLK_PERIOD;
        Data <= '1'; wait for CLK_PERIOD;
        Data <= '1'; wait for CLK_PERIOD;
		  Data <= '1'; wait for CLK_PERIOD;
		  Data <= '1'; wait for CLK_PERIOD;
		  Data <= '0'; wait for CLK_PERIOD;

        wait;
    end process;

end architecture;
