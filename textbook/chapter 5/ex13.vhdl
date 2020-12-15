library ieee;
use ieee.std_logic_1164.all;

entity ex13 is
    port (
        Data_in: in std_logic_vector (7 downto 0);
        SEL: in std_logic_vector (2 downto 0);
        CE: in std_logic;
        F_CTRL: out std_logic
    );
end ex13;

architecture behave of ex13 is
begin
    proc: process (Data_in, SEL, CE) is
    begin
        if (CE = '1') then
            case (SEL) is
                when "111" => F_CTRL <= Data_in(7);
                when "110" => F_CTRL <= Data_in(6);
                when "101" => F_CTRL <= Data_in(5);
                when "100" => F_CTRL <= Data_in(4);
                when "011" => F_CTRL <= Data_in(3);
                when "010" => F_CTRL <= Data_in(2);
                when "001" => F_CTRL <= Data_in(1);
                when "000" => F_CTRL <= Data_in(0);
                when others => F_CTRL <= '0';
            end case;
        else
            F_CTRL <= '0';
        end if;
    end process proc;
end behave;