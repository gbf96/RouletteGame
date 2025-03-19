library ieee;
use ieee.std_logic_1164.all;

entity RouletteGame is 
    port(
        LIN   : in  std_logic_vector(3 downto 0);
        COL   : out std_logic_vector(3 downto 0);
        MCLK  : in  std_logic;
        RESET : in  std_logic
    );
end entity;

architecture structural of RouletteGame is 

    -- Componente do leitor de teclado
    component KeyboardReader
        port(
            LIN   : in  std_logic_vector(3 downto 0);
            COL   : out std_logic_vector(3 downto 0);
            CLK   : in  std_logic;
            ACK   : in  std_logic;
            RESET : in  std_logic;
            Q     : out std_logic_vector(3 downto 0);
            Dval  : out std_logic
        );
    end component;

    -- Componente da porta USB
    component UsbPort
        port(
            inputPort  : in  std_logic_vector(7 downto 0);
            outputPort : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Sinais internos
    signal Qout       : std_logic_vector(3 downto 0);
    signal Dvalout    : std_logic;
    signal ACKout     : std_logic := '0'; -- Inicializado para evitar warnings
    signal padBits    : std_logic_vector(2 downto 0) := "000"; -- Bits não usados no inputPort
    signal UsbOutput  : std_logic_vector(7 downto 0); -- Saída completa da USB

begin

    -- Instância do teclado
    KeyboardReader_inst: KeyboardReader 
    port map(
        LIN   => LIN,
        COL   => COL,
        Q     => Qout,
        CLK   => MCLK,
        ACK   => ACKout,
        RESET => RESET,
        Dval  => Dvalout
    );

    -- Instância da porta USB
    UsbPort_inst: UsbPort 
    port map(
        inputPort(3 downto 0) => Qout,
        inputPort(4)          => Dvalout,
        inputPort(7 downto 5) => padBits, -- Preenchendo os bits superiores
        outputPort            => UsbOutput -- Mapeando a saída inteira
    );

    -- Pegando apenas o bit necessário
    ACKout <= UsbOutput(4);

end structural;
