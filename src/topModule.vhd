-- ==============================================================
-- Top Module
-- Instantiates Clock Divider, Clock Counter, and Display Controller
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topModule is
    Port (
        CLKIN    : in  STD_LOGIC;                 -- 100 MHz clock input
        AN       : out STD_LOGIC_VECTOR (3 downto 0); -- Anodes
        CATHODES : out STD_LOGIC_VECTOR (7 downto 0)  -- Cathodes
    );
end topModule;

architecture Behavioral of topModule is
    signal clk_500hz : STD_LOGIC;
    signal digit0, digit1, digit2, digit3 : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Clock Divider (100 MHz → 500 Hz)
    clk_div : entity work.ClockDivider
        port map (
            CLKIN  => CLKIN,
            CLK2MS => clk_500hz
        );

    -- Clock Counter (minutes & hours)
    counter : entity work.clockCounter
        port map (
            DIGIT0 => digit0,
            DIGIT1 => digit1,
            DIGIT2 => digit2,
            DIGIT3 => digit3,
            CLK2MS => clk_500hz
        );

    -- Display Controller (7-seg multiplexing)
    display : entity work.sevenSegmentController
        port map (
            DIGIT0   => digit0,
            DIGIT1   => digit1,
            DIGIT2   => digit2,
            DIGIT3   => digit3,
            AN       => AN,
            CATHODES => CATHODES,
            CLK2MS   => clk_500hz
        );
end Behavioral;
