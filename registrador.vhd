library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrador is
	generic(
		DATA_WIDTH : natural := 16
	);

	port(
		clk			: in std_logic;
		clr			: in std_logic;
		ld			: in std_logic;
		entrada		: in  std_logic_vector((DATA_WIDTH - 1) downto 0);
		saida		: out  std_logic_vector((DATA_WIDTH - 1) downto 0)
);
end registrador;

architecture rtl of registrador is

begin
	process(clk, clr)
	begin
		if clr = '1' then
			saida <= (others=>'0');
		elsif (rising_edge(clk) and ld = '1') then
			saida <= entrada;
		end if;

	end process;
end rtl;