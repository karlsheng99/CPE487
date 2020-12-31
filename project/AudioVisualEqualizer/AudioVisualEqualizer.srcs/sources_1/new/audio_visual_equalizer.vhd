library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity audio_visual_equalizer is
    Port ( clk_in : in STD_LOGIC;
    -- microphone signals
           micData : in STD_LOGIC;
           micClk: out STD_LOGIC;  -- microphone clk
           micLRSel: out STD_LOGIC;  -- microphone sel (0 for micClk rising edge)
    -- VGA signals
           vga_red : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_green : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_blue : out  STD_LOGIC_VECTOR (3 downto 0);
           vga_hsync : out  STD_LOGIC;
           vga_vsync : out  STD_LOGIC;
     -- switches
           sw : in STD_LOGIC_VECTOR(2 downto 0)
           );
end audio_visual_equalizer;

architecture Behavioral of audio_visual_equalizer is
    SIGNAL pxl_clk : STD_LOGIC;
    -- internal signals to connect modules
    SIGNAL S_red, S_green, S_blue : STD_LOGIC;
    SIGNAL S_vsync : STD_LOGIC;
    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR (10 DOWNTO 0);
    signal clk_cntr_reg : std_logic_vector (4 downto 0) := (others=>'0'); 
    signal mic_vol : integer;
    signal en_des : std_logic := '1';
    signal done_async_des : std_logic;
    signal data_des : std_logic_vector(15 downto 0) := (others => '0');
    signal pdm_clk_rising : std_logic;
     
	
   COMPONENT display IS
        PORT (
            clk : IN STD_LOGIC;
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            mic_data    : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            sw : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;
    
    component PdmDes is
       generic(
          C_NR_OF_BITS : integer := 16;
          C_SYS_CLK_FREQ_MHZ : integer := 100;
          C_PDM_FREQ_HZ : integer := 2000000
       );
       port(
          clk_i : in std_logic;
          en_i : in std_logic; -- Enable deserializing (during record)
          
          done_o : out std_logic; -- Signaling that 16 bits are deserialized
          data_o : out std_logic_vector(C_NR_OF_BITS - 1 downto 0); -- output deserialized data
          
          -- PDM
          pdm_m_clk_o : out std_logic; -- Output M_CLK signal to the microphone
          pdm_m_data_i : in std_logic; -- Input PDM data from the microphone
          pdm_lrsel_o : out std_logic; -- Set to '0', therefore data is read on the positive edge
          pdm_clk_rising_o : out std_logic -- Signaling the rising edge of M_CLK, used by the MicDisplay
                                           -- component in the VGA controller
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
    
    Deserializer: PdmDes
       generic map(
          C_NR_OF_BITS         => 16,
          C_SYS_CLK_FREQ_MHZ   => 100,
          C_PDM_FREQ_HZ       => 2000000)
       port map(
          clk_i                => clk_in,
          en_i                 => en_des,
          done_o               => done_async_des,
          data_o               => data_des,
          pdm_m_clk_o          => micClk,
          pdm_m_data_i         => micData,
          pdm_lrsel_o          => micLRSel,
          pdm_clk_rising_o     => pdm_clk_rising
        );
      
    add_ball : display
    PORT MAP(
        --instantiate ball component
        clk       => clk_in,
        v_sync    => S_vsync, 
        pixel_row => S_pixel_row, 
        pixel_col => S_pixel_col,
        --motion    => mic_vol,
        mic_data  => data_des,
        sw        => sw,
        red       => S_red, 
        green     => S_green, 
        blue      => S_blue
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
