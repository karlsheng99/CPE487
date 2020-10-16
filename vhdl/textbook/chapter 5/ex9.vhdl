library ieee;
use ieee.std_logic_1164.all;

entity ex9 is
    port (
        A, B, C: in std_logic;
        F_OUT: out std_logic
    );
end ex9;

architecture behave of ex9 is 
begin
    proc: process (A, B, C) is
    begin
        if (A = '1' and b = '0' and C = '0') then
            F_OUT <= '1';
        elsif (B = '1' and C = '1') then
            F_OUT <= '1';
        else
            F_OUT <= '0';
        end if;
    end process proc;
    
end behave;