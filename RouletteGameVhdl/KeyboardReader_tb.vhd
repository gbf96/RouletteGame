library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity KeyboardReader_tb is
end entity;

architecture testbench of KeyboardReader_tb is

    
    component KeyboardReader
        port(
            LIN   : in std_logic_vector(3 downto 0);
            COL   : out std_logic_vector(3 downto 0);
            CLK   : in std_logic;
            ACK   : in std_logic;
            RESET : in std_logic;
            Q     : out std_logic_vector(3 downto 0);
            Dval  : out std_logic
        );
    end component;

    signal LIN   : std_logic_vector(3 downto 0) := "1111"; 
    signal COL   : std_logic_vector(3 downto 0);
    signal CLK   : std_logic := '0';
    signal ACK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal Q     : std_logic_vector(3 downto 0);
    signal Dval  : std_logic;
    
    
    constant CLK_PERIOD : time := 10 ns;
    
    begin
    
    
    UUT: KeyboardReader port map (
        LIN   => LIN,
        COL   => COL,
        CLK   => CLK,
        ACK   => ACK,
        RESET => RESET,
        Q     => Q,
        Dval  => Dval
    );
    
    process
    begin
        while now < 2000 ns loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    process
    begin
        -- Reset
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;
        
        -- Teste 1: Pressionar primeira tecla
        LIN <= "1110";
        wait for 16 * CLK_PERIOD;
   
        wait for 10 ns;
        
        -- Liberar tecla e enviar ACK
        LIN <= "1111";
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 40 ns;
        
        -- Teste 2: Pressionar segunda tecla
        LIN <= "1101";
        wait for 16 * CLK_PERIOD; 
        wait for 10 ns;
        
        -- Liberar tecla e enviar ACK
        LIN <= "1111";
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 40 ns;
        
        -- Teste 3: Pressionar terceira tecla
        LIN <= "1011";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;
        
        -- Liberar tecla e enviar ACK
        LIN <= "1111";
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 50 ns;
        
        -- Teste 4: Pressionar quarta tecla
        LIN <= "0111";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;
        
        -- Liberar tecla e enviar ACK
        LIN <= "1111";
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 50 ns;
        
        wait;
    end process;

end testbench;
