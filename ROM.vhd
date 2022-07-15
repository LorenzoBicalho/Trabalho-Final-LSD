LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- MEMÓRIA EEPROM
ENTITY EEPROM IS
	GENERIC (
		ADDR_LENGHT : NATURAL := 2;
		R_LENGHT : NATURAL := 16;
		NUM_OF_REGS : NATURAL := 32
	);
	PORT (
		clk : IN STD_LOGIC;
		wr : IN STD_LOGIC;
		addr : IN STD_LOGIC_VECTOR (ADDR_LENGHT - 1 DOWNTO 0);
		datain : IN STD_LOGIC_VECTOR (R_LENGHT - 1 DOWNTO 0);
		dataout : OUT STD_LOGIC_VECTOR (R_LENGHT - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE ROM_REGISTER OF EEPROM IS
	TYPE rom_reg IS ARRAY (0 TO NUM_OF_REGS - 1) OF
	STD_LOGIC_VECTOR (R_LENGHT - 1 DOWNTO 0);
	SIGNAL rom_s : rom_reg;

BEGIN
	PROCESS (clk)
		VARIABLE loc : INTEGER;
	BEGIN
		IF (rising_edge(clk)) THEN
			loc := to_integer(unsigned(addr));
			IF (wr = '1') THEN
				rom_s(loc) <= datain;
			END IF;
			dataout <= rom_s(loc);
		END IF;
	END PROCESS;
END ARCHITECTURE ROM_REGISTER;