library ieee;
use ieee.std_logic_1164.all;

entity DataPath is
   port (
		-- ENTRADAS --
		dadosLeitorQr : in std_logic_vector(15 downto 0);
		dadosPlaca : in std_logic_vector(15 downto 0);
		
		addrLeitorQr : in std_logic;
		selecionaMensagem : in std_logic;
		entradaAberto : in std_logic;
		salvaDados : in std_logic;
        ticketRegClr : in std_logic;
		
		
		clock : in std_logic;
		
		-- SAIDAS --
		mensagem : out std_logic_vector(15 downto 0);
		
		addrTicket : out std_logic;
		ticketOk : out std_logic
    );
end DataPath;


architecture RTLDataPath of DataPath is

component mux2x1 is
	port (
			CurrentChange : in std_logic_vector(9 downto 0);
			CurrentMoney : in std_logic_vector(9 downto 0);
			ChaveRetorno : in std_logic;
			ReturnValue : out std_logic_vector(9 downto 0)
		);
END component;

component incrementador is
	port (	
		x 	: in std_logic_vector(6 downto 0);
		s 		: out std_logic_vector(6 downto 0)
	);
end component;

component comparador is
	port (
			FirstNumber : in std_logic_vector(15 downto 0);
			SecondNumber : in std_logic_vector(15 downto 0);
			First_lt_Second : out std_logic
		)

end component;

component ROM is
		generic (
			ADDR_LENGHT : natural := 5;
			R_LENGHT : natural := 16;
			NUM_of_REGS : natural := 32
		);
		port (
			clk : in std_logic;
			wr : in std_logic;
			addr : in std_logic_vector (ADDR_LENGHT - 1 downto 0);
			datain : in std_logic_vector (R_LENGHT - 1 downto 0);
			dataout : out std_logic_vector (R_LENGHT - 1 downto 0)
		);
end component;

component RAM is
        port(
             DATAIN : in std_logic_vector(7 downto 0);
             ADDRESS : in std_logic_vector(7 downto 0);
             -- Write when 0, Read when 1
             W_R : in std_logic;
             DATAout : out std_logic_vector(7 downto 0)
             );
end component;

component registrador is
		generic (n : natural := 10);
		port (
			entrada : in std_logic_vector(n - 1 downto 0);
			clk : in std_logic;
			rst : in std_logic;
			load : in std_logic;
			saida : out std_logic_vector(n - 1 downto 0)
		);
end component;


signal aux_E_C : std_logic_vector(15 downto 0);
signal aux_B_F, aux_A_E : std_logic_vector(9 downto 0);

begin

-- Componentes --
A_Mux_2x1 : mux2x1 
	port map(CurrentChange => addrLeitorQr, CurrentMoney => addrTicket, ChaveRetorno => salvaDados, ReturnValue => aux_A_E);
    
B_incrementador : incrementador
	port map(x=>addrTicket,s=>aux_B_F);
	
C_Comparador : comparador
	port map(valor_total=>dadosLeitorQr,saldo_cartao=>aux_E_C,saldo_lt_total=>ticketOk);

D_ROM : ROM 
	port map(clk => CLOCK, wr => MEM_wr, addr => selecionaMensagem, datain => MEM_data_input, dataout => mensagem);

E_RAM : RAM 
	port map(dadosPlaca => DATAin, aux_A_E => ADDRESS, salvaDados => W_R, aux_E_C => DATAout);
    
F_Registrador : registrador 
	port map(clk => CLOCK, aux_B_F => SLC, ticketRegClr => SLC_PRODUCT_clr, entradaAberto => SLC_PRODUCT_ld, addrTicket => caboD_HI);


end RTLDataPath ;