library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MemoryAddressControl_tb is
end entity;

architecture behavior of MemoryAddressControl_tb is

    component MemoryAddressControl
        port (
            CLK       : in  std_logic;
            RESET     : in  std_logic;
            PUTnotGET : in  std_logic;
            incPut    : in  std_logic;
            incGet    : in  std_logic;
            address   : out std_logic_vector(3 downto 0);
            Full      : out std_logic;
            Empty     : out std_logic
        );
    end component;

    signal CLK       : std_logic := '0';
    signal RESET     : std_logic := '1';
    signal PUTnotGET : std_logic := '1'; 
    signal incPut    : std_logic := '0';
    signal incGet    : std_logic := '0';

    signal address   : std_logic_vector(3 downto 0);
    signal Full      : std_logic;
    signal Empty     : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: MemoryAddressControl
        port map (
            CLK       => CLK,
            RESET     => RESET,
            PUTnotGET => PUTnotGET,
            incPut    => incPut,
            incGet    => incGet,
            address   => address,
            Full      => Full,
            Empty     => Empty
        );

    clk_process: process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    stim_proc: process
    begin

        RESET <= '1';
        wait for 30 ns;
        RESET <= '0';
        wait for CLK_PERIOD;

		  
        -- Incrementar put (simular escrita)
        PUTnotGET <= '1';
        for i in 0 to 15 loop 
            incPut <= '1';
            wait for CLK_PERIOD;
            incPut <= '0';
            wait for CLK_PERIOD;
        end loop;

        wait for 5 * CLK_PERIOD;

        -- Incrementar get (simular leitura)
        PUTnotGET <= '0';
        for i in 0 to 15 loop
            incGet <= '1';
            wait for CLK_PERIOD;
            incGet <= '0';
            wait for CLK_PERIOD;
        end loop;

        wait for 5 * CLK_PERIOD;

    end process;

end behavior;
