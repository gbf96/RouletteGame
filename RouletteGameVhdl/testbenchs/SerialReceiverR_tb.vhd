library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SerialReceiverR_tb is
end entity;

architecture testbench of SerialReceiverR_tb is

    component SerialReceiverR
        port(
            SDX      : in std_logic;
            SCLK     : in std_logic;
            notSS    : in std_logic;
            accept   : in std_logic;
            RESET    : in std_logic;
            D        : out std_logic_vector(7 downto 0);
            DXval    : out std_logic
        );
    end component;

    component SerialControl
        port(
            enRX     : in std_logic;
            dFlag    : in std_logic;
            pFlag    : in std_logic;
            clk      : in std_logic;
            RXerror  : in std_logic;
            accept   : in std_logic;
            RESET    : in std_logic;
            wr       : out std_logic;
            init     : out std_logic;
            DXval    : out std_logic
        );
    end component;

    component ParityCheck
        port(
            CLK      : in std_logic;
            Data     : in std_logic;
            init     : in std_logic;
            Err      : out std_logic
        );
    end component;

    component ShiftRegisterR
        port(
            CLK         : in std_logic;
            Data        : in std_logic;
            enableshift : in std_logic;
            D           : out std_logic_vector(7 downto 0)
        );
    end component;

    component Counter
        port(
            PL     : in std_logic;
            CE     : in std_logic;
            CLK    : in std_logic;
            Din    : in std_logic_vector(3 downto 0);
            RESET  : in std_logic;
            Q      : out std_logic_vector(3 downto 0)
        );
    end component;

    component Is8
        port(
            input  : in std_logic_vector(3 downto 0); 
            S      : out std_logic
        );
    end component;

    component Is9
        port(
            input  : in std_logic_vector(3 downto 0); 
            S      : out std_logic
        );
    end component;

    signal SDX, SCLK, notSS, accept, RESET : std_logic;
    signal D        : std_logic_vector(7 downto 0);
    signal DXval    : std_logic;
    signal wrout    : std_logic;
    signal initout  : std_logic;
    signal Errout   : std_logic;
    signal Qout     : std_logic_vector(3 downto 0);
    signal bx       : std_logic_vector(3 downto 0) := "0000"; 
    signal is8sig   : std_logic;
    signal is9sig   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    SerialReceiverR_inst: SerialReceiverR
        port map (
            SDX    => SDX,
            SCLK   => SCLK,
            notSS  => notSS,
            accept => accept,
            RESET  => RESET,
            D      => D,
            DXval  => DXval
        );

    SerialControl_inst: SerialControl
        port map (
            enRX    => notSS,
            dFlag   => is8sig,
            pFlag   => is9sig,
            RXerror => Errout,
            clk     => SCLK,
            accept  => accept,
            RESET   => RESET,
            wr      => wrout,
            init    => initout,
            DXval   => DXval
        );

    ParityCheck_inst: ParityCheck
        port map (
            CLK  => SCLK,
            Data => SDX,
            init => initout,
            Err  => Errout
        );

    ShiftRegisterR_inst: ShiftRegisterR
        port map (
            CLK         => SCLK,
            Data        => SDX,
            enableshift => wrout,
            D           => D
        );

    Counter_inst: Counter
        port map (
            CLK    => SCLK,
            PL     => '0',
            CE     => '1',
            Din    => bx,
            RESET  => initout,
            Q      => Qout
        );

    Is8_inst: Is8
        port map (
            input => Qout,
            S     => is8sig
        );

    Is9_inst: Is9
        port map (
            input => Qout,
            S     => is9sig
        );

    clk_gen: process
    begin
        while now < 2000 ns loop
            SCLK <= '0';
            wait for CLK_PERIOD / 2;
            SCLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stimulus: process
    begin
    -- dado válido
	 RESET <= '1'; 
    wait for 20 ns;
    RESET <= '0'; 
	 accept <= '0'; 
	 notSS <= '1';
	 SDX <= '0';
    wait for 20 ns;
    notSS <= '0';wait for CLK_PERIOD; 
	  
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '0'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '0'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '0'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '0'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;  

    notSS <= '1';
    wait for 20 ns;
    accept <= '1';
    wait for 20 ns;

    -- dado inválido
    accept <= '0';
    notSS <= '0'; wait for CLK_PERIOD; 
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '1'; wait for CLK_PERIOD;
    SDX <= '0'; wait for CLK_PERIOD;

    notSS <= '1';
    wait for 20 ns;
    accept <= '1';
    wait for 20 ns;


        wait;
    end process;

end architecture;
