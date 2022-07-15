library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ram is
  port(
       data_in : in std_logic_vector(7 downto 0);
       addressess : in std_logic_vector(7 downto 0);
       w_r : in std_logic;
       data_out : out std_logic_vector(7 downto 0)
       );
end entity;

architecture behavior of ram is

type mem is array (255 downto 0) of std_logic_vector(7 downto 0);
signal MEMORY : mem;
signal ADDRESS : integer range 0 to 255;

begin

  process(addressess, data_in, w_r)
  begin

    ADDRESS <= conv_integer(addressess);
    if(w_r='0') then
      MEMORY(address) <= data_in;
    elsif(w_r='1') then
      data_out <= MEMORY(ADDRESS);
    else
      data_out <= "ZZZZZZZZ";
    end if;
  end process;

end behavior;
