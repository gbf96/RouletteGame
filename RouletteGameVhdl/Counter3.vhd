LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Counter3 IS
PORT(   
    PL : in std_logic;
    CE : in std_logic;
    CLK : in std_logic;
    Din : in std_logic_vector(2 downto 0);
	 RESET : in STD_LOGIC;
    Q   : out std_logic_vector(2 downto 0)
);
END Counter3;

ARCHITECTURE structural OF Counter3 IS

    COMPONENT AddSub3
    PORT(
        A    : in std_logic_vector(2 downto 0);  
        B    : in std_logic_vector(2 downto 0);  
        CBi  : in std_logic;
        OPau : in std_logic;
        CBo  : out std_logic;
        S    : out std_logic_vector(2 downto 0)
    );
    END COMPONENT;

    COMPONENT Registo3
    PORT(
        CLK : in std_logic;  
        D   : in std_logic_vector(2 downto 0); 
		  RESET : in STD_LOGIC; 
        Q   : out std_logic_vector(2 downto 0)
    );
    END COMPONENT;

    SIGNAL AddSubOut : std_logic_vector(2 downto 0);
    SIGNAL outputPL  : std_logic_vector(2 downto 0);
	 signal outputReg : std_logic_vector(2 downto 0);
	 signal bx: std_logic_vector(2 downto 0);

BEGIN

	bx <= "000";

    AddSub1 : AddSub3 PORT MAP(
        A    => outputReg,
        B    => bx,
        CBi  => CE,
        OPau => '0',
        S    => AddSubOut
    );

	outputPL(2) <= (PL and Din(2)) or (not PL and AddSubOut(2));
	outputPL(1) <= (PL and Din(1)) or (not PL and AddSubOut(1));
	outputPL(0) <= (PL and Din(0)) or (not PL and AddSubOut(0));

    Registo1 : Registo3 PORT MAP(
        CLK => CLK,  
        D   => outputPL,
		  RESET => RESET,
        Q   => outputReg
    );
	 
	 Q <= outputReg;

END structural;
