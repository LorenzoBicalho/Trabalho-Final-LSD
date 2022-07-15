library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	generic (
		ADDR_LENGHT : natural := 2;
		R_LENGHT : natural := 16;
		REGS : natural := 16
	);
	port (
		clk : in std_logic;
		wr : in std_logic;
		addr : in std_logic_vector (ADDR_LENGHT - 1 downto 0);
		data_in : in std_logic_vector (R_LENGHT - 1 downto 0);
		data_out : out std_logic_vector (R_LENGHT - 1 downto 0)
	);
end entity;

architecture rom_register of rom is
	type rom_reg is array (0 to REGS - 1) of
	std_logic_vector(R_LENGHT - 1 downto 0);
	signal rom_s : rom_reg;

begin
	process (clk)
		variable loc : integer;
	begin
		if (rising_edge(clk)) then
			loc := to_integer(unsigned(addr));
			if (wr = '1') then
				rom_s(loc) <= data_in;
			end if;
			data_out <= rom_s(loc);
		end if;
	end process;
end architecture rom_register;