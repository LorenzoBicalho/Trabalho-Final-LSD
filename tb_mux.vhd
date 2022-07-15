library ieee;
use ieee.std_logic_1164.all;

entity tb_mux is
	generic (
    	DATA_WIDTH : natural := 16
    );
end tb_mux;

architecture teste of tb_mux is
component mux
	port(
      	a 		: in std_logic_vector((DATA_WIDTH - 1) downto 0);
      	b 		: in std_logic_vector((DATA_WIDTH - 1) downto 0);
      	enable 	: in std_logic;
      	saida 	: out std_logic_vector((DATA_WIDTH - 1) downto 0)
    );
end component;

signal A : std_logic_vector((DATA_WIDTH - 1) downto 0);
signal B : std_logic_vector((DATA_WIDTH - 1) downto 0);
signal ENABLE : std_logic;
signal SAIDA : std_logic_vector((DATA_WIDTH - 1) downto 0);

begin
  instancia_mux : mux port map(a=>A, b=>B, enable=>ENABLE, saida=>SAIDA);
  A <= x"0000", x"0004" after 10 ns, x"0008" after 20 ns, x"0002" after 30 ns, x"0005" after 40 ns;
  B <= x"0000", x"0003" after 10 ns, x"0001" after 20 ns, x"0009" after 30 ns, x"0007" after 40 ns;
  ENABLE <= '0', '0' after 10 ns, '1' after 20 ns, '1' after 30 ns, '1' after 40 ns;
end teste;