library ieee;
use ieee.std_logic_1164.all;

entity LCDDispatcher_tb is
end entity;

architecture behavior of LCDDispatcher_tb is

    component LCDDispatcher
        port(
            Din   : in std_logic_vector(4 downto 0);
            Dval  : in std_logic;
            clk   : in std_logic;
            RESET : in std_logic;
            Dout  : out std_logic_vector(4 downto 0);
            Wrl   : out std_logic;
            done  : out std_logic
        );
    end component;

    signal Din   : std_logic_vector(4 downto 0) := (others => '0');
    signal Dval  : std_logic := '0';
    signal clk   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal Dout  : std_logic_vector(4 downto 0);
    signal Wrl   : std_logic;
    signal done  : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: LCDDispatcher
        port map (
            Din   => Din,
            Dval  => Dval,
            clk   => clk,
            RESET => RESET,
            Dout  => Dout,
            Wrl   => Wrl,
            done  => done
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
        wait for CLK_PERIOD;

        Din  <= "10101";
        Dval <= '1';
        wait for CLK_PERIOD;

        Dval <= '0';
        wait for CLK_PERIOD;

        wait for 3 * CLK_PERIOD;

        Din  <= "00011";
        Dval <= '1';
        wait for CLK_PERIOD;


        Dval <= '0';
        wait for CLK_PERIOD;

        wait for 3 * CLK_PERIOD;

        wait;
    end process;

end architecture;
