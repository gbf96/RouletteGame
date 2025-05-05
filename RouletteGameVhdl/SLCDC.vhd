
library ieee;
use ieee.std_logic_1164.all;

entity SLCDC is 
	port(
	SDX: in std_logic;
	SCLK: in std_logic;
	clk: in std_logic;
	notSS: in std_logic;
	Dout: out std_logic_vector(4 downto 0);
	Wrl: out std_logic;
	RESET   : in std_logic
	);
end entity;

architecture structural of SLCDC is 

component SerialReceiver
		port(
			SDX: in std_logic;
			SCLK: in std_logic;
			notSS: in std_logic;
			accept: in std_logic;
			D: out std_logic_vector(4 downto 0);
			DXval: out std_logic;
			RESET   : in std_logic
		);
end component;

component LCDDispatcher 
	PORT
	(
		Din   : in std_logic_vector(4 downto 0);
		Dval  : in std_logic;
		clk   : in std_logic;
		RESET : in std_logic;
		Dout  : out std_logic_vector(4 downto 0);
		Wrl   : out std_logic;
		done  : out std_logic
	);
END component;

signal Dsig: std_logic_vector(4 downto 0);
signal DXvalsig: std_logic;
signal doneSIG: std_logic;
    
begin

SerialReceiver_inst: SerialReceiver port map(
	SDX => SDX,
	SCLK => SCLK,
	notSS => notSS,
	accept => doneSIG,
	D => Dsig,
	DXval => DXvalsig,
	RESET => RESET
);

LCDDispatcher_inst: LCDDispatcher port map(
	Din => Dsig,
   Dval => DXvalsig,
	clk => clk,
	RESET => RESET,
	Dout => Dout,
	Wrl => Wrl, 
	done => doneSIG 
);

end structural;