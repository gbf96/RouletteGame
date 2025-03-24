
library ieee;
use ieee.std_logic_1164.all;

entity RouletteGame is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK: in std_logic;
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

component UsbPort 
	PORT
	(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END component;

signal Qout: std_logic_vector(3 downto 0);
signal Dvalout: std_logic;
signal ACKout: std_logic;
    
begin

KeyboardReader_inst: KeyboardReader port map(
	LIN => LIN,
	COL => COL,
	Q => Qout,
	CLK => CLK,
	ACK => ACKout,
	RESET => RESET,
	Dval => Dvalout
);

UsbPort_inst: UsbPort port map(
	inputPort(3 downto 0) => Qout,
	inputPort(4) => Dvalout,
	outputPort(4) => ACKout
);

end structural;