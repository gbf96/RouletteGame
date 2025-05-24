library ieee;
use ieee.std_logic_1164.all;

entity OutputBuffer is
    port (
        D      : in  std_logic_vector(3 downto 0); 
        LOAD   : in  std_logic;                    
        ACK    : in  std_logic;                    
        CLK    : in  std_logic;                    
        RESET  : in  std_logic;
        Q      : out std_logic_vector(3 downto 0);
        OBfree: out std_logic;                     
        Dval  : out std_logic                      
    );
end entity;

architecture Structural of OutputBuffer is

    component OutputBufferControl
        port (
            LOAD   : in  std_logic;
            ACK    : in  std_logic;
            CLK    : in  std_logic;
            RESET  : in  std_logic;
            Wreg   : out std_logic;
            OBfree : out std_logic;
            Dval   : out std_logic
        );
    end component;

    component Registo
        port (
            CLK   : in std_logic;          
            D     : in std_logic_vector(3 downto 0);
            RESET : in std_logic;
            Q     : out std_logic_vector(3 downto 0)
        );
    end component;

    signal Wreg_sig : std_logic;

begin

    CONTROL_UNIT: OutputBufferControl
        port map (
            LOAD   => LOAD,
            ACK    => ACK,
            CLK    => CLK,
            RESET  => RESET,
            Wreg   => Wreg_sig,
            OBfree => OBfree,
            Dval   => Dval
        );

    REGISTRO_UNIT: Registo
        port map (
            CLK   => Wreg_sig,
            D     => D,
            RESET => RESET,
            Q     => Q
        );

end architecture;
