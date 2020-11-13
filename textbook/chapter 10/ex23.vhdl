library ieee;
use ieee.std_logic_1164.all;

entity ex23 is
    port (
        REG_IN: in std_logic_vector(7 downto 0);
        LD, CLK: in std_logic;
        REG_OUT: out std_logic_vector(7 downto 0)
    );
end ex23;

architecture behave of ex23 is
begin
    reg: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LD = '1') then
                REG_OUT <= REG_IN;
            end if;
        end if;
    end process;
end behave;