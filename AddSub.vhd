library ieee;
use ieee.std_logic_1164.all;

entity AddSub is 
    port(
        A, B: in std_logic_vector(3 downto 0);  
        CBi: in std_logic;                      
        OPau: in std_logic;                     
        CBo: out std_logic;                     
        S: out std_logic_vector(3 downto 0)    
    );
end AddSub;

architecture structural of AddSub is 

    component Adder
        port(
            A, B: in std_logic_vector(3 downto 0);  
            C0: in std_logic;                       
            C4: out std_logic;                       
            S: out std_logic_vector(3 downto 0)      
        );
    end component;

    signal C4out: std_logic;                          
    signal B_modified: std_logic_vector(3 downto 0);       
	 signal C_modified: std_logic;
	 
begin

    
    B_modified <= (B(3) xor OPau, B(2) xor OPau, B(1) xor OPau, B(0) xor OPau);
	 C_modified <= Cbi xor Opau;

    Adder1: Adder
        port map(
            A => A,
            B => B_modified,                        
            C0 => C_modified,                             
            C4 => C4out,                     
            S => S                                
        );

   
    CBo <= C4out xor OPau; 

end structural;