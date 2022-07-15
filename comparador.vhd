library ieee;
use ieee.std_logic_1164.all;

entity comparador is
	generic (
		DATA_WIDTH : natural := 16
    );

	port (
      a : in std_logic_vector((DATA_WIDTH - 1) downto 0);
      b : in std_logic_vector((DATA_WIDTH - 1) downto 0);
      a_eq_b : out std_logic
    );
	
end comparador;

architecture behavior of comparador is
begin
  process(a, b)
  begin
    if(a = b) then
      a_eq_b <= '1';
    else
      a_eq_b <= '0';
  	end if;
	end process;
end behavior;