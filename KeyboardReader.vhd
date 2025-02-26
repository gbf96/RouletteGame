library ieee;
use ieee.std_logic_1164.all;

entity KeyboardReader is 
	port(
	LIN: in std_logic_vector(3 downto 0);
	COL: out std_logic_vector(3 downto 0);
	CLK: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	Dval: out std_logic
	);
end entity;

architecture structural of KeyboardReader is 

component KeyDecode
		port(
		LIN: in std_logic_vector(3 downto 0);
		COL: out std_logic_vector(3 downto 0);
		CLK,Kscan: in std_logic;
		Q: out std_logic_vector(3 downto 0);
		Kpress: out std_logic
		);
end component;
    
begin

KeyDecode_inst: KeyDecode port map(
	LIN => LIN,
	COL => COL,
	Q => Q,
	CLK => CLK,
	Kscan => ???,
	Kpress => Dval
);

end structural;