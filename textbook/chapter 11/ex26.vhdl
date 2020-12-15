library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex26 is
    port (
        clk, div_en: in std_logic;
        sclk: out std_logic
    );
end ex26;

architecture behave of ex26 is
    type my_count is range 0 to 100;
    constant max: my_count:= 31;
    signal temp: std_logic;

begin
    my_div: process(clk, div_en)
    variable div_count: my_count:= 0;
    begin
        if (div_en = '0') then
            div_count:= 0;
            temp <= '0';
        elsif (rising_edge(clk)) then
            if (div_count = max) then
                temp <= not temp;
                div_count:= 0;
            else
                div_count:= div_count + 1;
            end if;
        end if;
    end process my_div;
    sclk <= temp;
end behave;