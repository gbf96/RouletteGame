library ieee;
use ieee.std_logic_1164.all;

entity SLCDC_tb is
end entity;

architecture testbench of SLCDC_tb is

    -- Declaração do componente
    component SLCDC
        port(
            SDX    : in std_logic;
            SCLK   : in std_logic;
            clk    : in std_logic;
            notSS  : in std_logic;
            Dout   : out std_logic_vector(4 downto 0);
            Wrl    : out std_logic;
            RESET  : in std_logic
        );
    end component;

    -- Sinais para conectar ao UUT
    signal SDX    : std_logic := '0';
    signal SCLK   : std_logic := '0';
    signal clk    : std_logic := '0';
    signal notSS  : std_logic := '1'; -- inicialmente inativo
    signal Dout   : std_logic_vector(4 downto 0);
    signal Wrl    : std_logic;
    signal RESET  : std_logic := '0';

    constant CLK_PERIOD : time := 10 ns;
    constant SCLK_PERIOD : time := 20 ns;

begin

    -- Instância da unidade em teste (UUT)
    UUT: SLCDC port map(
        SDX    => SDX,
        SCLK   => SCLK,
        clk    => clk,
        notSS  => notSS,
        Dout   => Dout,
        Wrl    => Wrl,
        RESET  => RESET
    );

    -- Geração do clock principal (clk)
    clk_process : process
    begin
        while now < 2000 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Geração do clock Serial (SCLK)
    sclk_process : process
    begin
        while now < 2000 ns loop
            SCLK <= '0';
            wait for SCLK_PERIOD / 2;
            SCLK <= '1';
            wait for SCLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Estímulos
    stim_proc : process
    begin
        -- Reset inicial
        RESET <= '1';
        wait for 2 * CLK_PERIOD;
        RESET <= '0';
        wait for 2 * CLK_PERIOD;

        -- Começar transmissão: baixar notSS
        notSS <= '0'; wait for SCLK_PERIOD;
        
        -- Enviar 5 bits via SDX, sincronizados com SCLK
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
		  SDX <= '0'; wait for SCLK_PERIOD;

        -- Terminar transmissão: levantar notSS
        notSS <= '1';
        
        wait for 10 * SCLK_PERIOD;

        -- Segunda transmissão
        notSS <= '0'; wait for SCLK_PERIOD;

        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
		  SDX <= '1'; wait for SCLK_PERIOD;

        notSS <= '1';
        

        wait;

    end process;

end architecture;
