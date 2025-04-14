library ieee;
use ieee.std_logic_1164.all;

entity AddSub3 is 
    port(
        A, B: in std_logic_vector(2 downto 0);  
        CBi: in std_logic;                      
        OPau: in std_logic;                     
        CBo: out std_logic;                     
        S: out std_logic_vector(2 downto 0)    
    );
end AddSub3;

architecture structural of AddSub3 is 

    component Adder3
        port(
            A, B: in std_logic_vector(2 downto 0);  
            C0: in std_logic;                       
            C3: out std_logic;                       
            S: out std_logic_vector(2 downto 0)      
        );
    end component;

    signal C3out: std_logic;                          
    signal B_modified: std_logic_vector(2 downto 0);       
	 signal C_modified: std_logic;
	 
begin

    
    B_modified <= (B(2) xor OPau, B(1) xor OPau, B(0) xor OPau);
	 C_modified <= Cbi xor Opau;

    Adder1: Adder3
        port map(
            A => A,
            B => B_modified,                        
            C0 => C_modified,                             
            C3 => C3out,                     
            S => S                                
        );

   
    CBo <= C3out xor OPau; 

end structural;