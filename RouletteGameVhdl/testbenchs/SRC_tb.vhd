library ieee;
use ieee.std_logic_1164.all;

entity SRC_tb is
end entity;

architecture testbench of SRC_tb is

    component SRC
        port(
            SDX    : in  std_logic;
            SCLK   : in  std_logic;
            clk    : in  std_logic;
            notSS  : in  std_logic;
            Dout   : out std_logic_vector(7 downto 0);
            WrD    : out std_logic;
            RESET  : in  std_logic
        );
    end component;

    component SerialReceiverR
        port(
            SDX    : in  std_logic;
            SCLK   : in  std_logic;
            notSS  : in  std_logic;
            accept : in  std_logic;
            D      : out std_logic_vector(7 downto 0);
            DXval  : out std_logic;
            RESET  : in  std_logic
        );
    end component;

    component RouletteDispatcher
        port(
            Din   : in  std_logic_vector(7 downto 0);
            Dval  : in  std_logic;
            clk   : in  std_logic;
            RESET : in  std_logic;
            Dout  : out std_logic_vector(7 downto 0);
            WrD   : out std_logic;
            done  : out std_logic
        );
    end component;

    signal SDX    : std_logic := '0';
    signal SCLK   : std_logic := '0';
    signal clk    : std_logic := '0';
    signal notSS  : std_logic := '1';
    signal Dout   : std_logic_vector(7 downto 0);
    signal WrD    : std_logic;
    signal RESET  : std_logic := '0';

    signal D_sig     : std_logic_vector(7 downto 0);
    signal DXval_sig : std_logic;
    signal done_sig  : std_logic;

    constant CLK_PERIOD  : time := 10 ns;
    constant SCLK_PERIOD : time := 20 ns;

begin

    UUT: SRC
        port map (
            SDX    => SDX,
            SCLK   => SCLK,
            clk    => clk,
            notSS  => notSS,
            Dout   => Dout,
            WrD    => WrD,
            RESET  => RESET
        );

    SerialReceiverR_inst: SerialReceiverR
        port map (
            SDX    => SDX,
            SCLK   => SCLK,
            notSS  => notSS,
            accept => done_sig,
            D      => D_sig,
            DXval  => DXval_sig,
            RESET  => RESET
        );

    RouletteDispatcher_inst: RouletteDispatcher
        port map (
            Din   => D_sig,
            Dval  => DXval_sig,
            clk   => clk,
            RESET => RESET,
            Dout  => Dout,
            WrD   => WrD,
            done  => done_sig
        );

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

    stim_proc : process
    begin
        RESET <= '1';
        wait for 2 * CLK_PERIOD;
        RESET <= '0';
        wait for 2 * CLK_PERIOD;

		   -- dado válido
        notSS <= '0'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
		  SDX <= '1'; wait for SCLK_PERIOD;
        notSS <= '1';

        wait for 10 * SCLK_PERIOD;
			 -- dado inválido
        notSS <= '0'; wait for SCLK_PERIOD;
        SDX <= '1'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
        SDX <= '0'; wait for SCLK_PERIOD;
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

