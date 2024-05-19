library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA_controller is
    Port ( CLK : in STD_LOGIC; -- pixel clock
           RST : in STD_LOGIC; -- reset, active high
           HS : out STD_LOGIC; -- horizontal sync
           VS : out STD_LOGIC; -- vertical sync
           HP : out STD_LOGIC_VECTOR (9 downto 0); -- horizontal position
           VP : out STD_LOGIC_VECTOR (9 downto 0); -- vertical position
           video_on: out STD_LOGIC);
end VGA_controller;
-- HP tahes values from 0 to 799; we display only from 0 to 639
-- VP tahes values from 0 to 521; we display only from 0 to 479

architecture Behavioral of VGA_controller is

    signal countH : std_logic_vector (9 downto 0) := (others => '0');
    signal countV : std_logic_vector (9 downto 0) := (others => '0');
    
    constant HD : integer := 640; -- Horizontal Display
    constant HF : integer := 16; -- Horizontal Front Porch
    constant HB : integer := 48; -- Horizontal Back Porch
    constant HPW : integer := 96; -- Horizontal Pulse Width
    constant HMAX : integer := 800; -- Horizontal Sync Pulse
    
    constant VD : integer := 480; -- Vertical Display
    constant VF : integer := 10; -- Vertical Front Porch
    constant VB : integer := 29; -- Vertical Back Porch
    constant VPW : integer := 2; -- Vertical Pulse Width
    constant VMAX : integer := 521; -- Vertical Sync Pulse
   
begin

    -- HMAX = HD + HF + HPW + HB
    HS_counter: process(CLK) 
    begin
        if rising_edge(CLK) then
            if RST = '1' or countH = HMAX then
                countH <= (others => '0');
            else
                countH <= countH + 1;
            end if;
        end if;
    end process;
    
    -- VMAX = VD + VF + VPW + VB
    VS_counter: process(CLK) 
    begin
        if rising_edge(CLK) then
            if countH = HMAX then
                if RST = '1' or countV = VMAX then
                    countV <= (others => '0');
                else
                    countV <= countV + 1;
                end if;
            end if;
        end if;
    end process;
    
    HP <= countH; -- Horizontal Position   
    VP <= countV; -- Vertical Position 
    
    -- Horizontal Sync is 0 during Pulse Width
    HS <= '0' when countH >= HD + HF - 1 and countH <= HD + HF + HPW - 1 else '1';
    
    -- Vertical Sync is 0 during Pulse Width
    VS <= '0' when countV >= VD + VF - 1 and countV <= VD + VF + VPW - 1 else '1';
    
    -- we display when HP in [0,639] and VP in [0,479]
    video_on <= '1' when countH < HD and countV < VD else '0';

end Behavioral;
