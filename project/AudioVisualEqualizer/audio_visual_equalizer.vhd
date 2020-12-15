library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity audio_visual_equalizer is
    Port ( clk_in : in STD_LOGIC;
    -- microphone signals
           micData : in STD_LOGIC;
           micClk: out STD_LOGIC;  -- microphone clk (3.072MHz)
           micLRSel: out STD_LOGIC;  -- microphone sel (0 for micClk rising edge)
    -- VGA signals
           vga_red : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_green : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_blue : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_hsync : out  STD_LOGIC;
           vga_vsync : out  STD_LOGIC
           );
end audio_visual_equalizer;

architecture Behavioral of audio_visual_equalizer is
    SIGNAL pxl_clk : STD_LOGIC;
    -- internal signals to connect modules
    SIGNAL S_red, S_green, S_blue : STD_LOGIC;
    SIGNAL S_vsync : STD_LOGIC;
    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR (10 DOWNTO 0);
    SIGNAL data_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL done : STD_LOGIC;
     
    
   COMPONENT display IS
        PORT (
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            motion    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;
    
    component deserializer is
        PORT ( 
            clk : IN STD_LOGIC;     --clock
            clk_mic : out STD_LOGIC;
            pdm_data : IN STD_LOGIC; -- Input PDM data from the microphone
            data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); --16 bit value of the sound
            done : OUT STD_LOGIC; --signals that the 16 bit bundle is full
            lrsel : OUT STD_LOGIC
        );
    end component;

    component clk_wiz_0 is
    port (
      clk_in1  : in std_logic;
      clk_out1 : out std_logic
    );
    end component;


	COMPONENT vga_sync
	PORT(
		pixel_clk : IN STD_LOGIC;
		red_in    : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		green_in  : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		blue_in   : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		red_out   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		green_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		blue_out  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		hsync     : OUT STD_LOGIC;
		vsync     : OUT STD_LOGIC;
		pixel_row : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);
		pixel_col : OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
		);
	END COMPONENT;

	

begin
    add_ball : display
    PORT MAP(
        --instantiate ball component
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        motion    => data_out,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
    );

    
    
    mic: deserializer
    port map(
    clk         => clk_in,
    clk_mic     => micClk,
    pdm_data    => micData, -- Input PDM data from the microphone
    data        => data_out, --16 bit value of the sound
    done        => done, --signals that the 16 bit bundle is full
    lrsel       => micLRSel 
    );
    
    vga_driver : vga_sync
    PORT MAP(--instantiate vga_sync component
        pixel_clk => pxl_clk, 
        red_in => S_red & "000", 
        green_in => S_green & "000", 
        blue_in => S_blue & "000", 
        red_out => VGA_red, 
        green_out => VGA_green, 
        blue_out => VGA_blue, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col, 
        hsync => VGA_hsync, 
        vsync => S_vsync
    );

	
	vga_vsync <= S_vsync; --connect output vsync
        
    clk_wiz_0_inst : clk_wiz_0 port map (
      clk_in1 => clk_in,
      clk_out1 => pxl_clk
    );

end Behavioral;
