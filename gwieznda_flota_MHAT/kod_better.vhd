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
signal przeszkody : Table_Type := (others => (others => "00000000"));
signal i : integer range 0 to 19 := 0;
signal j : integer range 0 to 47 := 0;
signal statek_y : integer range 0 to 47 := 24;
signal statek_x : integer range 0 to 19 := 17;
signal tablica_gotowa : STD_LOGIC := '0';

--signal losowanie_dzielnik : std_logic_vector(127 downto 0) := X"00000000000000000000000000000000";
signal lfsr : std_logic_vector(5 downto 0) := (others => '0');
constant RANDOM_GENERATION_FREQUENCY : integer := 50000000 * 10; -- Assuming a 50 MHz clock, generates random number every 3 seconds
signal losowanie_dzielnik : std_logic_vector(31 downto 0) := (others => '0');
signal opadanie_dzielnik : std_logic_vector(31 downto 0) := (others => '0');

begin
process1: process(zegar)
	begin
		if rising_edge(zegar) then	
			-- czyszczenie ca�ej tablicy
			--go_home_temp <= '0';
			tablica_gotowa <= '0';
			for x in 0 to 19 loop
				for y in 0 to 47 loop
					if x = statek_x and y = statek_y then
						myTable(x,y) <= X"0A";
					elsif przeszkody(x,y) /= X"00" then
						myTable(x,y) <= X"10";
					else
						myTable(x,y) <= X"00";
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

process_sterowanie: process(zegar)
	begin
		if rising_edge(zegar) then
			zegar_dzielnik <= std_logic_vector(unsigned(zegar_dzielnik)+1);
			if zegar_dzielnik = X"000FFFFF" then
				zegar_dzielnik <= X"00000000";
				if lewo = '1' then
					statek_y <= statek_y-1;
				elsif prawo = '1' then
					statek_y <= statek_y+1;
				end if;
			end if;
		end if;
end process process_sterowanie;



process_przeszkody: process(zegar)
	begin
		if rising_edge(zegar) then
			--losowanie_dzielnik <= std_logic_vector(unsigned(losowanie_dzielnik)+1);
			--opadanie_dzielnik <= std_logic_vector(unsigned(opadanie_dzielnik)+1);
			--if opadanie_dzielnik = X"0000000000000000000000000000000F" then--if opadanie_dzielnik = X"0000000000000000000FFFFFFFFFFFFF" then
				--opadanie_dzielnik <= X"00000000000000000000000000000000";
				--for x in 19 downto 0 loop
					--for y in 47 downto 0 loop
						--if przeszkody(x,y) = X"10" then
							--przeszkody(x,y) <= X"00";
							--if x > 0 then
								--przeszkody(x-1,y) <= X"10";
							--end if;
						--end if;
					--end loop;
				--end loop;
			--end if;
			--if losowanie_dzielnik =  X"00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" then--if losowanie_dzielnik = X"000000000000000000FFFFFFFFFFFFFF" then
				--losowanie_dzielnik <= X"00000000000000000000000000000000";
				--lfsr(5 downto 1) <= lfsr(4 downto 0);
            -- Generate pseudo-random bit
            --lfsr(0) <= lfsr(5) xor lfsr(3) xor lfsr(2);
				--if unsigned(lfsr) < 48 then
					--przeszkody(0, to_integer(unsigned(lfsr))) <= X"10";
				--else
					--przeszkody(0, to_integer(unsigned(lfsr) mod 32)) <= X"10";
				--end if;
				--if przeszkody(10,10) = X"00" then
					--przeszkody(10,10) <= X"15";
				--else
					--przeszkody(10,10) <= X"00";
				--end if;
			--end if;
			if losowanie_dzielnik = X"0FFFFFFF" then
            -- Reset the divider
            losowanie_dzielnik <= (others => '0');
            lfsr(5 downto 1) <= lfsr(4 downto 0);
            -- Generate pseudo-random bit
            lfsr(0) <= lfsr(5) xor lfsr(3) xor lfsr(2);
				if unsigned(lfsr) < 48 then
					przeszkody(0, to_integer(unsigned(lfsr))) <= X"10";
				else
					przeszkody(0, to_integer(unsigned(lfsr) mod 32)) <= X"10";
				end if;
				if przeszkody(10,10) = X"00" then
					przeszkody(10,10) <= X"15";
				else
					przeszkody(10,10) <= X"00";
				end if;
            -- Generate random number
            -- Your random number generation logic here
            
            -- Perform other actions associated with random generation
        else
            -- Increment the divider
            losowanie_dzielnik <= std_logic_vector(unsigned(losowanie_dzielnik) + 1);
        end if;
		end if;
    end process process_przeszkody;

--znak_gotowy <= temp;
--go_to_beginning <= go_home_temp;
end Behavioral;