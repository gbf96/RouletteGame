LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Registo3 IS
PORT(	
	CLK : in std_logic;
	D : in std_logic_vector(2 downto 0);
	RESET : in STD_LOGIC;
	Q : out std_logic_vector(2 downto 0)
);
END Registo3;

ARCHITECTURE structural OF Registo3 IS

component FFD
 PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
 end component;
 


BEGIN

 FFD0: FFD port map(
 CLK => CLK,
 D => D(0),
 SET => '0',
 RESET => RESET,
 EN => '1',
 Q => Q(0)
 );
 
 FFD1: FFD port map(
 CLK => CLK,
 D => D(1),
 SET => '0',
 RESET => RESET,
 EN => '1',
 Q => Q(1)
 );
 
 FFD2: FFD port map(
 CLK => CLK,
 D => D(2),
 SET => '0',
 RESET => RESET,
 EN => '1',
 Q => Q(2)
 );
 


END structural;