library ieee;
use ieee.std_logic_1164.all;

entity ex17 is
    port (
        T, CLK, S: in std_logic;
        Q: out std_logic
    );
end ex17;

architecture behave of ex17 is
    signal temp: std_logic;
begin
    dff: process(CLK, S)
    begin
        if (S = '0') then
            temp <= '1';
        elsif (rising_edge(CLK)) then
            temp <= T xor temp;
        end if;
    end process dff;

    Q <= temp;
end behave;