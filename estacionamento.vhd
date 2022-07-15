LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity estacionamento is
	port (
		-- Entradas
		
		placaCapturada : in std_logic;
		botaoEntrada : in std_logic;
		sensorEntrada : in std_logic;
		sensorSaida : in std_logic;
        ticketOk : in std_logic;
		
		
		clock : in std_logic;
		clear : in std_logic;
		
		
		-- Saidas 

		selecionaMensagem : out std_logic;
		imprimeTicket : out std_logic;
		dadosImpressao : out std_logic;
		entradaAberto : out std_logic;
		saidaAberto : out std_logic;
		salvaDados : out std_logic;
        ticketRegClr : out std_logic

    );
end estacionamento;

architecture RTLestacionamento of estacionamento is

component DataPath is
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
end component DataPath;

component Controladora is
    port ( 
		--Entradas--

		placaCapturada : in std_logic;
		botaoEntrada : in std_logic;
		sensorEntrada : in std_logic;
		sensorSaida : in std_logic;
        ticketOk : in std_logic;
		
		
		clock : in std_logic;
		clear : in std_logic;
		
		--Saídas--
		
		selecionaMensagem : out std_logic;
		imprimeTicket : out std_logic;
		dadosImpressao : out std_logic;
		entradaAberto : out std_logic;
		saidaAberto : out std_logic;
		salvaDados : out std_logic;
        ticketRegClr : out std_logic
    );

end component Controladora;

-- Signals entre Controladora e Datapath -- 

signal aux_total_itens_lt_32 : std_logic;
signal aux_saldo_lt_total : std_logic;
signal aux_ld_total : std_logic;
signal aux_clr_total : std_logic;
signal aux_ld_total_itens : std_logic;
signal aux_clr_total_itens : std_logic;
signal aux_add_sel : std_logic;
signal aux_del_sel : std_logic;

begin
										  
	A_Controladora : Controladora
		port map (
			inicia_compra => inicia_compra,
			finaliza_compra => finaliza_compra,
			cancelar => cancelar,
			pagar_compra => pagar_compra,
			cartao_lido => cartao_lido,
			add => add,
			del => del,
			clock => clock,
			clear => clear_controladora,
			total_itens_lt_32 => aux_total_itens_lt_32,
			saldo_lt_total => aux_saldo_lt_total,
			ld_total => aux_ld_total,
			clr_total => aux_clr_total,
			ld_total_itens => aux_ld_total_itens,
			clr_total_itens => aux_clr_total_itens,
			erro => erro,
			concluido => concluido,
			desconta => desconta,
			ler_pagamento => ler_pagamento,
			add_sel => aux_add_sel,
			del_sel => aux_del_sel
		);
		
	B_DataPath : DataPath  
		port map (
			valor_produto => valor_produto,
			saldo_cartao => saldo_cartao,
			clock => clock,
			ld_total => aux_ld_total,
			clr_total => aux_clr_total,
			ld_total_itens => aux_ld_total_itens,
			clr_total_itens => aux_clr_total_itens,
			saldo_restante => saldo_restante,
			valor_compra => valor_compra,
			quantidade_itens => quantidade_itens,
			total_itens_lt_32 => aux_total_itens_lt_32,
			saldo_lt_total => aux_saldo_lt_total,
			add_sel => aux_add_sel,
			del_sel => aux_del_sel
		);

end RTLestacionamento ;