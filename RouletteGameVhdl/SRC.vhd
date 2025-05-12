
library ieee;
use ieee.std_logic_1164.all;

entity SRC is 
	port(
	SDX: in std_logic;
	SCLK: in std_logic;
	clk: in std_logic;
	notSS: in std_logic;
	Dout: out std_logic_vector(7 downto 0);
	WrD: out std_logic;
	RESET   : in std_logic
	);
end entity;

architecture structural of SRC is 

component SerialReceiverR
		port(
			SDX: in std_logic;
			SCLK: in std_logic;
			notSS: in std_logic;
			accept: in std_logic;
			D: out std_logic_vector(7 downto 0);
			DXval: out std_logic;
			RESET   : in std_logic
		);
end component;

component RouletteDispatcher
	PORT
	(
		Din   : in std_logic_vector(7 downto 0);
		Dval  : in std_logic;
		clk   : in std_logic;
		RESET : in std_logic;
		Dout  : out std_logic_vector(7 downto 0);
		WrD   : out std_logic;
		done  : out std_logic
	);
END component;

signal Dsig: std_logic_vector(7 downto 0);
signal DXvalsig: std_logic;
signal doneSIG: std_logic;
    
begin

SerialReceiverR_inst: SerialReceiverR port map(
	SDX => SDX,
	SCLK => SCLK,
	notSS => notSS,
	accept => doneSIG,
	D => Dsig,
	DXval => DXvalsig,
	RESET => RESET
);

RouletteDispatcher_inst: RouletteDispatcher port map(
	Din => Dsig,
   Dval => DXvalsig,
	clk => clk,
	RESET => RESET,
	Dout => Dout,
	WrD => WrD, 
	done => doneSIG 
);

end structural;