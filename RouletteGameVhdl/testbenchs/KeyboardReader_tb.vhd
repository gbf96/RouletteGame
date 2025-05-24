library ieee;
use ieee.std_logic_1164.all;

entity KeyboardReader_tb is
end entity;

architecture testbench of KeyboardReader_tb is

    component KeyboardReader
        port(
            LIN      : in  std_logic_vector(3 downto 0);
            COL      : out std_logic_vector(3 downto 0);
            CLK      : in  std_logic;
            ACK      : in  std_logic;
            RESET    : in  std_logic;
            Q        : out std_logic_vector(3 downto 0);
            Dval     : out std_logic
        );
    end component;

    component KeyDecode
        port(
            LIN   : in  std_logic_vector(3 downto 0);
            COL   : out std_logic_vector(3 downto 0);
            CLK   : in  std_logic;
            Kack  : in  std_logic;
            RESET : in  std_logic;
            Q     : out std_logic_vector(3 downto 0);
            Kval  : out std_logic
        );
    end component;

    component RingBuffer
        port(
            D     : in  std_logic_vector(3 downto 0);
            CTS   : in  std_logic;
            DAV   : in  std_logic;
            RESET : in  std_logic;
            CLK   : in  std_logic;
            Q     : out std_logic_vector(3 downto 0);
            Wreg  : out std_logic;
            DAC   : out std_logic
        );
    end component;

    component OutputBuffer
        port(
            D      : in  std_logic_vector(3 downto 0);
            LOAD   : in  std_logic;
            CLK    : in  std_logic;
            RESET  : in  std_logic;
            ACK    : in  std_logic;
            Q      : out std_logic_vector(3 downto 0);
            Dval   : out std_logic;
            OBfree : out std_logic
        );
    end component;

    signal LIN      : std_logic_vector(3 downto 0) := (others => '0');
    signal COL      : std_logic_vector(3 downto 0);
    signal CLK      : std_logic := '0';
    signal ACK      : std_logic := '0';
    signal RESET    : std_logic := '1';
    signal Q        : std_logic_vector(3 downto 0);
    signal Dval     : std_logic;

    signal key_data : std_logic_vector(3 downto 0);
    signal key_valid: std_logic;
    signal ring_out : std_logic_vector(3 downto 0);
    signal Wreg_int : std_logic;
    signal DAC_int  : std_logic;
    signal OBfree   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    KeyboardReader_inst: KeyboardReader
    port map (
        LIN      => LIN,
        COL      => COL,
        CLK      => CLK,
        ACK      => ACK,
        RESET    => RESET,
        Q        => Q,
        Dval     => Dval
    );

    KeyDecode_inst: KeyDecode
    port map (
        LIN   => LIN,
        COL   => COL,
        CLK   => CLK,
        Kack  => DAC_int,
        RESET => RESET,
        Q     => key_data,
        Kval  => key_valid
    );

    RingBuffer_inst: RingBuffer
    port map (
        D     => key_data,
        CTS   => OBfree,
        DAV   => key_valid,
        RESET => RESET,
        CLK   => CLK,
        Q     => ring_out,
        Wreg  => Wreg_int,
        DAC   => DAC_int
    );

    OutputBuffer_inst: OutputBuffer
    port map (
        D      => ring_out,
        LOAD   => Wreg_int,
        CLK    => CLK,
        RESET  => RESET,
        ACK    => ACK,
        Q      => Q,
        Dval   => Dval,
        OBfree => OBfree
    );

    clk_gen: process
    begin
        while now < 10000 ns loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
			
    process
    begin

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

        wait for 20 ns;

        -- Teste 2: Pressionar segunda tecla
        LIN <= "1101";
        wait for 16 * CLK_PERIOD; 
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 3: Pressionar terceira tecla
        LIN <= "1011";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 4: Pressionar quarta tecla
        LIN <= "0111";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";
		  wait for 20 ns;
		
		 -- Teste 5: Pressionar primeira tecla
        LIN <= "1110";
        wait for 16 * CLK_PERIOD;

        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 6: Pressionar segunda tecla
        LIN <= "1101";
        wait for 16 * CLK_PERIOD; 
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 7: Pressionar terceira tecla
        LIN <= "1011";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 8: Pressionar quarta tecla
        LIN <= "0111";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";
		wait for 20 ns;
		
		  -- Teste 9: Pressionar primeira tecla
        LIN <= "1110";
        wait for 16 * CLK_PERIOD;

        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 10: Pressionar segunda tecla
        LIN <= "1101";
        wait for 16 * CLK_PERIOD; 
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 11: Pressionar terceira tecla
        LIN <= "1011";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 12: Pressionar quarta tecla
        LIN <= "0111";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";
		wait for 20 ns;
		
		 -- Teste 13: Pressionar primeira tecla
        LIN <= "1110";
        wait for 16 * CLK_PERIOD;

        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 14: Pressionar segunda tecla
        LIN <= "1101";
        wait for 16 * CLK_PERIOD; 
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 15: Pressionar terceira tecla
        LIN <= "1011";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 16: Pressionar quarta tecla
        LIN <= "0111";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";
		wait for 20 ns;
		
		 -- Teste 17: Pressionar primeira tecla
        LIN <= "1110";
        wait for 16 * CLK_PERIOD;

        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 18: Pressionar segunda tecla
        LIN <= "1101";
        wait for 16 * CLK_PERIOD; 
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 19: Pressionar terceira tecla
        LIN <= "1011";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";

        wait for 20 ns;

        -- Teste 20: Pressionar quarta tecla
        LIN <= "0111";
        wait for 16 * CLK_PERIOD;
        wait for 10 ns;

        -- Liberar tecla e enviar ACK
        LIN <= "1111";
		wait for 20 ns;
		
		
		
        -- Envio repetido de ACK para validar leitura
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 20 ns;
		  
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
        wait for 20 ns;
		  
        ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  
		  ACK <= '1';
        wait for 20 ns;
        ACK <= '0';
		  wait for 20 ns;
		  

        wait for 50 ns;

        wait;
    end process;

end architecture;

