library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RouletteDispatcher_tb is
end entity;

architecture testbench of RouletteDispatcher_tb is

    component RouletteDispatcher
        port(
            Din   : in std_logic_vector(7 downto 0);
            Dval  : in std_logic;
            clk   : in std_logic;
            RESET : in std_logic;
            Dout  : out std_logic_vector(7 downto 0);
            WrD   : out std_logic;
            done  : out std_logic
        );
    end component;

    signal Din   : std_logic_vector(7 downto 0) := (others => '0');
    signal Dval  : std_logic := '0';
    signal clk   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal Dout  : std_logic_vector(7 downto 0);
    signal WrD   : std_logic;
    signal done  : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    UUT: RouletteDispatcher
        port map (
            Din   => Din,
            Dval  => Dval,
            clk   => clk,
            RESET => RESET,
            Dout  => Dout,
            WrD   => WrD,
            done  => done
        );

    clk_process: process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        RESET <= '1';
        wait for 2 * CLK_PERIOD;
        RESET <= '0';

        Din  <= "10101010";
        Dval <= '1';
        wait for CLK_PERIOD;

        Dval <= '1';
        wait for CLK_PERIOD;

        Dval <= '0';
        wait for CLK_PERIOD;

        Din <= "11110000";
        Dval <= '1';
        wait for CLK_PERIOD;

        Dval <= '0';
        wait;

    end process;

end architecture;
