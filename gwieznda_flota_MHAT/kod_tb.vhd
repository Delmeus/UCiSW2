library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity kod_tb is
end kod_tb;

architecture Behavioral of kod_tb is

    -- Constants
    constant CLOCK_PERIOD : time := 10 ns; -- Clock period (100 MHz)

    -- Signals
    signal zegar : std_logic := '0'; -- Clock signal
    signal znak : std_logic_vector(7 downto 0); -- Output symbol data
    signal znak_gotowy : std_logic; -- Output symbol ready signal
    signal go_to_beginning : std_logic; -- Output signal to indicate beginning

    -- Component instantiation
    component kod
        Port (
            zegar : in  STD_LOGIC;
            znak : out  STD_LOGIC_VECTOR (7 downto 0);
            znak_gotowy : out  STD_LOGIC;
            go_to_beginning : out STD_LOGIC
        );
    end component;

begin

    -- DUT instantiation
    DUT : kod
        port map (
            zegar => zegar,
            znak => znak,
            znak_gotowy => znak_gotowy,
            go_to_beginning => go_to_beginning
        );

    -- Clock process
    process
    begin
        while now < 1000 ns loop -- Simulate for 10 us
            zegar <= not zegar; -- Toggle the clock
            wait for CLOCK_PERIOD / 2; -- Wait half clock period
        end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
        wait for 10 ns; -- Wait for initial signals to stabilize
        -- Insert any additional stimulus here if needed

        -- Wait for simulation to finish
        wait;
    end process;

end Behavioral;
