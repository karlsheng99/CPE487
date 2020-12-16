----------------------------------------------------------------------------------
-- Created by: Erik Schneider and Jared Kantor
-- Module Name: deserializer - Behavioral
-- Description: This module converts the sound from the microphone into 16 bit bundles
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;



ENTITY deserializer IS
    PORT ( 
        clk : IN STD_LOGIC;     --clock
        clk_mic : out STD_LOGIC;
        pdm_data : IN STD_LOGIC; -- Input PDM data from the microphone
        data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); --16 bit value of the sound
        done : OUT STD_LOGIC; --signals that the 16 bit bundle is full
        lrsel : OUT STD_LOGIC
        
    );
END deserializer;

ARCHITECTURE Behavioral OF deserializer IS

    SIGNAL pdm_int : STD_LOGIC_VECTOR(15 DOWNTO 0); --shift register for incoming pdm bits
    SIGNAL cnt_bits : INTEGER RANGE 0 TO 20 := 0;
    SIGNAL done_int : STD_LOGIC;
    SIGNAL bit_number: INTEGER := 16;
    signal clk_cntr_reg : std_logic_vector (4 downto 0) := (others=>'0');

BEGIN

    lrsel <= '0'; --Read on riding edge
    
    process(clk)
    begin
      if (rising_edge(clk)) then
        clk_cntr_reg <= clk_cntr_reg + 1;
      end if;
    end process;
    
    clk_mic <= clk_cntr_reg(4);
    
    shift: PROCESS (clk) --add incoming pdm data to 16 bit bundle
    BEGIN
        IF RISING_EDGE(clk) THEN
            if (clk_cntr_reg = "01111") then
                pdm_int <= pdm_int(14 DOWNTO 0) & pdm_data; 
            end if;
        END IF;
    END PROCESS shift;

    cnt: PROCESS (clk)  --count how many bits are in the current bundle
    BEGIN
        IF RISING_EDGE(clk) THEN
            if (clk_cntr_reg = "01111") then
                IF cnt_bits = (bit_number-1) THEN
                    cnt_bits <= 0;
                ELSE
                    cnt_bits <= cnt_bits + 1;
                END IF;
            end if;
        END IF;
    END PROCESS cnt;
    
    fin: PROCESS (clk)  -- Generates done signal and passes 16 bit bundle out of component
    BEGIN
        IF RISING_EDGE(clk) THEN
            if (clk_cntr_reg = "01111") then
                IF cnt_bits = 0 THEN
                    done_int <= '1';
                    data <= pdm_int;
                ELSE
                    done_int <= '0';
                END IF;
            end if;
        END IF;
    END PROCESS fin;

END Behavioral;