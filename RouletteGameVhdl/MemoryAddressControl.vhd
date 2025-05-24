library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MemoryAddressControl is
    port (
        CLK       : in std_logic;
        RESET     : in std_logic;
        PUTnotGET : in std_logic;
        incPut    : in std_logic;
        incGet    : in std_logic;
        address   : out std_logic_vector(3 downto 0);
        Full      : out std_logic;
        Empty     : out std_logic
    );
end entity;

architecture Structural of MemoryAddressControl is

    component Counter
        port (
            PL    : in  std_logic;
            CE    : in  std_logic;
            CLK   : in  std_logic;
            Din   : in  std_logic_vector(3 downto 0);
            RESET : in  std_logic;
            Q     : out std_logic_vector(3 downto 0)
        );
    end component;

    component Equals
        port (
            A     : in  std_logic_vector(3 downto 0);
            B     : in  std_logic_vector(3 downto 0);
            Equal : out std_logic
        );
    end component;

    component MUX2
        port (
            A : in  std_logic_vector(3 downto 0); 	
            B : in  std_logic_vector(3 downto 0);
            S : in  std_logic;  
            Y : out std_logic_vector(3 downto 0)
        );
    end component;

    component FFD
        port (
            CLK   : in std_logic;
            RESET : in std_logic;
            SET   : in std_logic;
            D     : in std_logic;
            EN    : in std_logic;
            Q     : out std_logic
        );
    end component;

    signal putIndex, getIndex : std_logic_vector(3 downto 0);
    signal putCycle, getCycle : std_logic;
    signal putCycleD, getCycleD : std_logic;
    signal equalIndex : std_logic;
    signal bx : std_logic_vector(3 downto 0);

begin

    bx <= (others => '0');

    PUT_COUNTER: Counter
        port map (
            PL    => '0',
            CE    => incPut,
            CLK   => CLK,
            Din   => bx,
            RESET => RESET,
            Q     => putIndex
        );

    GET_COUNTER: Counter
        port map (
            PL    => '0',
            CE    => incGet,
            CLK   => CLK,
            Din   => bx,
            RESET => RESET,
            Q     => getIndex
        );

    MUX_ADDR: MUX2
        port map (
            A => putIndex,
            B => getIndex,
            S => PUTnotGET,
            Y => address
        );

    EQ_EMPTY: Equals
        port map (
            A     => putIndex,
            B     => getIndex,
            Equal => equalIndex
        );

    putCycleD <= not putCycle when (incPut = '1' and putIndex = "1111") else putCycle;

    PUTCYCLE_FFD: FFD
        port map (
            CLK   => CLK,
            RESET => RESET,
            SET   => '0',
            D     => putCycleD,
            EN    => '1',
            Q     => putCycle
        );

    getCycleD <= not getCycle when (incGet = '1' and getIndex = "1111") else getCycle;

    GETCYCLE_FFD: FFD
        port map (
            CLK   => CLK,
            RESET => RESET,
            SET   => '0',
            D     => getCycleD,
            EN    => '1',
            Q     => getCycle
        );

    Full  <= '1' when (equalIndex = '1' and putCycle /= getCycle) else '0';
    Empty <= '1' when (equalIndex = '1' and putCycle  = getCycle) else '0';

end Structural;
