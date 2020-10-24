library ieee;
use ieee.std_logic_1164.all;

entity ex15 is
    port (
        D, CLK, S: in std_logic;
        Q: out std_logic
    );
end ex15;

architecture behave of ex15 is
begin
    dff: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (S = '0') then
                Q <= '1';
            else
                Q <= D;
            end if;
        end if;
    end process dff;
end behave;