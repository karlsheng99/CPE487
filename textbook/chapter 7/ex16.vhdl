library ieee;
use ieee.std_logic_1164.all;

entity ex16 is
    port (
        D, CLK, R: in std_logic;
        Q: out std_logic
    );
end ex16;

architecture behave of ex16 is
begin
    dff: process(CLK, R)
    begin
        if (R = '1') then
            Q <= '0';
        elsif (falling_edge(CLK)) then
            Q <= D;
        end if;
    end process dff;
end behave;