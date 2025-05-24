library ieee;
use ieee.std_logic_1164.all;

entity ShiftRegister_tb is
end entity;

architecture behavior of ShiftRegister_tb is

    component ShiftRegister
        port(
            CLK         : in std_logic;
            Data        : in std_logic;
            enableshift : in std_logic;
            D           : out std_logic_vector(4 downto 0)
        );
    end component;

    signal CLK         : std_logic := '0';
    signal Data        : std_logic := '0';
    signal enableshift : std_logic := '0';
    signal D           : std_logic_vector(4 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    DUT: ShiftRegister port map(
        CLK         => CLK,
        Data        => Data,
        enableshift => enableshift,
        D           => D
    );

    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    stim_proc : process
    begin
        enableshift <= '0';
        Data <= '0';
        wait for 20 ns;

        enableshift <= '1';

        Data <= '1'; wait for CLK_PERIOD;
        Data <= '0'; wait for CLK_PERIOD;
        Data <= '1'; wait for CLK_PERIOD;
        Data <= '1'; wait for CLK_PERIOD;
        Data <= '0'; wait for CLK_PERIOD;

        enableshift <= '0';
        wait;
    end process;

end architecture;
