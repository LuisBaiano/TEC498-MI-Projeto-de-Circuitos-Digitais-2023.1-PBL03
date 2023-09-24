module Controla_Display(
	input clk0, clk3, sinal_cancel, V_sense,      // Entradas de clock e V_sense
	input [2:0] chaves_cedulas,     // Entrada para as chaves de cédulas
	input [3:0] botoes,             // Entrada para os botões
	output[3:0] digitos,            // Saída para os dígitos
	output[6:0] segments,           // Saída para os segmentos
	output Valor_verificado,        // Saída para o valor verificado
	output LED_Verm, LED_Verde, LED_Azul  // Saídas para os LEDs Vermelho, Verde e Azul
);

	// Fios (wires) para sinais auxiliares
	wire Exibe_Bebida, Exibe_Valor, D_valor;
	
	// Fio (wire) para os botões
	wire [3:0] bt;
	
	// Fio (wire) para a seleção
	wire [2:0] select;
	
	// Fios (wires) para os dígitos
	wire [3:0] digito1, digito2, digito3;
	
	// Fios (wires) para os segmentos
	wire [6:0] segmentos1, segmentos2, segmentos3;

	// Conversão de nível para pulso para cada botão usando o clock clk3
	level_to_pulse(clk3, botoes[0], bt[0]);
	level_to_pulse(clk3, botoes[1], bt[1]);
	level_to_pulse(clk3, botoes[2], bt[2]);
	level_to_pulse(clk3, botoes[3], bt[3]);

	// Verifica a compra com base nas chaves de cédulas e botões
	Verificador_Compra(chaves_cedulas, bt, D_valor);

	// Contador para a seleção de dígitos
	Contador(clk0, select);

	// Módulo de exibição de erro do display
	Display_Erro(clk0, V_sense, D_valor, select, digito1, segmentos1);

	// Módulo de exibição de bebida do display
	Display_Bebida(sinal_cancel, bt, chaves_cedulas, V_sense, D_valor, digito2, segmentos2, Exibe_Bebida);

	// Módulo de exibição de valor do display
	Display_Valor(sinal_cancel, chaves_cedulas, V_sense, select, digito3, segmentos3, Exibe_Valor);

	// Lógica para atribuir os valores corretos aos dígitos e segmentos de acordo com as condições
	assign digitos = (V_sense | D_valor) ? digito1 : (Exibe_Bebida ? digito2 : (Exibe_Valor ? digito3 : 4'b1111));
	assign segments = (V_sense | D_valor) ? segmentos1 : (Exibe_Bebida ? segmentos2 : (Exibe_Valor ? segmentos3 : 7'b1111111));

	assign Valor_verificado = D_valor;
	wire valor_inserido;
	or(valor_inserido, chaves_cedulas[0], chaves_cedulas[1], chaves_cedulas[2]);

	wire AND1_LED_Verde, AND2_LED_Verde;
	and(AND1_LED_Verde, !sinal_cancel, !valor_inserido, !V_sense);
	and(AND2_LED_Verde, !V_sense, sinal_cancel, !valor_inserido);
	or(LED_Verde, AND1_LED_Verde, AND2_LED_Verde);
	and(LED_Verm, !V_sense, valor_inserido, !sinal_cancel);
	or(LED_Azul, D_valor, V_sense);
	
endmodule

