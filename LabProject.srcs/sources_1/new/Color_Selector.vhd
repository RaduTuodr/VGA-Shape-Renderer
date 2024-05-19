library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Color_Selector is
    Port (
        switch : in STD_LOGIC_VECTOR(2 downto 0);
        selected_color : out STD_LOGIC_VECTOR(11 downto 0)
    );
end Color_Selector;

architecture Behavioral of Color_Selector is
    -- Define the RGB colors/vectors
    constant COLOR_0 : STD_LOGIC_VECTOR(11 downto 0) := "0000" & "0000" & "1111"; -- Blue
    constant COLOR_1 : STD_LOGIC_VECTOR(11 downto 0) := "1111" & "0000" & "0000"; -- Red
    constant COLOR_2 : STD_LOGIC_VECTOR(11 downto 0) := "0000" & "1111" & "0000"; -- Green
    constant COLOR_3 : STD_LOGIC_VECTOR(11 downto 0) := "1111" & "1111" & "0000"; -- Yellow
    constant COLOR_4 : STD_LOGIC_VECTOR(11 downto 0) := "1111" & "0000" & "1111"; -- Magenta
    constant COLOR_5 : STD_LOGIC_VECTOR(11 downto 0) := "0000" & "1111" & "1111"; -- Cyan
    constant COLOR_6 : STD_LOGIC_VECTOR(11 downto 0) := "1100" & "1100" & "1100"; -- Gray
    constant COLOR_7 : STD_LOGIC_VECTOR(11 downto 0) := "1111" & "1111" & "1111"; -- White
    
    begin
    -- Output the selected color based on the input switch value

    Color_Selection:process
        begin
            if switch = "000" then
                selected_color <= COLOR_0;
            elsif switch = "001" then
                selected_color <= COLOR_1;
            elsif switch = "010" then
                selected_color <= COLOR_2;
            elsif switch = "011" then
                selected_color <= COLOR_3;
            elsif switch = "100" then
                selected_color <= COLOR_4;
            elsif switch = "101" then
                selected_color <= COLOR_5;
            elsif switch = "110" then
                selected_color <= COLOR_6;
            else
                selected_color <= COLOR_7;
            end if;
    end process;
end Behavioral;
