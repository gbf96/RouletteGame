library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RingBuffer_tb is
end entity;

architecture testbench of RingBuffer_tb is

    component RingBufferControl
        port(
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

    component MemoryAddressControl
        port(
            CLK       : in std_logic;
            RESET     : in std_logic;
            PUTnotGET : in std_logic;
            incPut    : in std_logic;
            incGet    : in std_logic;
            address   : out std_logic_vector(3 downto 0);
            Full      : out std_logic;
            Empty     : out std_logic
        );
    end component;

    component RAM
        generic (
            ADDRESS_WIDTH : integer := 4;
            DATA_WIDTH    : integer := 4
        );
        port(
            address : in std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
            wr      : in std_logic;
            din     : in std_logic_vector(DATA_WIDTH - 1 downto 0);
            dout    : out std_logic_vector(DATA_WIDTH - 1 downto 0)
        );
    end component;

    signal D         : std_logic_vector(3 downto 0) := (others => '0');
    signal CTS       : std_logic := '0';
    signal DAV       : std_logic := '0';
    signal RESET     : std_logic := '0';
    signal CLK       : std_logic := '0';
    signal Q         : std_logic_vector(3 downto 0);
    signal Wreg      : std_logic;
    signal DAC       : std_logic;
    signal incPut    : std_logic;
    signal incGet    : std_logic;
    signal putget    : std_logic;
    signal Wr        : std_logic;
    signal Full      : std_logic;
    signal Empty     : std_logic;
    signal address   : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    RingBufferControl_inst: RingBufferControl
        port map (
            DAV     => DAV,
            CTS     => CTS,
            Full    => Full,
            Empty   => Empty,
            clk     => CLK,
            RESET   => RESET,
            DAC     => DAC,
            incPut  => incPut,
            incGet  => incGet,
            putget  => putget,
            Wr      => Wr,
            Wreg    => Wreg
        );

    MemoryAddressControl_inst: MemoryAddressControl
        port map (
            CLK       => CLK,
            RESET     => RESET,
            PUTnotGET => putget,
            incPut    => incPut,
            incGet    => incGet,
            address   => address,
            Full      => Full,
            Empty     => Empty
        );

    RAM_inst: RAM
        port map (
            address => address,
            wr      => Wr,
            din     => D,
            dout    => Q
        );

    clk_process: process
    begin
        while now < 10000 ns loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;


          stim_process: process
    begin
        RESET <= '1';
        wait for 2 * CLK_PERIOD;
        RESET <= '0';

        -- PRODUÇÃO DE DADOS: enviar 20 valores individualmente.
        D <= "0000"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "0001"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "0010"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0';  wait for 2 * CLK_PERIOD;
        D <= "0011"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "0100"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "0101"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "0110"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "0111"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1000"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1001"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1010"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1011"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1100"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1101"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1110"; DAV <= '1'; wait until DAC = '1'; DAV <= '0'; wait until DAC = '0'; wait for 2 * CLK_PERIOD;
        D <= "1111"; DAV <= '1'; wait for 2 * CLK_PERIOD; DAV <= '0';wait for 2 * CLK_PERIOD;
        D <= "0000"; DAV <= '1'; wait for 2 * CLK_PERIOD; DAV <= '0'; wait for 2 * CLK_PERIOD;
        D <= "0001"; DAV <= '1'; wait for 2 * CLK_PERIOD; DAV <= '0';wait for 2 * CLK_PERIOD;
          D <= "0010"; DAV <= '1'; wait for 2 * CLK_PERIOD; DAV <= '0'; wait for 2 * CLK_PERIOD;
        D <= "0011"; DAV <= '1'; wait for 2 * CLK_PERIOD; DAV <= '0';wait for 2 * CLK_PERIOD;
		  
			--simular  leitura de dados
			wait for 5 * CLK_PERIOD;
        CTS <= '1'; 
       wait for 100 * CLK_PERIOD;
       
        -- Testar simultaneidade DAV + CTS
        D <= "1010";
        DAV <= '1';
        CTS <= '1';
        wait until DAC = '1';
        DAV <= '0';
        wait until DAC = '0';

        D <= "1000";
        DAV <= '1';
        wait until DAC = '1';
        DAV <= '0';
        wait until DAC = '0';

        wait for 5 * CLK_PERIOD;

        D <= "1111";
        DAV <= '1';
        wait until DAC = '1';
        DAV <= '0';
        wait until DAC = '0';

        wait for 20 * CLK_PERIOD;
        wait;
    end process;
end architecture;
