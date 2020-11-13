---functions for ex25.vhdl

----mux2t1
library ieee;
use ieee.std_logic_1164.all;

entity mux2t1 is
    port (
            A,B: in std_logic_vector(7 downto 0);
            SEL: in std_logic;
            M_OUT: out std_logic_vector(7 downto 0)
        );
end mux2t1;

architecture behave of mux2t1 is
begin
    with SEL select M_OUT <=
        A when '1',
        B when '0',
        (others => '0') when others;
end behave;

---reg8
library ieee;
use ieee.std_logic_1164.all;

entity reg8 is
    port (
        REG_IN: in std_logic_vector(7 downto 0);
        LD, CLK: in std_logic;
        REG_OUT: out std_logic_vector(7 downto 0)
    );
end reg8;

architecture behave of reg8 is
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
