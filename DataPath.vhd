LIBRARY ieee;
USE ieee.std_logic_1164.all;

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


architecture RTLDataPath OF DataPath is

component mux2x1 IS
	PORT (
			CurrentChange : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			CurrentMoney : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			ChaveRetorno : IN STD_LOGIC;
			ReturnValue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
END component;

component incrementador is
	port (	
		x 	: in std_logic_vector(6 downto 0);
		s 		: out std_logic_vector(6 downto 0)
	);
end component;

component comparador is
	PORT (
			FirstNumber : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			SecondNumber : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			First_lt_Second : OUT STD_LOGIC
		)

end component;

component ROM IS
		GENERIC (
			ADDR_LENGHT : NATURAL := 5;
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
end component;

component RAM IS
        PORT(
             DATAIN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
             ADDRESS : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
             -- Write when 0, Read when 1
             W_R : IN STD_LOGIC;
             DATAOUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
             );
end component;

component registrador IS
		GENERIC (n : NATURAL := 10);
		PORT (
			entrada : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			load : IN STD_LOGIC;
			saida : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
end component;


signal aux_E_C : std_logic_vector(15 downto 0);
signal aux_B_F, aux_A_E : std_logic_vector(9 downto 0);

begin

-- Componentes --

A_Mux_2x1 : mux2x1 
	port map(CurrentChange => addrLeitorQr, CurrentMoney => addrTicket, ChaveRetorno => salvaDados, ReturnValue => aux_A_E);
    
B_Incrementador : incrementador
	port map(x=>addrTicket,s=>aux_B_F);
	
C_Comparador : comparador
	port map(valor_total=>dadosLeitorQr,saldo_cartao=>aux_E_C,saldo_lt_total=>ticketOk);

D_ROM : ROM 
	port map(clk => CLOCK, wr => MEM_wr, addr => selecionaMensagem, datain => MEM_data_input, dataout => mensagem);

E_RAM : RAM 
	port map(dadosPlaca => DATAIN, aux_A_E => ADDRESS, salvaDados => W_R, aux_E_C => DATAOUT);
    
F_Registrador : registrador 
	port map(clk => CLOCK, aux_B_F => SLC, ticketRegClr => SLC_PRODUCT_clr, entradaAberto => SLC_PRODUCT_ld, addrTicket => caboD_HI);


end RTLDataPath ;