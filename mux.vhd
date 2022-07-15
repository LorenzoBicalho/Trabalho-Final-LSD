library ieee;
use ieee.std_logic_1164.all;

entity mux is
	generic (
    	DATA_WIDTH : natural := 16
    );
	port(
      	a 		: in std_logic_vector((DATA_WIDTH -1) downto 0);
      	b 		: in std_logic_vector((DATA_WIDTH -1) downto 0);
      	enable 	: in std_logic;
      	saida 	: out std_logic_vector((DATA_WIDTH -1) downto 0)
    );
end mux;

architecture behavior of mux is
begin
  process(enable, a, b)
  begin
    if(enable = '0') then
      saida <= a;
    else
      saida <= b;
  end if;
end process;
end behavior;