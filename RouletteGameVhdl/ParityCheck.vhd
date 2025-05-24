LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ParityCheck IS
PORT(	
	CLK : in std_logic;
	Data : in std_logic;
	init : in STD_LOGIC;
	Err : out std_logic
);
END ParityCheck;

ARCHITECTURE structural OF ParityCheck IS

component FFD
 PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
 end component;
 
 signal Q1, Q0: std_logic;


BEGIN

Q0 <= Data xor Q1;



 FFD0: FFD port map(
 CLK => CLK,
 D => Q0,
 SET => '0',
 RESET => init,
 EN => '1',
 Q => Q1
 );
 
 
err <= Q1;
 

END structural;