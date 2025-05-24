library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OutputBuffer_tb is
end entity;

architecture testbench of OutputBuffer_tb is

    component OutputBuffer
        port (
            D      : in  std_logic_vector(3 downto 0);
            LOAD   : in  std_logic;
            ACK    : in  std_logic;
            CLK    : in  std_logic;
            RESET  : in  std_logic;
            Q      : out std_logic_vector(3 downto 0);
            OBfree : out std_logic;
            Dval   : out std_logic
        );
    end component;

    signal D      : std_logic_vector(3 downto 0) := (others => '0');
    signal LOAD   : std_logic := '0';
    signal ACK    : std_logic := '0';
    signal CLK    : std_logic := '0';
    signal RESET  : std_logic := '1'; 
    signal Q      : std_logic_vector(3 downto 0);
    signal OBfree : std_logic;
    signal Dval   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: OutputBuffer
        port map (
            D      => D,
            LOAD   => LOAD,
            ACK    => ACK,
            CLK    => CLK,
            RESET  => RESET,
            Q      => Q,
            OBfree => OBfree,
            Dval   => Dval
        );

    clk_process: process
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

        RESET <= '1';
        wait for 3 * CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;


        D <= "1010";
        LOAD <= '1';
        wait for CLK_PERIOD;
        LOAD <= '0';
        wait for 5 * CLK_PERIOD;
        ACK <= '1';
        wait for CLK_PERIOD;
        ACK <= '0';

        wait for 5 * CLK_PERIOD;

        D <= "0101";
        LOAD <= '1';
        wait for CLK_PERIOD;
        LOAD <= '0';
        wait for 5 * CLK_PERIOD;
        ACK <= '1';
        wait for CLK_PERIOD;
        ACK <= '0';

        wait for 5 * CLK_PERIOD;
		  
        wait;
    end process;

end architecture;
