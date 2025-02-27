library ieee;
use ieee.std_logic_1164.all;

entity KeyDecode is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK, Kscan: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	Kpress: out std_logic
	);
end entity;

architecture structural of KeyDecode is 

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
      Y: out std_logic_vector(3 downto 0);
		);
end component;


MUX4_inst: MUX4 port map(
A => LIN,
S => ???,
Y => Kpress,
);

DEC4_inst: DEC4 port map(
S => ???,
Y => COL,
);

end structural;