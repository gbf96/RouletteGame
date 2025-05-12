LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ShiftRegisterR IS
PORT(	
	CLK : in std_logic;
	Data : in std_logic;
	enableshift : in STD_LOGIC;
	D : out std_logic_vector(7 downTo 0)
);
END ShiftRegisterR;

ARCHITECTURE structural OF ShiftRegisterR IS

component FFD
 PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
 end component;
 
 signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : std_logic;


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
 
 FFD5: FFD port map(
 CLK => CLK,
 D => Q4,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q5
 ); 
 
 FFD6: FFD port map(
 CLK => CLK,
 D => Q5,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q6
 ); 
 
 FFD7: FFD port map(
 CLK => CLK,
 D => Q6,
 SET => '0',
 RESET => '0',
 EN => enableshift,
 Q => Q7
 ); 
 
 
D(0) <= Q7;
D(1) <= Q6;
D(2) <= Q5;
D(3) <= Q4;
D(4) <= Q3;
D(5) <= Q2;
D(6) <= Q1;
D(7) <= Q0;
 

END structural;