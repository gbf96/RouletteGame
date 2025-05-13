
library ieee;
use ieee.std_logic_1164.all;

entity SerialReceiverR is 
	port(
	SDX: in std_logic;
	SCLK: in std_logic;
	notSS: in std_logic;
	accept: in std_logic;
	D: out std_logic_vector(7 downto 0);
	DXval: out std_logic;
	RESET   : in std_logic
	);
end entity;

architecture structural of SerialReceiverR is 

component SerialControl
		port(
		enRX 		: in std_logic;
		dFlag		: in std_logic;
		pFlag				: in std_logic;
		clk		: in std_logic;
		RXerror		: in std_logic;
		accept		: in std_logic;
		RESET   : in std_logic;
		wr			: out std_logic;
		init			: out std_logic;
		DXval	: out std_logic
		);
end component;

component ParityCheck 
	PORT
	(
		 CLK : in std_logic;
		 Data : in std_logic;
		 init : in STD_LOGIC;
		 Err : out std_logic
	);
END component;

component ShiftRegisterR
	PORT
	(
		CLK : in std_logic;
		Data : in std_logic;
		enableshift : in STD_LOGIC;
		D : out std_logic_vector(7 downTo 0)
);
end component;

component Counter
PORT
	(
	 PL : in std_logic;
    CE : in std_logic;
    CLK : in std_logic;
    Din : in std_logic_vector(3 downto 0);
	 RESET : in STD_LOGIC;
    Q   : out std_logic_vector(3 downto 0)
	 );
end component;

component Is8
PORT
	(
	 input : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
    S : OUT STD_LOGIC    
	 );
end component;

component Is9
PORT
	(
	 input : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
    S : OUT STD_LOGIC    
	 );
end component;

signal wrout: std_logic;
signal initout: std_logic;
signal Errout: std_logic;
signal Qout: std_logic_vector(3 downto 0);
signal bx: std_logic_vector(3 downto 0);
signal is8sig: std_logic;
signal is9sig: std_logic;

    
begin

bx <= "0000";


SerialControl_inst: SerialControl port map(
	enRX => notSS,
	dFlag => is8sig,
	pFlag => is9sig,
	RXerror => Errout,
	clk => SCLK,
	accept => accept,
	RESET => RESET,
	wr => wrout,
	init => initout,
	DXval => DXval
);

ParityCheck_inst: ParityCheck port map(
	CLK => SCLK,
	Data => SDX,
	init => initout,
	Err => Errout
);



ShiftRegisterR_inst: ShiftRegisterR port map(
	CLK => SCLK,
	Data => SDX,
	enableshift => wrout,
	D => D
);

Counter_inst: Counter port map(
	CLK => SCLK,
	PL => '0',
	CE => '1',
	Din => bx,
	RESET => initout,
	Q => Qout
);

Is5_inst: Is8 port map(
	input => Qout,
	S => is8sig
);

Is6_inst: Is9 port map(
	input => Qout,
	S => is9sig
);



end structural;