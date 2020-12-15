library ieee;
use ieee.std_logic_1164.all;

entity ex3 is
    port (
        L, M, N: in std_logic;
        F3: out std_logic
    );
end ex3;

architecture behave of ex3 is
begin
    F3 <= 
        '1' when (L = '0' and M = '0' and N = '1') else
        '1' when (L = '1' and M = '1') else
        '0';            
end behave;