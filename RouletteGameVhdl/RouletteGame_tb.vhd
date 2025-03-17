library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RouletteGame_tb is
end entity;

architecture testbench of RouletteGame_tb is

    -- Signals for test
    signal LIN    : std_logic_vector(3 downto 0);
    signal COL    : std_logic_vector(3 downto 0);
    signal CLK    : std_logic := '0';
    signal ACK    : std_logic := '0';
    signal RESET  : std_logic := '0';
    signal Q      : std_logic_vector(3 downto 0);
    signal Dval   : std_logic;

    -- Clock period
    constant CLK_PERIOD : time := 1 ns;

    -- Component under test
    component RouletteGame
        port(
            LIN    : in std_logic_vector(3 downto 0);
            COL    : out std_logic_vector(3 downto 0);
            CLK    : in std_logic;
            ACK    : in std_logic;
            RESET  : in std_logic;
            Q      : out std_logic_vector(3 downto 0);
            Dval   : out std_logic
        );
    end component;

begin

    -- Instantiate the unit under test (UUT)
    UUT: RouletteGame port map(
        LIN    => LIN,
        COL    => COL,
        CLK    => CLK,
        ACK    => ACK,
        RESET  => RESET,
        Q      => Q,
        Dval   => Dval
    );

    -- Clock process
    CLK_process: process
    begin
        while now < 200 ns loop  -- Run for a limited time
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    Stimulus: process
begin
    -- Apply Reset
    RESET <= '1';
    wait for 20 ns;
    RESET <= '0';

    -- Test case 1: No key pressed (Active Low)
    LIN <= "1111";  -- Nenhuma tecla pressionada
    ACK <= '0';
    wait for 50 ns;

    -- Test case 2: Simulate a key press on line 2 (Active Low)
    LIN <= "1101";  -- Linha 2 pressionada
    wait for 50 ns;

    -- Test case 3: Send an acknowledgment signal
    ACK <= '1';
    wait for 10 ns;
    ACK <= '0';
    LIN <= "1111";  -- Soltar a tecla
    wait for 10 ns;

    -- Test case 4: Simulate another key press (Active Low)
    LIN <= "0111";  -- Linha 4 pressionada
    wait for 30 ns;

    -- End simulation
    wait;
end process;

end testbench;
