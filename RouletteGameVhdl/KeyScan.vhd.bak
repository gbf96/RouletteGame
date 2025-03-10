library ieee;
use ieee.std_logic_1164.all;

entity KeyScan is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK, Kscan: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	Kpress: out std_logic
	);
end entity;

architecture structural of KeyScan is 

component MUX4
		port(
		A: in std_logic_vector(3 downto 0);  
      S: in std_logic_vector(1 downto 0);  
      Y: out std_logic
		);
end component;

component DEC4
		port(
		S: in std_logic_vector(1 downto 0);  
      Y: out std_logic_vector(3 downto 0)
		);
end component;

component Counter
		port(
		PL : in std_logic;
		CE : in std_logic;
		CLK : in std_logic;
		Din : in std_logic_vector(3 downto 0);
		RESET : in STD_LOGIC;
		Q   : out std_logic_vector(3 downto 0)
		);
end component;

	signal CounterOut: std_logic_vector(3 downto 0);

begin

MUX4_inst: MUX4 port map(
A => LIN,
S => CounterOut(1 downto 0),
Y => Kpress
);

DEC4_inst: DEC4 port map(
S => CounterOut(3 downto 2),
Y => COL
);

Counter_inst: Counter port map(
PL => '0',
CE => Kscan,
CLK => CLK,
Din => "0000",
RESET => ???,
Q => CounterOut
); 

end structural;