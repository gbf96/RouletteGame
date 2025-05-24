library ieee;
use ieee.std_logic_1164.all;

entity KeyboardReader is 
    port(
        LIN   : in  std_logic_vector(3 downto 0);
        COL   : out std_logic_vector(3 downto 0);
        CLK   : in  std_logic;
        ACK   : in  std_logic;
        RESET : in  std_logic;
        Q     : out std_logic_vector(3 downto 0);
        Dval  : out std_logic
    );
end entity;

architecture structural of KeyboardReader is

    component KeyDecode
        port(
            LIN    : in  std_logic_vector(3 downto 0);
            COL    : out std_logic_vector(3 downto 0);
            CLK    : in  std_logic;
            Kack   : in  std_logic;
            RESET  : in  std_logic;
            Q      : out std_logic_vector(3 downto 0);
            Kval   : out std_logic
        );
    end component;

    component RingBuffer
        port(
            D         : in  std_logic_vector(3 downto 0);
            CTS       : in  std_logic;
            DAV       : in  std_logic;
            RESET     : in  std_logic;
            CLK       : in  std_logic;
            Q         : out std_logic_vector(3 downto 0);
            Wreg      : out std_logic;
            DAC       : out std_logic
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

    signal key_data    : std_logic_vector(3 downto 0);
    signal key_valid   : std_logic;
    signal ring_out    : std_logic_vector(3 downto 0);
    signal Wreg_int    : std_logic;
    signal DAC_int     : std_logic;
    signal OBfree      : std_logic;
    signal incPut_s    : std_logic;
    signal incGet_s    : std_logic;
    signal PUTnotGET_s : std_logic;
    signal Wr_s        : std_logic;
    signal Full_s      : std_logic;
    signal Empty_s     : std_logic;
    signal adress_s    : std_logic_vector(3 downto 0);

begin

    KeyDecode_inst: KeyDecode
        port map(
            LIN   => LIN,
            COL   => COL,
            CLK   => CLK,
            Kack  => DAC_int, 
            RESET => RESET,
            Q     => key_data,
            Kval  => key_valid
        );

    RingBuffer_inst: RingBuffer
        port map(
            D         => key_data,
            CTS       => OBfree,      
            DAV       => key_valid, 
            RESET     => RESET,
            CLK       => CLK,
            Q         => ring_out,
            Wreg      => Wreg_int,
            DAC       => DAC_int
        );

    OutputBuffer_inst: OutputBuffer
        port map(
            D      => ring_out,
            LOAD   => Wreg_int,
            CLK    => CLK,
            RESET  => RESET,
            ACK    => ACK,
            Q      => Q,
            Dval   => Dval,
            OBfree => OBfree
        );

end architecture;
