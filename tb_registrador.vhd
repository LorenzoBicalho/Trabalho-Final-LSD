library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_registrador is

generic(
		DATA_WIDTH : natural := 16
);

end tb_registrador;

architecture tb of tb_registrador is

component registrador is
	port(
	clk			: in std_logic;
	clr			: in std_logic;
	ld			: in std_logic;
	entrada     : in  std_logic_vector((DATA_WIDTH - 1) downto 0);
	saida		: out  std_logic_vector((DATA_WIDTH - 1) downto 0)
);
end component;
signal clk,clr,ld : std_logic := '0';
signal entrada, saida : std_logic_vector((DATA_WIDTH-1) downto 0);

begin
instancia_registrador: registrador port map(clk => clk, clr => clr, ld => ld, entrada => entrada, saida => saida);
entrada <= x"0000", x"0001" after 20 ns, x"0002" after 40 ns, x"0003" after 60 ns;
clk <= not clk after 1 ns;
clr <= '1' after 50 ns, '0' after 51 ns;
ld <= not ld after 5 ns;
end tb;