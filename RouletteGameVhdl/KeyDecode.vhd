library ieee;
use ieee.std_logic_1164.all;

entity KeyDecode is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK: in std_logic;
	Kack: in std_logic;
	RESET   : in std_logic;
	Q: out std_logic_vector(3 downto 0);
	Kval: out std_logic
	);
end entity;

architecture structural of KeyDecode is 

component KeyScan
		port(
		LIN: in std_logic_vector(3 downto 0);
		COL: out std_logic_vector(3 downto 0);
		CLK,Kscan: in std_logic;
		RESET   : in std_logic;
		Q: out std_logic_vector(3 downto 0);
		Kpress: out std_logic
		);
end component;

component KeyControl
		port(
		Kpress: in std_logic;
		CLK: in std_logic;
		Kack: in std_logic;
		Kscan: out std_logic;
		RESET   : in std_logic;
		Kval: out std_logic
		);
end component;

signal Kpress_sig: std_logic;
signal Kscan_sig: std_logic;
signal not_CLK: std_logic;
    
begin

not_CLK <= NOT CLK;

KeyScan_inst: KeyScan port map(
	LIN => LIN,
	COL => COL,
	Q => Q,
	CLK => not_CLK,
	Kscan => Kscan_sig,
	RESET => RESET,
	Kpress => Kpress_sig
);

KeyControl_inst: KeyControl port map(
	Kpress => Kpress_sig,
	CLK => CLK,
   Kack   => Kack,
	Kscan => Kscan_sig,
	RESET => RESET,
	Kval => Kval
);

end structural;