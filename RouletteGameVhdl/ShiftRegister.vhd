LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ShiftRegister IS
PORT(	
	CLK : in std_logic;
	Data : in std_logic;
	enableshift : in STD_LOGIC;
	D : out std_logic_vector(4 downTo 0)
);
END ShiftRegister;

ARCHITECTURE structural OF ShiftRegister IS

component FFD
 PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
 end component;
 
 signal Q0,Q1, Q2, Q3, Q4 : std_logic;


BEGIN

 FFD0: FFD port map(
 CLK => CLK,
 D => Data,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q0
 );
 
 FFD1: FFD port map(
 CLK => CLK,
 D => Q0,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q1
 );
 
 FFD2: FFD port map(
 CLK => CLK,
 D => Q1,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q2
 );
 
 FFD3: FFD port map(
 CLK => CLK,
 D => Q2,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q3
 );
 
 FFD4: FFD port map(
 CLK => CLK,
 D => Q3,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q4
 ); 
 
 
D(0) <= Q4;
D(1) <= Q3;
D(2) <= Q2;
D(3) <= Q1;
D(4) <= Q0;
 

END structural;