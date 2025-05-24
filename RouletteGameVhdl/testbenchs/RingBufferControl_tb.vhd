library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RingBufferControl_tb is
end entity;

architecture testbench of RingBufferControl_tb is

    component RingBufferControl
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
    end component;

    signal DAV     : std_logic := '0';
    signal CTS     : std_logic := '0';
    signal Full    : std_logic := '0';
    signal Empty   : std_logic := '0';
    signal clk     : std_logic := '0';
    signal RESET   : std_logic := '1';

    signal DAC     : std_logic;
    signal incPut  : std_logic;
    signal incGet  : std_logic;
    signal putget  : std_logic;
    signal Wr      : std_logic;
    signal Wreg    : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: RingBufferControl
        port map (
            DAV     => DAV,
            CTS     => CTS,
            Full    => Full,
            Empty   => Empty,
            clk     => clk,
            RESET   => RESET,
            DAC     => DAC,
            incPut  => incPut,
            incGet  => incGet,
            putget  => putget,
            Wr      => Wr,
            Wreg    => Wreg
        );

    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD/2;
            clk <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    stim_proc: process
    begin
	 
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for CLK_PERIOD * 2;

        -- Simula escrita
        DAV <= '1';
        Full <= '0';
        Empty <= '1';
        CTS <= '0';
        wait for 3 * CLK_PERIOD;

        DAV <= '0';  
        wait for 3 * CLK_PERIOD;

        -- Simula leitura
        CTS <= '1';
        Empty <= '0';
        DAV <= '0';
        Full <= '0';
        wait for 3 * CLK_PERIOD;

        CTS <= '0';
        wait for 2 * CLK_PERIOD;

        -- Simula buffer cheio Full=1, DAV=1 deve ignorar escrita
        Full <= '1';
        DAV <= '1';
        wait for 3 * CLK_PERIOD;

        DAV <= '0';
        Full <= '0';
        wait for 2 * CLK_PERIOD;

        -- Simula buffer vazio Empty=1, CTS=1 deve ignorar leitura
        Empty <= '1';
        CTS <= '1';
        wait for 3 * CLK_PERIOD;

        CTS <= '0';
        wait for 2 * CLK_PERIOD;

        wait;
    end process;

end architecture;
