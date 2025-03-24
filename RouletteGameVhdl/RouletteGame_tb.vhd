library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity RouletteGame_tb is
end entity;

architecture testbench of RouletteGame_tb is

    -- Component a ser testado
    component RouletteGame
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

    -- Sinais para conectar ao DUT (Device Under Test)
    signal LIN   : std_logic_vector(3 downto 0) := "1111"; -- Active low
    signal COL   : std_logic_vector(3 downto 0);
    signal CLK   : std_logic := '0';
    signal ACK   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal Q     : std_logic_vector(3 downto 0);
    signal Dval  : std_logic;
    
    -- Clock process (100 MHz -> 10 ns período)
    constant CLK_PERIOD : time := 10 ns;
    
    begin
    
    -- Instância do DUT
    UUT: RouletteGame port map (
        LIN   => LIN,
        COL   => COL,
        CLK   => CLK,
        ACK   => ACK,
        RESET => RESET,
        Q     => Q,
        Dval  => Dval
    );
    
    -- Processo de clock
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
        assert Dval = '1' report "Erro: Dval nao ativou corretamente para tecla 1!" severity error;
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
        assert Dval = '1' report "Erro: Dval nao ativou corretamente para tecla 2!" severity error;
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
        assert Dval = '1' report "Erro: Dval nao ativou corretamente para tecla 3!" severity error;
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
        assert Dval = '1' report "Erro: Dval nao ativou corretamente para tecla 4!" severity error;
        wait for 10 ns;
        
        -- Liberar tecla e enviar ACK
        LIN <= "1111";
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 50 ns;
        
        report "Testbench finalizado com sucesso!" severity note;
        wait;
    end process;

end testbench;
