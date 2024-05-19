library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tester is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           colorIn : in STD_LOGIC_VECTOR (2 downto 0);
           colorBGIn: in STD_LOGIC_VECTOR (2 downto 0);
           shapeIn : in STD_LOGIC_VECTOR (1 downto 0);
           BTN_UP : in STD_LOGIC;
           BTN_DOWN : in STD_LOGIC;
           BTN_LEFT : in STD_LOGIC;
           BTN_RIGHT : in STD_LOGIC;
           HS : out STD_LOGIC;
           VS : out STD_LOGIC;
           vgaRed : out STD_LOGIC_VECTOR (3 downto 0);
           vgaBlue : out STD_LOGIC_VECTOR (3 downto 0);
           vgaGreen : out STD_LOGIC_VECTOR (3 downto 0));
end Tester;

architecture Behavioral of Tester is
component Frequency_Divider is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PIXEL_CLK : out STD_LOGIC);
end component;
component VGA_controller is
    Port ( CLK : in STD_LOGIC; -- pixel clock
           RST : in STD_LOGIC; -- reset, active high
           HS : out STD_LOGIC; -- horizontal sync
           VS : out STD_LOGIC; -- vertical sync
           HP : out STD_LOGIC_VECTOR (9 downto 0); -- horizontal position
           VP : out STD_LOGIC_VECTOR (9 downto 0); -- vertical position
           video_on: out STD_LOGIC);
end component;
component Draw_Square is
    Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
         VP: in STD_LOGIC_VECTOR(9 downto 0);
         centerH : in STD_LOGIC_VECTOR (9 downto 0);
         centerV : in STD_LOGIC_VECTOR (9 downto 0);
         draw: out STD_LOGIC);
end component;
component Draw_Triangle is
        Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
             VP: in STD_LOGIC_VECTOR(9 downto 0);
             centerH : in STD_LOGIC_VECTOR (9 downto 0);
             centerV : in STD_LOGIC_VECTOR (9 downto 0);
             draw: out STD_LOGIC);
end component;
component Draw_Circle is
    Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
         VP: in STD_LOGIC_VECTOR(9 downto 0);
         centerH : in STD_LOGIC_VECTOR (9 downto 0);
         centerV : in STD_LOGIC_VECTOR (9 downto 0);
         draw: out STD_LOGIC);
end component;
component Draw_Diamond is
    Port(HP: in STD_LOGIC_VECTOR(9 downto 0);
             VP: in STD_LOGIC_VECTOR(9 downto 0);
             centerH : in STD_LOGIC_VECTOR (9 downto 0);
             centerV : in STD_LOGIC_VECTOR (9 downto 0);
             draw: out STD_LOGIC);
end component;
component Color_Selector is
    Port (
        switch : in STD_LOGIC_VECTOR(2 downto 0);
        selected_color : out STD_LOGIC_VECTOR(11 downto 0)
    );
end component;
component BGColor_Selector is
    Port (
        BGswitch : in STD_LOGIC_VECTOR(2 downto 0);
        selected_color : out STD_LOGIC_VECTOR(11 downto 0)
    );
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

signal H, V : std_logic_vector(9 downto 0); -- horizontal and vertical positions
signal PIXEL_CLK : std_logic;
signal draw_figure : std_logic;
signal draw1, draw2, draw3, draw4 : std_logic;
signal RGB : STD_LOGIC_VECTOR (11 downto 0);
signal BG_RGB : STD_LOGIC_VECTOR (11 downto 0);
signal video_on : std_logic;
signal ch, cv : std_logic_vector (9 downto 0); -- center coordinates

begin

    P1: Frequency_Divider port map (CLK => CLK, RST => RST, PIXEL_CLK => PIXEL_CLK);
    P2: VGA_controller port map (CLK => PIXEL_CLK, RST => RST, HS => HS, VS => VS, HP => H, VP => V, video_on => video_on);
    
    SHAPE1: Draw_Square port map (HP => H, VP => V, draw => draw1, centerH => ch, centerV => cv);
    SHAPE2: Draw_Triangle port map (HP => H, VP => V, draw => draw2, centerH => ch, centerV => cv);
    SHAPE3: Draw_Circle port map (HP => H, VP => V, draw => draw3, centerH => ch, centerV => cv);
    SHAPE4: Draw_Diamond port map (HP => H, VP => V, draw => draw4, centerH => ch, centerV => cv);
    
    P3: Color_Selector port map (switch => colorIn, selected_color => RGB);
    P4: center_calculator port map (CLK => CLK, RST => RST, BTN_UP => BTN_UP, BTN_DOWN => BTN_DOWN, BTN_RIGHT => BTN_RIGHT, BTN_LEFT => BTN_LEFT, centerH => ch, centerV => cv);
    P5: BGColor_Selector port map (BGswitch => colorBGIn, selected_color => BG_RGB);
    
    -- shape selector
    with shapeIn select draw_figure <= 
        draw1 when "00",  
        draw2 when "01",  
        draw3 when "10",  
        draw4 when "11";
        
    VGA_Colors: process
    
        begin
        
            -- display color only when video_on is true
            
            if video_on = '1' then
                if draw_figure = '1' then
                    vgaRed <= RGB(11 downto 8);
                    vgaGreen <= RGB(7 downto 4);
                    vgaBlue <= RGB(3 downto 0);
                else
                    vgaRed <= BG_RGB(11 downto 8);
                    vgaGreen <= BG_RGB(7 downto 4);
                    vgaBlue <= BG_RGB(3 downto 0);
                end if;
            else
                vgaRed <= "0000";
                vgaGreen <= "0000";
                vgaBlue <= "0000";
            end if;
 
        end process;
 
--            vgaRed <= RGB(11 downto 8) when video_on = '1' and draw_figure = '1' else "0000";
--            vgaGreen <= RGB(7 downto 4) when video_on = '1' and draw_figure = '1' else "0000";
--            vgaBlue <= RGB(3 downto 0) when video_on = '1' and draw_figure = '1' else "0000";
    
end Behavioral;























