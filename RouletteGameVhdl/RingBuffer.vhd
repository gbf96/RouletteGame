library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RingBuffer is 
    port(
        D     : in std_logic_vector(3 downto 0);
        CTS   : in std_logic;
        DAV   : in std_logic;
        RESET : in std_logic;
        CLK   : in std_logic;
        Q     : out std_logic_vector(3 downto 0);
        Wreg     : out std_logic;
        DAC      : out std_logic
    );
end entity;

architecture structural of RingBuffer is 

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

    signal address_i  : std_logic_vector(3 downto 0);
    signal incPut_i   : std_logic;
    signal incGet_i   : std_logic;
    signal putget_i   : std_logic;
    signal Wr_i       : std_logic;
    signal Wreg_i     : std_logic;
    signal DAC_i      : std_logic;
    signal Full_i     : std_logic;
    signal Empty_i    : std_logic;
    signal dout_ram   : std_logic_vector(3 downto 0);

begin

    RBC_inst: RingBufferControl
        port map(
            DAV     => DAV,
            CTS     => CTS,
            Full    => Full_i,
            Empty   => Empty_i,
            clk     => CLK,
            RESET   => RESET,
            DAC     => DAC_i,
            incPut  => incPut_i,
            incGet  => incGet_i,
            putget  => putget_i,
            Wr      => Wr_i,
            Wreg    => Wreg_i
        );

    MAC_inst: MemoryAddressControl
        port map(
            CLK       => CLK,
            RESET     => RESET,
            PUTnotGET => putget_i,
            incPut    => incPut_i,
            incGet    => incGet_i,
            address   => address_i,
            Full      => Full_i,
            Empty     => Empty_i
        );

    RAM_inst: RAM
        port map(
            address => address_i,
            wr      => Wr_i,
            din     => D,
            dout    => dout_ram
        );

    Q         <= dout_ram;
    DAC       <= DAC_i;
	 Wreg      <= Wreg_i;


end structural;
