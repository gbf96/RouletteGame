
library ieee;
use ieee.std_logic_1164.all;

entity RouletteGame is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK: in std_logic;
	LCD_CMD: out std_logic_vector(4 downto 0);
--	RData: out std_logic_vector(7 downto 0);
	LCD_EN: out std_logic;
--	set: out std_logic;
	RESET   : in std_logic
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

--component SRC
--		port(
--		SDX: in std_logic;
--		SCLK: in std_logic;
--		clk: in std_logic;
--		notSS: in std_logic;
--		Dout: out std_logic_vector(7 downto 0);
--		WrD: out std_logic;
--		RESET   : in std_logic
--		);
--end component;

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
--signal RDsel: std_logic;
    
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

--SRC_inst: SRC port map(
--	SDX => SDX,
--	SCLK => SCLK,
--	clk => clkOUT2,
-- notSS => RDsel,
--	Dout => RData,
--	WrD => set,
--	RESET => RESET
--);

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
--	outputPort(1) => RDsel,
	outputPort(3) => SDX,
	outputPort(4) => SCLK,
	outputPort(7) => ACKout
	
);

end structural;