library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Square is
    Port (CLK: in STD_LOGIC;
          RST: in STD_LOGIC;
          HS: out STD_LOGIC;
          VS: out STD_LOGIC;
          BTN_UP: in STD_LOGIC;
          BTN_LEFT: in STD_LOGIC;
          BTN_RIGHT: in STD_LOGIC;
          BTN_DOWN: in STD_LOGIC;
          vgaGreen: out STD_LOGIC_VECTOR(3 downto 0);
          vgaBlue: out STD_LOGIC_VECTOR(3 downto 0);
          vgaRed: out STD_LOGIC_VECTOR(3 downto 0));
end Test_Square;

architecture Behavioral of Test_Square is

    component VGA_controller is
        Port ( CLK : in STD_LOGIC; -- pixel clock
               RST : in STD_LOGIC; -- reset, active high
               HS : out STD_LOGIC; -- horizontal sync
               VS : out STD_LOGIC; -- vertical sync
               HP : out STD_LOGIC_VECTOR (9 downto 0); -- horizontal position
               VP : out STD_LOGIC_VECTOR (9 downto 0); -- vertical position
               video_on: out STD_LOGIC);
    end component;
    
    component center_calculator is
        Port ( BTN_UP : in STD_LOGIC;
               BTN_DOWN : in STD_LOGIC;
               BTN_LEFT : in STD_LOGIC;
               BTN_RIGHT : in STD_LOGIC;
               CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               centerH : out STD_LOGIC_VECTOR (9 downto 0);
               centerV : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    
    component Frequency_Divider is
        Port ( CLK : in STD_LOGIC; --100MHz
               RST : in STD_LOGIC;
               PIXEL_CLK : out STD_LOGIC); -- 25MHz
    end component;
    
    component Draw_Square is
        Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
             VP: in STD_LOGIC_VECTOR(9 downto 0);
             centerH : in STD_LOGIC_VECTOR (9 downto 0);
             centerV : in STD_LOGIC_VECTOR (9 downto 0);
             draw: out STD_LOGIC);
end component;

    signal DIV_CLK : STD_LOGIC;
    signal HP : STD_LOGIC_VECTOR (9 downto 0);
    signal VP : STD_LOGIC_VECTOR (9 downto 0);
    signal video_on : STD_LOGIC;
    signal draw : STD_LOGIC;
    
    signal centerV : STD_LOGIC_VECTOR (9 downto 0);
    signal centerH : STD_LOGIC_VECTOR (9 downto 0);
    
    begin
    
        F: Frequency_Divider port map(CLK => CLK, RST => RST, PIXEL_CLK => DIV_CLK);
        V: VGA_controller port map(CLK => DIV_CLK, RST => RST, HS => HS, VS => VS, HP => HP, VP => VP, video_on => video_on);
        D: Draw_Square port map(HP => HP, VP => VP, centerH => centerH, centerV => centerV, draw => draw);
        C: center_calculator port map(BTN_UP => BTN_UP, BTN_DOWN => BTN_DOWN, BTN_LEFT => BTN_LEFT, BTN_RIGHT => BTN_RIGHT, CLK => CLK, RST => RST, centerH => centerH, centerV => centerV);
        
        
        vgaGreen <= "0000";
        vgaBlue <= "0000";
        
        vgaRed <= "0000" when draw = '0' or video_on = '0' else "1111";

end Behavioral;
