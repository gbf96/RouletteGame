
library ieee;
use ieee.std_logic_1164.all;

entity RouletteGame is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	Dval: out std_logic
	);
end entity;

architecture structural of RouletteGame is 

component KeyboardReader
		port(
		LIN: in std_logic_vector(3 downto 0);
		COL: out std_logic_vector(3 downto 0);
		CLK: in std_logic;
		Q: out std_logic_vector(3 downto 0);
		Dval: out std_logic
		);
end component;
    
begin

KeyboardReader_inst: KeyboardReader port map(
	LIN => LIN,
	COL => COL,
	Q => Q,
	CLK => CLK,
	Dval => Dval
);

end structural;