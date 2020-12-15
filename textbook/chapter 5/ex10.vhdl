library ieee;
use ieee.std_logic_1164.all;

entity ex10 is
    port (
        Data_in: in std_logic_vector (7 downto 0);
        SEL: in std_logic_vector (2 downto 0);
        F_CTRL: out std_logic
    );
end ex10;

architecture behave of ex10 is
begin
    proc: process (Data_in, SEL) is
    begin
        if (SEL = "111") then F_CTRL <= Data_in(7);
        elsif (SEL = "110") then F_CTRL <= Data_in(6);
        elsif (SEL = "101") then F_CTRL <= Data_in(5);
        elsif (SEL = "100") then F_CTRL <= Data_in(4);
        elsif (SEL = "011") then F_CTRL <= Data_in(3);
        elsif (SEL = "010") then F_CTRL <= Data_in(2);
        elsif (SEL = "001") then F_CTRL <= Data_in(1);
        elsif (SEL = "000") then F_CTRL <= Data_in(0);
        else F_CTRL <= '0';
        end if;
    end process proc;
end behave;