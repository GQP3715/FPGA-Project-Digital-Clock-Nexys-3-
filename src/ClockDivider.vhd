-- ==============================================================
-- Clock Divider
-- Input  : 100 MHz board clock
-- Output : 500 Hz clock (2 ms period)
-- Used for multiplexing and driving the clock counter
-- ==============================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDivider is
    Port (
        CLKIN   : in  STD_LOGIC;   -- 100 MHz input clock
        CLK2MS  : out STD_LOGIC    -- 500 Hz output clock
    );
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal count  : natural range 0 to 99999 := 0;
    signal clkout : STD_LOGIC := '0';
begin
    process(CLKIN)
    begin
        if rising_edge(CLKIN) then
            if count = 99999 then
                count  <= 0;
                clkout <= NOT clkout;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    CLK2MS <= clkout;
end Behavioral;
