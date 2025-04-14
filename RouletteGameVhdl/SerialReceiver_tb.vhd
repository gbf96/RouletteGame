library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SerialReceiver_tb is
end entity;

architecture testbench of SerialReceiver_tb is

    -- Declaração dos componentes sem o uso de "work"
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

    -- Sinais de entrada e saída para o SerialReceiver
    signal SDX      : std_logic ;  -- Dados serializados (entrada de dados)
    signal SCLK     : std_logic; -- Clock
    signal notSS    : std_logic ;   -- Sinal de seleção do escravo (ativo baixo)
    signal accept   : std_logic ;  -- Sinal para aceitar dados
    signal RESET    : std_logic ;  -- Reset
    signal D        : std_logic_vector(4 downto 0);  -- Dados recebidos
    signal DXval    : std_logic;          -- Indica se os dados estão prontos

    -- Sinais internos
    signal wrout    : std_logic;
    signal initout  : std_logic;
    signal Errout   : std_logic;
    signal Qout     : std_logic_vector(2 downto 0);
    signal bx       : std_logic_vector(2 downto 0) := "000";  -- Contador para controle
    signal is5sig   : std_logic;
    signal is6sig   : std_logic;

    constant CLK_PERIOD : time := 10 ns;  -- Periodo do clock

begin

    -- Instancia o componente SerialReceiver
    SerialReceiver_inst: SerialReceiver
    port map (
        SDX      => SDX,
        SCLK     => SCLK,
        notSS    => notSS,   -- Controle da recepção dos dados (notSS = '0' permite)
        accept   => accept,
        RESET    => RESET,
        D        => D,
        DXval    => DXval
    );

    -- Instancia o SerialControl
    SerialControl_inst: SerialControl
    port map (
        enRX     => notSS,  -- Habilita o recebimento de dados quando notSS = 0
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

    -- Instancia o ParityCheck
    ParityCheck_inst: ParityCheck
    port map (
        CLK      => SCLK,
        Data     => SDX,
        init     => initout,
        Err      => Errout
    );

    -- Instancia o ShiftRegister
    ShiftRegister_inst: ShiftRegister
    port map (
        CLK         => SCLK,
        Data        => SDX,
        enableshift => wrout,
        D           => D
    );

    -- Instancia o Counter3
    Counter3_inst: Counter3
    port map (
        CLK    => SCLK,
        PL     => '0',
        CE     => '1',
        Din    => bx,
        RESET  => initout,
        Q      => Qout
    );

    -- Instancia o Is5
    Is5_inst: Is5
    port map (
        input => Qout,
        S     => is5sig
    );

    -- Instancia o Is6
    Is6_inst: Is6
    port map (
        input => Qout,
        S     => is6sig
    );

    -- Geração do sinal de clock (50 MHz, por exemplo)
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

    -- Processo de estímulo para o testbench
    stimulus: process
    begin
        -- Reset do sistema
        RESET <= '1'; 
        wait for 20 ns;
        RESET <= '0'; 
		  accept <= '0'; 
		  notSS <= '1';
		  SDX <= '0';
        wait for 20 ns;
        
        -- Teste 1: Pressionar primeira tecla (notSS = '0', dados sendo recebidos)
        notSS <= '0';  -- Início da recepção de dados
		  wait for CLK_PERIOD;
        SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
        SDX <= '0';    -- Envia dado 0
        wait for CLK_PERIOD;
        SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
        SDX <= '0';    -- Envia dado 0
        wait for CLK_PERIOD;
		  SDX <= '0';    -- Envia dado 0
        wait for CLK_PERIOD;
		  SDX <= '0';    -- Envia dado 1
        wait for CLK_PERIOD;
        
        -- Finaliza a recepção (notSS = '1', não há mais dados a serem recebidos)
        notSS <= '1';
        wait for 20 ns;  -- Aguarda um tempo para a transição
		  accept <= '1'; 
        wait for 20 ns;
        
        -- Teste 2: Enviar novos dados (para simular a continuidade)
        notSS <= '0';  -- Inicia a recepção novamente
		  wait for CLK_PERIOD;
        SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
        SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
        SDX <= '0';    -- Envia dado 0
        wait for CLK_PERIOD;
        SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
		  SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
		  SDX <= '1';    -- Envia dado 1
        wait for CLK_PERIOD;
        
        
        -- Finaliza a recepção (notSS = '1', não há mais dados a serem recebidos)
        notSS <= '1';
        wait for 20 ns;
		  accept <= '1'; 
        wait for 20 ns;

        -- Finaliza o testbench
        wait;
    end process;

end testbench;
