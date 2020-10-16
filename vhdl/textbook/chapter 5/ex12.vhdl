library ieee;
use ieee.std_logic_1164.all;

entity ex12 is
    port (
        A, B, C: in std_logic;
        F_OUT: out std_logic
    );
end ex12;

architecture behave of ex12 is 
    signal ABC: std_logic_vector (2 downto 0);
begin
    ABC <= A & B & C;
    proc: process (ABC) is
    begin
        case (ABC) is
            --"-11" works for case 1 and 3
            when "111" => F_OUT <= '1';
            when "100" => F_OUT <= '1';
            when "011" => F_OUT <= '1';
            when others => F_OUT <= '0';
        end case;
    end process proc;
    
end behave;