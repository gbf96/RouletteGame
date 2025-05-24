library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SerialReceiver_tb is
end entity;

architecture testbench of SerialReceiver_tb is

    component SerialReceiver
        port(
            SDX      : in std_logic;
            SCLK     : in std_logic;
            notSS    : in std_logic;
            accept   : in std_logic;
            RESET    : in std_logic;
            D        : out std_logic_vector(4 downto 0);
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

    component ShiftRegister
        port(
            CLK         : in std_logic;
            Data        : in std_logic;
            enableshift : in std_logic;
            D           : out std_logic_vector(4 downto 0)
        );
    end component;

    component Counter3
        port(
            PL     : in std_logic;
            CE     : in std_logic;
            CLK    : in std_logic;
            Din    : in std_logic_vector(2 downto 0);
            RESET  : in std_logic;
            Q      : out std_logic_vector(2 downto 0)
        );
    end component;

    component Is5
        port(
            input  : in std_logic_vector(2 downto 0); 
            S      : out std_logic
        );
    end component;

    component Is6
        port(
            input  : in std_logic_vector(2 downto 0); 
            S      : out std_logic
        );
    end component;

    signal SDX      : std_logic ;  
    signal SCLK     : std_logic; 
    signal notSS    : std_logic ;   
    signal accept   : std_logic ;  
    signal RESET    : std_logic ; 
    signal D        : std_logic_vector(4 downto 0);  
    signal DXval    : std_logic;          -

    signal wrout    : std_logic;
    signal initout  : std_logic;
    signal Errout   : std_logic;
    signal Qout     : std_logic_vector(2 downto 0);
    signal bx       : std_logic_vector(2 downto 0) := "000"; 
    signal is5sig   : std_logic;
    signal is6sig   : std_logic;

    constant CLK_PERIOD : time := 10 ns;  

begin

 
    SerialReceiver_inst: SerialReceiver
    port map (
        SDX      => SDX,
        SCLK     => SCLK,
        notSS    => notSS,  
        accept   => accept,
        RESET    => RESET,
        D        => D,
        DXval    => DXval
    );
	 
    SerialControl_inst: SerialControl
    port map (
        enRX     => notSS,  
        dFlag    => is5sig,
        pFlag    => is6sig,
        RXerror  => Errout,
        clk      => SCLK,
        accept   => accept,
        RESET    => RESET,
        wr       => wrout,
        init     => initout,
        DXval    => DXval
    );

    ParityCheck_inst: ParityCheck
    port map (
        CLK      => SCLK,
        Data     => SDX,
        init     => initout,
        Err      => Errout
    );

    ShiftRegister_inst: ShiftRegister
    port map (
        CLK         => SCLK,
        Data        => SDX,
        enableshift => wrout,
        D           => D
    );

    Counter3_inst: Counter3
    port map (
        CLK    => SCLK,
        PL     => '0',
        CE     => '1',
        Din    => bx,
        RESET  => initout,
        Q      => Qout
    );

    Is5_inst: Is5
    port map (
        input => Qout,
        S     => is5sig
    );

    Is6_inst: Is6
    port map (
        input => Qout,
        S     => is6sig
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
	 
        RESET <= '1'; 
        wait for 20 ns;
        RESET <= '0'; 
		  accept <= '0'; 
		  notSS <= '1';
		  SDX <= '0';
        wait for 20 ns;
        
        -- dado inválido
        notSS <= '0'; 
		  wait for CLK_PERIOD;
        SDX <= '1';   
        wait for CLK_PERIOD;
        SDX <= '0';    
        wait for CLK_PERIOD;
        SDX <= '1';   
        wait for CLK_PERIOD;
        SDX <= '0';    
        wait for CLK_PERIOD;
		  SDX <= '0';    
        wait for CLK_PERIOD;
		  SDX <= '0';    
        wait for CLK_PERIOD;
        
     
        notSS <= '1';
        wait for 20 ns;  
		  accept <= '1'; 
        wait for 20 ns;
        
		  --dado válido
        notSS <= '0';  
		  wait for CLK_PERIOD;
        SDX <= '1';  
        wait for CLK_PERIOD;
        SDX <= '1';   
        wait for CLK_PERIOD;
        SDX <= '0';   
        wait for CLK_PERIOD;
        SDX <= '1';    
        wait for CLK_PERIOD;
		  SDX <= '1';    
        wait for CLK_PERIOD;
		  SDX <= '1';    
        wait for CLK_PERIOD;
                
        notSS <= '1';
        wait for 20 ns;
		  accept <= '1'; 
        wait for 20 ns;

        wait;
    end process;

end testbench;
