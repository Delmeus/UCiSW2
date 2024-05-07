library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity kod_better is
	Port ( zegar : in  STD_LOGIC;
		   lewo : in STD_LOGIC;
		   prawo : in STD_LOGIC;
		   znak : out  STD_LOGIC_VECTOR (7 downto 0);
		   znak_gotowy : out  STD_LOGIC;
		   go_to_beginning : out STD_LOGIC)
	;
end kod_better;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Table_Package is
	type Table_Type is array (0 to 19, 0 to 47) of std_logic_vector(7 downto 0); -- Assuming each element is an 8-bit vector
end Table_Package;

use work.Table_Package.all;

architecture Behavioral of kod_better is

	signal zegar_dzielnik : std_logic_vector(31 downto 0) := X"00000000";
	signal temp : STD_LOGIC := '0';
	signal go_home_temp : STD_LOGIC := '0';
	signal myTable : Table_Type := (others => (others => "00000000"));
	signal obstacles : Table_Type := (others => (others => "00000000"));
	signal i : integer range 0 to 19 := 0;
	signal j : integer range 0 to 47 := 0;
	signal ship_x : integer range 0 to 47 := 24;
	signal ship_y : integer range 0 to 19 := 17;
	signal tablica_gotowa : STD_LOGIC := '0';

	signal lfsr : std_logic_vector(5 downto 0) := (others => '0');


begin
	process1: process(zegar)
	begin
		if rising_edge(zegar) then
			-- czyszczenie całej tablicy
			--go_home_temp <= '0';
			tablica_gotowa <= '0';
			for y in 0 to 19 loop
				for x in 0 to 47 loop
					if x = ship_x and y = ship_y then
						myTable(y,x) <= X"0A";
					elsif obstacles(x,y) /= X"00" then
						myTable(y,x) <= X"10";
					else
						myTable(y,x) <= X"00";
					end if;
				end loop;
			end loop;
			--myTable(0,35) <= X"1C";
			--myTable(10,15) <= X"01";
			--znak <= myTable(i, j);
			--temp <= '1';
			j <= j + 1;
			if j = 47 then
				j <= 0;
				i <= i + 1;
				if i = 19 then
					i <= 0;
					--go_home_temp <= '1';
				end if;
			end if;
			tablica_gotowa <= '1';
		end if;
	end process process1;


	process2: process(zegar)
	begin
		if rising_edge(zegar) then
			if tablica_gotowa = '1' then
				-- Output the symbol data
				znak <= myTable(i, j);
				-- Signal that the symbol is ready to be printed
				znak_gotowy <= '1';
			else
				-- Symbol not ready, output default data (e.g., blank)
				znak <= (others => '0');
				znak_gotowy <= '0';
			end if;
		end if;
	end process process2;

	process_control: process(zegar)
		variable delay_counter : integer range 0 to 249999 := 0;
	begin
		if rising_edge(zegar) then
			-- dac counter jak w obstacles
			-- zegar_dzielnik <= std_logic_vector(unsigned(zegar_dzielnik)+1);
			-- if zegar_dzielnik = X"000FFFFF" then
			-- 	zegar_dzielnik <= X"00000000";
			if delay_counter < 249999 then
				delay_counter := delay_counter + 1;
			else
				if lewo = '1' then
					ship_x <= ship_x-1;
				elsif prawo = '1' then
					ship_x <= ship_x+1;
				end if;
			end if;
		end if;
	end process process_control;

	process_obstacles: process(zegar)
		variable delay_counter : integer range 0 to 24999999 := 0; -- Assuming 50 MHz clock, 500 ms delay
		variable random_counter : integer range 0 to 10 := 7;
	begin
		if rising_edge(zegar) then
			if delay_counter < 24999999 then
				delay_counter := delay_counter + 1;
			else
				delay_counter := 0;
				-- Causing obstacles to fall - wygląda legitnie
				for y in 19 downto 0 loop
					for x in 47 downto 0 loop
						if obstacles(y,x) = X"10" then
							obstacles(y,x) <= X"00";
							if y < 19 then -- ewentualnie 18
								obstacles(y+1,x) <= X"10";
							end if;
						end if;
					end loop;
				end loop;
				-- Generate new obstacles
				random_counter <= random_counter + 1;
				if random_counter = 9 then
					random_counter <= 0;
					lfsr(5 downto 1) <= lfsr(4 downto 0);
					lfsr(0) <= lfsr(5) xor lfsr(3) xor lfsr(2);
					if unsigned(lfsr) < 48 then
						obstacles(0, to_integer(unsigned(lfsr))) <= X"10";
					else
						obstacles(0, to_integer(unsigned(lfsr) mod 32)) <= X"10";
					end if;

					-- Flaga losowania - do usunięcia
					if obstacles(10,10) = X"00" then
						obstacles(10,10) <= X"15";
					else
						obstacles(10,10) <= X"00";
					end if;

				end if;
			end if;
		end if;
	end process process_obstacles;

	--go_to_beginning <= go_home_temp;
end Behavioral;