library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RouletteGame_tb is
end entity;

architecture testbench of RouletteGame_tb is

    signal LIN    : std_logic_vector(3 downto 0);
    signal COL    : std_logic_vector(3 downto 0);
    signal CLK    : std_logic := '0';
    signal ACK    : std_logic := '0';
    signal RESET  : std_logic := '0';
    signal Q      : std_logic_vector(3 downto 0);
    signal Dval   : std_logic;

    constant CLK_PERIOD : time := 1 ns;

-- UUT signals
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

-- Unit Under Test
    UUT: RouletteGame port map(
        LIN    => LIN,
        COL    => COL,
        CLK    => CLK,
        ACK    => ACK,
        RESET  => RESET,
        Q      => Q,
        Dval   => Dval
    );

    
    CLK_process: process
    begin
        while now < 200 ns loop  
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    Stimulus: process
begin
    
    RESET <= '1';
    wait for 20 ns;
    RESET <= '0';

    LIN <= "1111";  -- Nenhuma tecla pressionada
    ACK <= '0';
    wait for 50 ns;

    LIN <= "1101";  -- Linha 2 pressionada
    wait for 50 ns;

   
    ACK <= '1';
    wait for 10 ns;
    ACK <= '0';
    LIN <= "1111";  -- Soltar a tecla
    wait for 10 ns;

    
    LIN <= "0111";  -- Linha 4 pressionada
    wait for 30 ns;

    wait;
end process;

end testbench;
