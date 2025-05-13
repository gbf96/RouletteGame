
library ieee;
use ieee.std_logic_1164.all;

entity RouletteGame is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK: in std_logic;
	LCD_CMD: out std_logic_vector(4 downto 0);
	LCD_EN: out std_logic;
	RESET   : in std_logic;
	HEX0	: out std_logic_vector(7 downto 0);
	HEX1	: out std_logic_vector(7 downto 0);
	HEX2	: out std_logic_vector(7 downto 0);
	HEX3	: out std_logic_vector(7 downto 0);
	HEX4	: out std_logic_vector(7 downto 0);
	HEX5	: out std_logic_vector(7 downto 0)
	);
end entity;

architecture structural of RouletteGame is 

component KeyboardReader
		port(
		LIN: in std_logic_vector(3 downto 0);
		COL: out std_logic_vector(3 downto 0);
		CLK: in std_logic;
		ACK: in std_logic;
		RESET   : in std_logic;
		Q: out std_logic_vector(3 downto 0);
		Dval: out std_logic
		);
end component;

component SLCDC
		port(
		SDX: in std_logic;
		SCLK: in std_logic;
		clk: in std_logic;
		notSS: in std_logic;
		Dout: out std_logic_vector(4 downto 0);
		Wrl: out std_logic;
		RESET   : in std_logic
		);
end component;

component SRC
		port(
		SDX: in std_logic;
		SCLK: in std_logic;
		clk: in std_logic;
		notSS: in std_logic;
		Dout: out std_logic_vector(7 downto 0);
		WrD: out std_logic;
		RESET   : in std_logic
		);
end component;

component rouletteDisplay
port(	set	: in std_logic;
		cmd	: in std_logic_vector(2 downto 0);
		data	: in std_logic_vector(4 downto 0);
		HEX0	: out std_logic_vector(7 downto 0);
		HEX1	: out std_logic_vector(7 downto 0);
		HEX2	: out std_logic_vector(7 downto 0);
		HEX3	: out std_logic_vector(7 downto 0);
		HEX4	: out std_logic_vector(7 downto 0);
		HEX5	: out std_logic_vector(7 downto 0)
		);
end component;

component UsbPort 
	PORT
	(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END component;

component clkDIV
port ( clk_in: in std_logic;
		 clk_out: out std_logic);
end component;

component CLKDIV2
port ( clk_in: in std_logic;
		 clk_out: out std_logic);
end component;

signal Qout: std_logic_vector(3 downto 0);
signal Dvalout: std_logic;
signal ACKout: std_logic;
signal clkOUT: std_logic;
signal clkOUT2: std_logic;
signal SDX: std_logic;
signal SCLK: std_logic;
signal LCDsel: std_logic;
signal RDsel: std_logic;
signal setSIG: std_logic;
signal RD_dataSIG: std_logic_vector(4 downto 0);
signal RD_cmdSIG: std_logic_vector(2 downto 0);
    
begin


KeyboardReader_inst: KeyboardReader port map(
	LIN => LIN,
	COL => COL,
	Q => Qout,
	CLK => clkOUT,
	ACK => ACKout,
	RESET => RESET,
	Dval => Dvalout
);

SLCDC_inst: SLCDC port map(
	SDX => SDX,
	SCLK => SCLK,
	clk => clkOUT2,
	notSS => LCDsel,
	Dout => LCD_CMD,
	Wrl => LCD_EN,
	RESET => RESET
);

SRC_inst: SRC port map(
	SDX => SDX,
	SCLK => SCLK,
	clk => clkOUT2,
   notSS => RDsel,
	Dout(2 downto 0) => RD_cmdSIG,
	Dout(7 downto 3) => RD_dataSIG,
	WrD => setSIG,
	RESET => RESET
);

RouletteDisplay_inst: RouletteDisplay port map(
	set => setSIG,
	cmd => RD_cmdSIG,
	data => RD_dataSIG,
   HEX0 => HEX0,
	HEX1 => HEX1,
	HEX2 => HEX2,
	HEX3 => HEX3,
	HEX4 => HEX4,
	HEX5 => HEX5	
);

clkDIV_inst: clkDIV port map(
	clk_in => CLK,
	clk_out => clkOUT
);

clkDIV_inst2: CLKDIV2 port map(
	clk_in => CLK,
	clk_out => clkOUT2
);


UsbPort_inst: UsbPort port map(
	inputPort(3 downto 0) => Qout(3 downto 0),
	inputPort(4) => Dvalout,
	outputPort(0) => LCDsel,
	outputPort(1) => RDsel,
	outputPort(3) => SDX,
	outputPort(4) => SCLK,
	outputPort(7) => ACKout
	
);

end structural;